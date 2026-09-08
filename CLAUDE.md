# MemoriO Congrats ティザーLP — 引き継ぎ

## 成果物
- `index.html` — **本番LP（これが最新・メイン）**。Vercelのルート配信のため `MemoriO Congrats LP.dc.html` から改名（中身はdc形式のまま。`<x-dc>` + `./support.js`）
- `teaser-wf.dc.html` — WF検討履歴（ターン1〜3、参照用。新規作業では触らない）
- `vercel.json` / `.vercelignore` — 静的デプロイ設定（ビルドなし、`uploads/` `docs/` `tools/` `Makefile` などは除外）
- `Makefile` — 開発・検証・本番化のコマンド集。`make` で一覧
- `tools/check.py` — `index.html` の静的検査（タグ対応・参照切れ・OGP・LINE URL・重いアセット）
- `docs/deploy-guide.md` — ドメイン接続手順（完了済み・再設定時の参照用）
- `docs/deck.html` — **配布用ブランド資料の原本**（A4横20ページ／LPの各セクションを1ページずつ資料化）。テキスト・レイアウトはこのファイルを直接編集する
- `assets/MemoriO-Congrats-brand-deck.pdf` — 上を書き出したPDF（約4MB／21ページ）。**配信対象**で、LPフッターの「ブランド資料（PDF）」から直接ダウンロードできる。`make pdf` で再生成
- `docs/deck-assets/` — 資料専用の軽量画像（合計約2MB）。LPの重いPNGを縮小したもの＋QR3種。実写を差し替えたら `make deck-assets`
  - `line-qr.png` … LINE友だち追加QR（公式URLから取得。`make deck-assets`）
  - `site-qr.png` … `https://www.memorio.gift/`（segnoで生成。`make deck-qr`）
  - `touch-qr.png` … `https://www.memorio.gift/#touch`（同上）
- `assets/main-visual.png` — MV実写（1920×1080、ヒーロー全面背景）
- `assets/memorio-3d.html` — ユーザー提供の3Dビューア（回転・開閉・分解・音・刻印）。LPのTOUCHセクションにiframeで遅延読み込み
- `plan.txt` / `plan.docx` — ブランド戦略ドキュメント（コピーの出典）

## コマンド

```
make            # コマンド一覧
make dev        # ローカル確認 http://localhost:8000
make build      # 検証 + OG画像生成（本番化の前に必ず通す）
make ship m="変更内容"   # 検証 → コミット → push（＝本番反映）
make verify     # 本番の疎通・OGP・除外設定を確認
make status     # DNS・証明書・配信元
make weigh      # 重いアセット一覧
make prod       # GitHubを経由せず即時デプロイ（npx vercel --prod）
make pdf        # ブランド資料PDFを書き出す（docs/deck.html → docs/*.pdf）
make deck       # PDFを書き出して開く
make deck-assets # 資料用の軽量画像を作り直す（実写差し替え後）
make deck-qr    # サイト・3DのQRを作り直す（URL変更時のみ。segnoが必要）
                # 例: make deck-qr PY=/path/to/venv/bin/python
```

資料PDFはヘッドレスChromeの印刷機能で書き出す（`@page{size:297mm 210mm}`）。
原本（`docs/deck.html`・`docs/deck-assets/`）は `.vercelignore` で除外、**PDFだけ `assets/` に置いて配信**している。
`.vercelignore` は親ディレクトリを除外すると中のファイルを再包含できないため、PDFの置き場所は `docs/` ではなく `assets/`。
PDFは差し替える前提なので、`vercel.json` で `/assets/(.*)` の1年 immutable から除外し、`max-age=600, must-revalidate` にしている
（総称ルール側を `/assets/:path((?!MemoriO-Congrats-brand-deck\.pdf).*)` にして、ヘッダーの優先順位に依存しない形にした）。
**PDFのファイル名を変えると配信URLとフッターのリンクが変わる**ので、名前は固定のまま中身だけ差し替える。
`make check` の WARN は11件（すべてアセットの重さ。PDF 4MB を含む）。

`make check` の WARN は現状11件（すべてアセットの重さ）。NG が出たら本番化しない。

## 資料（PDF）の構成（全21ページ）
1 表紙 / 2 目次 / 3 WHY VOICE / 4 SCENES一覧 / 5–11 7つの節目の詳細 / 12 STACK /
13 STACK詳細 / 14 TOUCH（3D） / 15–16 COLORWAY / 17 HOW IT WORKS / 18 アプリ「声の年表」 /
19 PRODUCT & PRICE / 20 FAQ / 21 CONTACT（LINE QR＋サイトQR）

- 目次（2ページ）は**見出し・SUMMARY・FACTSを置かない**。全幅の一覧だけで紙面を使う（2026-09-08 ユーザー指示）
- COLORWAYは2ページ（3色＋2色）。各色は**製品色の1段濃い色面**を背景に敷き、写真は余白を切り抜いて大きく見せる
  - 切り抜きは5枚共通のアルファ境界＋3%余白 = Makefile の `CROP := 715 1090 --cropOffset 195 410`
  - タイル幅は15/16ページとも320px（16ページの2枚は `flex:0 0 319px` で固定）
- ページを増減したら `TOTAL` に相当するフッターの「NN / 21」と目次のページ番号、FAQ内の「資料14ページ」参照を全部直す

- **リンクはすべてQRコードに置き換えてある**（紙・PDFではリンクが押せないため）
  - 表紙 … LINEの小QR / ページ14 … 3DビューアのQR / ページ20 … LINEとサイトのQRを2つ並べ
