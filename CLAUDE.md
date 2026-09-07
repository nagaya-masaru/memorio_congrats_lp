# MemoriO Congrats ティザーLP — 引き継ぎ

## 成果物
- `index.html` — **本番LP（これが最新・メイン）**。Vercelのルート配信のため `MemoriO Congrats LP.dc.html` から改名（中身はdc形式のまま。`<x-dc>` + `./support.js`）
- `teaser-wf.dc.html` — WF検討履歴（ターン1〜3、参照用。新規作業では触らない）
- `vercel.json` / `.vercelignore` — 静的デプロイ設定（ビルドなし、`uploads/` `docs/` `tools/` `Makefile` などは除外）
- `Makefile` — 開発・検証・本番化のコマンド集。`make` で一覧
- `tools/check.py` — `index.html` の静的検査（タグ対応・参照切れ・OGP・LINE URL・重いアセット）
- `docs/deploy-guide.md` — ドメイン接続手順（完了済み・再設定時の参照用）
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
```

`make check` の WARN は現状10件（すべてアセットの重さ）。NG が出たら本番化しない。

## 確定事項（勝手に変えない）
- 価格：**¥16,500（税込）**
- 発売：**2027年春**（日付は非公開）
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
