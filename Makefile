# MemoriO Congrats LP — 開発・デプロイ用コマンド集
#
#   make          → コマンド一覧
#   make dev      → ローカルで見る
#   make build    → 検証 + OG画像生成
#   make ship m="変更内容"  → 検証・コミット・push（本番反映）
#   make pdf      → LPを資料化したPDF（A4横20ページ）を書き出す
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

DECK       := docs/deck.html
DECK_PDF   := assets/MemoriO-Congrats-brand-deck.pdf   # 配信対象。LPフッターの「ブランド資料」から辿れる
DECK_DIR   := docs/deck-assets
LINE_QR    := https://qr-official.line.me/gs/M_442kiuxo_BW.png?oat_content=qr
SITE_URL   := https://www.memorio.gift/
# カラー5枚の余白を落とす切り抜き（5枚共通のアルファ境界＋3%余白）
CROP       := 715 1090 --cropOffset 195 410
PY         ?= python3   # QR生成に使うPython（segnoが入ったものを指定可）
CHROME     := /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

C_OK  := \033[32m
C_WRN := \033[33m
C_NG  := \033[31m
C_DIM := \033[2m
C_END := \033[0m

.PHONY: help dev open build check og weigh verify status ship deploy prod preview clean \
        pdf deck deck-assets deck-qr openpdf

## ---------------------------------------------------------------- help ---

help: ## コマンド一覧を表示
	@echo ""
	@echo "  MemoriO Congrats LP"
	@echo -e "  $(C_DIM)本番: $(SITE)$(C_END)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo -e "  $(C_DIM)例: make ship m=\"LINE QRを追加\"　／　make pdf で資料を書き出す$(C_END)"
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

## --------------------------------------------------------------- 資料 ---

pdf: $(DECK_PDF) ## 資料（docs/deck.html）をA4横のPDFに書き出す

deck: pdf openpdf ## PDFを書き出して開く

$(DECK_PDF): $(DECK) $(wildcard $(DECK_DIR)/*)
	@echo -e "$(C_DIM)-- pdf --$(C_END)"
	@if [ ! -x "$(CHROME)" ]; then \
		echo -e "$(C_NG)Google Chrome が見つかりません: $(CHROME)$(C_END)"; exit 1; fi
	@"$(CHROME)" --headless --disable-gpu --no-sandbox --no-pdf-header-footer \
		--virtual-time-budget=20000 --run-all-compositor-stages-before-draw \
		--print-to-pdf="$(CURDIR)/$@" "file://$(CURDIR)/$(DECK)" >/dev/null 2>&1
	@printf "  生成: %s (%s KB / %s ページ)\n" "$@" \
		"$$(( $$(stat -f%z $@) / 1024 ))" "$$(grep -c '<section class="slide"' $(DECK))"
	@echo -e "  $(C_DIM)中身を直すときは $(DECK) を編集して make pdf$(C_END)"

deck-assets: ## 資料用の軽量画像を assets/ から作り直す（実写を差し替えたら実行）
	@mkdir -p $(DECK_DIR)
	@echo -e "$(C_DIM)-- deck assets --$(C_END)"
	@for f in main-visual second-view; do \
		sips -s format jpeg -s formatOptions 78 -Z 1600 assets/$$f.png --out $(DECK_DIR)/$$f.jpg >/dev/null; done
	@for f in scene-birth scene-birthday scene-anniversary scene-wedding \
	          scene-graduation scene-family scene-farewell; do \
		sips -s format jpeg -s formatOptions 76 -Z 1100 assets/$$f.png --out $(DECK_DIR)/$$f.jpg >/dev/null; done
	@for f in color-white color-pink color-blue color-yellow color-green; do \
		sips -c $(CROP) assets/$$f.png --out $(DECK_DIR)/$$f.png >/dev/null; \
		sips -Z 760 $(DECK_DIR)/$$f.png >/dev/null; done
	@cp assets/logo.png assets/iphone-frame.png $(DECK_DIR)/
	@curl -sL "$(LINE_QR)" -o $(DECK_DIR)/line-qr.png
	@echo -e "  $(C_DIM)site-qr.png / touch-qr.png はそのまま（作り直しは make deck-qr）$(C_END)"
	@printf "  %s (%s KB)\n" "$(DECK_DIR)" "$$(du -sk $(DECK_DIR) | cut -f1)"
	@echo -e "  $(C_DIM)続けて make pdf$(C_END)"

deck-qr: ## 資料のQR（サイト・3Dビューア）を作り直す（URLを変えたときだけ）
	@$(PY) -c 'import segno' 2>/dev/null || { \
		echo -e "$(C_NG)segno がありません$(C_END)  pip install segno"; exit 1; }
	@$(PY) -c 'import segno,sys; \
		u=sys.argv[1]; d=sys.argv[2]; \
		segno.make(u, error="m").save(d+"/site-qr.png", scale=12, border=3); \
		segno.make(u+"#touch", error="m").save(d+"/touch-qr.png", scale=12, border=3)' \
		"$(SITE_URL)" "$(DECK_DIR)"
	@echo "  生成: $(DECK_DIR)/site-qr.png, $(DECK_DIR)/touch-qr.png"
	@echo -e "  $(C_DIM)LINEのQRは make deck-assets で取得$(C_END)"

openpdf: ## 書き出したPDFを開く
	@open $(DECK_PDF)

## -------------------------------------------------------------- 確認 ---

verify: ## 本番サイトの疎通・キャッシュ・除外設定を確認
	@echo -e "$(C_DIM)-- 主要URL --$(C_END)"
	@for u in / /support.js /favicon.ico /assets/og-image-1200.jpg /assets/main-visual.png \
	          /assets/memorio-3d.html /assets/MemoriO-Congrats-brand-deck.pdf; do \
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
