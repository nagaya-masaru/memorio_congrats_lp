# MemoriO Congrats ティザーLP — 引き継ぎ

## 成果物
- `MemoriO Congrats LP.dc.html` — **本番LP（これが最新・メイン）**
- `MemoriO Congrats Teaser WF.dc.html` — WF検討履歴（ターン1〜3、参照用。新規作業では触らない）
- `assets/main-visual.png` — MV実写（1920×1080、ヒーロー全面背景）
- `assets/memorio-3d.html` — ユーザー提供の3Dビューア（回転・開閉・分解・音・刻印）。LPのTOUCHセクションにiframeで遅延読み込み
- `plan.txt` / `plan.docx` — ブランド戦略ドキュメント（コピーの出典）

## 確定事項（勝手に変えない）
- 価格：**¥16,500（税込）**
- 発売：**2027年春**（日付は非公開）
- 登録手段：メール＋LINE
- ウェイティング人数：表示する（Tweaks `waitlistCount`、既定1240）
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
- フォーム実送信の接続先未定
- 「出産に固執しない」＝節目全体を等価に扱う方針（ユーザー指摘済み）

### 必要画像リスト（ユーザー準備中）
- シーン写真 7枚（各1600×1280目安、7つの節目それぞれ）
- カラー 5枚（各1200×1200、同一アングル・同一ライティング、閉じた状態で刻印面が見える）
- アプリ「声の年表」 1枚（750×1334目安）
- 積み重なった状態の写真 1枚（任意）
- パッケージ写真 1枚（任意）
- OG画像 1200×630、ファビコン 512×512
