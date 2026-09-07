# MemoriO Congrats LP — 開発・デプロイ用コマンド集
#
#   make          → コマンド一覧
#   make dev      → ローカルで見る
#   make build    → 検証 + OG画像生成
#   make ship m="変更内容"  → 検証・コミット・push（本番反映）
#
# このLPはビルド不要の静的サイト。`build` は「検証と画像生成」を指す。

SHELL      := /bin/bash
.DEFAULT_GOAL := help

SITE       := https://www.memorio.gift
PORT       ?= 8000
BRANCH     := main
OG_SRC     := assets/og-image.png
OG_OUT     := assets/og-image-1200.jpg
MV_SRC     := assets/main-visual.png
HEAVY_KB   := 500

C_OK  := \033[32m
C_WRN := \033[33m
C_NG  := \033[31m
C_DIM := \033[2m
C_END := \033[0m

.PHONY: help dev open build check og weigh verify status ship deploy prod preview clean

## ---------------------------------------------------------------- help ---

help: ## コマンド一覧を表示
	@echo ""
	@echo "  MemoriO Congrats LP"
	@echo -e "  $(C_DIM)本番: $(SITE)$(C_END)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo -e "  $(C_DIM)例: make ship m=\"LINE QRを追加\"$(C_END)"
	@echo ""

## --------------------------------------------------------------- 開発 ---

dev: ## ローカルサーバーを起動（http://localhost:8000）
	@echo -e "$(C_OK)→ http://localhost:$(PORT)$(C_END)  停止は Ctrl+C"
	@python3 -m http.server $(PORT)

open: ## 本番サイトをブラウザで開く
	@open $(SITE)

## --------------------------------------------------------------- build ---

build: check og ## 検証 + OG画像生成（本番化の前に通す）
	@echo -e "$(C_OK)build 完了$(C_END)"

check: ## index.html を静的検査（タグ・参照・OGP・LINE URL）
	@echo -e "$(C_DIM)-- check --$(C_END)"
	@python3 tools/check.py

og: $(OG_OUT) ## OG画像を 1200x630 JPEG に生成（4.2MB → 130KB）

$(OG_OUT): $(OG_SRC)
	@echo -e "$(C_DIM)-- og image --$(C_END)"
	@sips -s format jpeg -s formatOptions 82 -Z 1200 $(OG_SRC) --out $(OG_OUT) >/dev/null
	@printf "  生成: %s (%s KB)\n" "$(OG_OUT)" "$$(( $$(stat -f%z $(OG_OUT)) / 1024 ))"

weigh: ## 重い参照アセットを一覧し、軽量化コマンドを提示
	@echo -e "$(C_DIM)-- $(HEAVY_KB)KB を超える assets --$(C_END)"
	@find assets -type f -size +$(HEAVY_KB)k -exec sh -c \
		'printf "  %6s KB  %s\n" "$$(( $$(stat -f%z "$$1") / 1024 ))" "$$1"' _ {} \; \
		| sort -rn || true
	@echo ""
	@echo -e "  $(C_DIM)例: sips -s format jpeg -s formatOptions 80 -Z 1920 $(MV_SRC) --out assets/main-visual.jpg$(C_END)"
	@echo -e "  $(C_DIM)変換後は index.html の参照も差し替える$(C_END)"

## -------------------------------------------------------------- 本番化 ---

ship: build ## 検証・コミット・push して本番反映  例: make ship m="修正内容" [trailer="..."]
	@if [ -z "$(m)" ]; then \
		echo -e "$(C_NG)コミットメッセージが必要です$(C_END)"; \
		echo '  make ship m="変更内容"'; exit 1; fi
	@if git diff --quiet && git diff --cached --quiet; then \
		echo -e "$(C_WRN)コミットする変更がありません$(C_END)"; exit 1; fi
	@git branch --show-current | grep -qx $(BRANCH) \
		|| { echo -e "$(C_NG)$(BRANCH) ブランチではありません$(C_END)"; exit 1; }
	git add -A
	git commit -m "$(m)" $(if $(trailer),-m "$(trailer)",)
	git push origin $(BRANCH)
	@echo ""
	@echo -e "$(C_OK)push 完了$(C_END) 1〜2分で $(SITE) に反映されます"
	@echo "  反映後: make verify"

deploy: build ## コミット済みの変更を push して本番反映
	@git diff --quiet && git diff --cached --quiet \
		|| { echo -e "$(C_NG)未コミットの変更があります → make ship m=\"...\"$(C_END)"; exit 1; }
	git push origin $(BRANCH)
	@echo -e "$(C_OK)push 完了$(C_END) 1〜2分で反映されます"

prod: build ## GitHubを経由せず今すぐ本番反映（vercel CLI）
	npx vercel --prod

preview: build ## プレビューURLを発行（本番には影響しない）
	npx vercel

## -------------------------------------------------------------- 確認 ---

verify: ## 本番サイトの疎通・キャッシュ・除外設定を確認
	@echo -e "$(C_DIM)-- 主要URL --$(C_END)"
	@for u in / /support.js /favicon.ico /assets/og-image-1200.jpg /assets/main-visual.png /assets/memorio-3d.html; do \
		printf "  %-32s " "$$u"; \
		curl -so /dev/null -w '%{http_code}  %{size_download} bytes\n' "$(SITE)$$u"; \
	done
	@echo -e "$(C_DIM)-- apex リダイレクト --$(C_END)"
	@printf "  memorio.gift → "; curl -so /dev/null -w '%{http_code} %{redirect_url}\n' https://memorio.gift
	@echo -e "$(C_DIM)-- 除外ファイル（404 が正常） --$(C_END)"
	@for f in CLAUDE.md plan.txt teaser-wf.dc.html Makefile tools/check.py; do \
		printf "  %-32s " "/$$f"; \
		curl -so /dev/null -w '%{http_code}\n' "$(SITE)/$$f"; \
	done
	@echo -e "$(C_DIM)-- OGP（本番HTMLから抽出） --$(C_END)"
	@curl -s $(SITE) | grep -oE '<(meta property="og:(url|image)"|link rel="canonical")[^>]*>' | sed 's/^/  /'

status: ## DNS・証明書・配信元を確認
	@echo -e "$(C_DIM)-- NS --$(C_END)"
	@dig +short memorio.gift NS | sed 's/^/  /'
	@echo -e "$(C_DIM)-- A --$(C_END)"
	@dig +short www.memorio.gift | sed 's/^/  /'
	@echo -e "$(C_DIM)-- 証明書 --$(C_END)"
	@echo | openssl s_client -connect www.memorio.gift:443 -servername www.memorio.gift 2>/dev/null \
		| openssl x509 -noout -issuer -enddate | sed 's/^/  /'
	@echo -e "$(C_DIM)-- サーバー --$(C_END)"
	@curl -sI $(SITE) | grep -iE '^HTTP|^server|^x-vercel-id' | sed 's/^/  /'

## --------------------------------------------------------------- 掃除 ---

clean: ## 生成物を削除（OG画像。再生成は make og）
	@rm -f $(OG_OUT)
	@echo "削除: $(OG_OUT)"
