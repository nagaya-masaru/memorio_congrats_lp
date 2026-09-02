# SCENES 画像生成プロンプト — 02 誕生日

対象: `MemoriO Congrats LP.dc.html` → SCENESセクション「誕生日」の写真枠
出力サイズ: **1600 × 1280**（5:4 横長）。枠は `object-fit:cover` なので中央にゆとりを持たせる。

---

## プロンプト（英語・そのまま貼る）

```
Editorial lifestyle photograph, 5:4 horizontal. A small round birthday cake with
a single unlit candle on a cream linen tablecloth, and beside it a pale butter
yellow cube-shaped music box with its lid open, gold music-box mechanism visible
inside. A second closed cube of the same size sits slightly behind, suggesting
last year's. Warm natural window light from the upper left, soft diffused
shadows, shallow depth of field with the yellow cube in sharp focus. Palette
limited to cream, ivory, warm beige and pale butter yellow. Quiet, tender,
restrained Japanese product-editorial mood. Plenty of negative space in the
upper right. Shot on 50mm, f/2.0, soft film-like grain, muted highlights, no
harsh contrast.
```

## 日本語での意図

- **「一年ごとに増えていく」ことが伝わる画**。今年のキューブ（開いた黄色）と、去年のキューブ（閉じた同型）を並べる
- 人物の顔は写さない。ケーキとキューブだけで誕生日の場面を成立させる
- ろうそくは**火をつけない**。派手にならず、静かなトーンを保つため
- 光は自然光1灯、影はやわらかく。リネンの質感を残す
- 右上に余白

## ネガティブプロンプト

```
faces, people, lit candle, fire, balloons, confetti, party hats, text, logo,
watermark, saturated colors, blue or green cast, harsh flash, clutter,
more than two products, cartoon, illustration, 3D render, oversharpened
```

## 他6枚と揃える共通ルール

| 項目 | 指定 |
| --- | --- |
| サイズ | 1600 × 1280 |
| 光 | 自然光1灯・上手前から・やわらかい影 |
| 色 | 生成り／アイボリー／ベージュ＋その節目の製品色 |
| 人物 | 顔は写さない（手・後ろ姿・断片のみ） |
| 質感 | フィルム調のわずかな粒子。過度なシャープネスなし |

※この節目だけ製品を2台（開1・閉1）写します。他の節目は1台のみ。

節目ごとの製品色の割り当て:

- 誕生・出産 → ピンク
- **誕生日 → 黄**
- 記念日・カップル → 白
- 結婚 → 白
- 卒業・部活 → 緑
- 家族・祖父母 → 青
- 送別・退職 → 緑

## 生成後

`assets/scene-birthday.png` として置いてください。LP側のプレースホルダーを差し替えます。