- **資料にウェイティング人数は書かない**（2026-09-08 ユーザー指示。LP側の表示は継続）
- ページ17のスマホモックは **LPの実マークアップをそのまま流用**（`assets/iphone-frame.png` を重ねる方式）。LP側を直したら資料も直す
- 3Dビューアの静止画は用意できていない（ヘッドレスChromeでの撮影はWebGLソフトウェア描画がハングして失敗する）。実機キャプチャを用意できたらページ14の製品画像と差し替える
- 1ページ=1枚の `<section class="slide">`。高さは `209.6mm`（210mmだと丸め誤差で空白ページが挟まる）
- 版面の余白は全ページ `padding:15mm` で統一。右側に置いた要素（12ページのスタック、17ページのスマホ、14/20ページのカード）は右の余白線まで伸ばす

## 確定事項（勝手に変えない）
- 価格：**¥16,500（税込）**
- 発売：**2027年春**（日付は非公開）
- ブランド資料PDFの配布：**LPフッターの「ブランド資料（PDF）」からダウンロード**（2026-09-08 公開。`assets/` 配信、`download` 属性つき）
- 登録手段：**LINE のみ**（メール登録フォームは 2026-09-08 に全削除。ヒーロー／WAITING LIST とも LINE CTA ＋ 友だち追加QR）
- LINE公式アカウントURL：**https://lin.ee/pl7X0GAM**（LP内4か所のLINE CTAに設定済み。logic class の `lineUrl` が唯一の定義箇所）
- LINE友だち追加QR：`https://qr-official.line.me/gs/M_442kiuxo_BW.png?oat_content=qr`（WAITING LISTに外部画像として直リンク）
- アプリのストアバッジ（App Store／Google Play）と「公式アプリはこちら」は **HTMLコメントで無効化**。アプリ公開時に `index.html` の `<!-- ストア公開後に復活させる` を外す
- ウェイティング人数：表示する（Tweaks `waitlistCount`、既定1240）
- **アプリが必要なのは「声を贈る側（購入者）」だけ。** 受け取る側は蓋を開けるだけ、録音リンクの受け手はブラウザ録音で、どちらもDL不要。逆に書くとユーザー指摘が入る（2026-09-08 修正済み）
- 節目は7つ：誕生・出産／誕生日／記念日・カップル／結婚／卒業・部活／家族・祖父母／送別・退職
- 写真はMV以外すべてプレースホルダー（ユーザーが用意中）
- Canva資料のシーン写真はAI生成に見えるため本番利用は未確認

## LPのセクション順
ヘッダー(sticky) → ヒーロー(MV全面＋コピー＋メールフォーム) → WHY VOICE(Value 01-03) → SCENES(7節目セレクター) → STACK(スクロール連動でキューブ5個が積み上がる) → TOUCH(3D埋め込み) → COLORWAY(5色) → HOW IT WORKS＋アプリ「声の年表」 → PRICE → FAQ(5件) → WAITING LIST(登録フォーム再掲) → フッター

## 実装の注意
- **`overflow-x:hidden` をルート要素に付けない。** スクロールコンテナ化してsticky（ヘッダー・STACKステージ）が死ぬ。横溢れ対策は helmet の `html,body{overflow-x:clip}` で済んでいる
- STACKの積み上がりは logic class の window scroll リスナー＋`stackRef` の getBoundingClientRect で step(0-4) を算出。キューブは opacity と translateY のみ変化
- 3Dは `threeRef` が画面に近づいたら `load3d` を true にして iframe をマウント（重いため）
- Tweaks props：`waitlistCount` / `show3d` / `faqOpenFirst`

## デザイン
- フォント：見出し・本文 Shippori Mincho / 欧文・数字 Cormorant Garamond
- 色：背景 #fbf7f1、生成り #fdfaf5〜#f3e7d8、文字 #454a40 / #6f6a5d / #8a8578、アクセント #b3925f、CTA #4e5348
- 製品5色：白 #fdfcfa / ピンク #f6dedb / 青 #d9e6f2 / 黄 #f6ecc6 / 緑 #dde8dc
- 角丸は 2〜3px（ほぼ直角）、罫線 #ece3d5 / #ddd2c0

## 未対応・次の作業候補
- 実写画像への差し替え（必要リストは下記）
- OG画像・ファビコン
- 独自ドメイン **https://memorio.gift** で公開済み（2026-09-08。Vercel配信、NSを `ns1/ns2.vercel-dns.com` に委任。手順は `docs/deploy-guide.md`）
- **アセットが重い（合計約20MB）**。`make weigh` で一覧。特に SCENES のサムネイル7枚（各1.5〜1.8MB）が同時に読み込まれる。実写差し替え時にJPEG化＋リサイズする
- OG画像は `assets/og-image-1200.jpg`（130KB）を参照。元PNG（4.1MB）は編集用に残置。再生成は `make og`
- 「出産に固執しない」＝節目全体を等価に扱う方針（ユーザー指摘済み）

### 必要画像リスト（ユーザー準備中）
- シーン写真 7枚（各1600×1280目安、7つの節目それぞれ）
- カラー 5枚（各1200×1200、同一アングル・同一ライティング、閉じた状態で刻印面が見える）
- アプリ「声の年表」 1枚（750×1334目安）
- 積み重なった状態の写真 1枚（任意）
- パッケージ写真 1枚（任意）
- OG画像 1200×630、ファビコン 512×512
