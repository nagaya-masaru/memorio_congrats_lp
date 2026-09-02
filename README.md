# MemoriO Congrats ティザーLP

静的サイト（ビルド不要）。Vercel にそのままデプロイできる構成です。

## ファイル
- `index.html` — 本番LP（旧 `MemoriO Congrats LP.dc.html`。ルートで配信されるエントリ）
- `support.js` — LP の実行ランタイム（`index.html` から `./support.js` で読み込み。React / Babel は unpkg から取得）
- `assets/` — 画像・3Dビューア（`assets/memorio-3d.html` を iframe で読み込み）
- `teaser-wf.dc.html` — WF検討履歴（参照用・デプロイ対象外）
- `plan.txt` / `plan.docx`、`prompts/`、`uploads/` — 資料類（デプロイ対象外）

## Vercel デプロイ
1. リポジトリを Vercel に import
2. Framework Preset: **Other**、Build Command / Output Directory は空のまま（`vercel.json` で `framework: null` / `outputDirectory: "."` を指定済み）
3. Deploy → `/` で `index.html` が配信されます

CLI の場合:
```bash
vercel        # プレビュー
vercel --prod # 本番
```

`.vercelignore` で `uploads/` などの重い資料をデプロイから除外しています。

## ローカル確認
```bash
python3 -m http.server 8000
# http://localhost:8000/
```
`file://` で直接開くと iframe や CDN 読み込みで失敗することがあるため、HTTPサーバー経由で確認してください。
