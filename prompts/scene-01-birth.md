# SCENES 画像生成プロンプト — 01 誕生・出産

対象: `MemoriO Congrats LP.dc.html` → SCENESセクション「誕生・出産」の写真枠
出力サイズ: **1600 × 1280**（5:4 横長）。枠は `object-fit:cover` なので中央にゆとりを持たせる。

---

## プロンプト（英語・そのまま貼る）

```
Editorial lifestyle photograph, 5:4 horizontal. A newborn baby's small hand
resting on a soft cream muslin blanket, and beside it a pale pink cube-shaped
music box with its lid open, gold music-box mechanism visible inside. Warm
natural window light from the upper left, soft diffused shadows, shallow depth
of field with the cube in sharp focus. Palette limited to cream, ivory, warm
beige and pale dusty pink. Quiet, tender, restrained Japanese product-editorial
mood. Plenty of negative space in the upper right. Shot on 50mm, f/2.0,
soft film-like grain, muted highlights, no harsh contrast.
```

## 日本語での意図

- **主役は「はじまりの声」**。赤ちゃんの顔は写さず、手・足・毛布の一部など断片で示す（顧客の実物写真に差し替えやすくするため）
- 製品（淡いピンクのキューブ、開いた状態）を必ず画面内に置く。金色のオルゴール機構が見えること
- 光は自然光1灯、影はやわらかく。生成りの布の質感を残す
- 右上に余白。LP上でテキストが乗らない枠だが、他6枚と余白位置を揃えるとリズムが出る

## ネガティブプロンプト

```
baby's face, adult face, text, logo, watermark, plastic toy look, saturated
colors, blue or green cast, harsh flash, clutter, multiple products, hospital
equipment, cartoon, illustration, 3D render, oversharpened
```

## 他6枚と揃える共通ルール

| 項目 | 指定 |
| --- | --- |
| サイズ | 1600 × 1280 |
| 光 | 自然光1灯・上手前から・やわらかい影 |
| 色 | 生成り／アイボリー／ベージュ＋その節目の製品色 |
| 製品 | 必ず1台だけ写す。開いた状態か閉じた状態のどちらかに統一 |
| 人物 | 顔は写さない（手・後ろ姿・断片のみ） |
| 質感 | フィルム調のわずかな粒子。過度なシャープネスなし |

節目ごとの製品色の割り当て:

- 誕生・出産 → ピンク
- 誕生日 → 黄
- 記念日・カップル → 白
- 結婚 → 白
- 卒業・部活 → 緑
- 家族・祖父母 → 青
- 送別・退職 → 緑

## 生成後

`assets/scene-birth.png` として置いてください。LP側のプレースホルダーを差し替えます。
