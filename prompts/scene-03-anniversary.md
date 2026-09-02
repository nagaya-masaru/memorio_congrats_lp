# SCENES 画像生成プロンプト — 03 記念日・カップル

対象: `MemoriO Congrats LP.dc.html` → SCENESセクション「記念日・カップル」の写真枠
出力サイズ: **1600 × 1280**（5:4 横長）

参考: 誕生・出産（`assets/scene-birth.png`）が基準。**同じ光・同じ質感・同じ距離感**で撮れているように揃える。

---

## プロンプト（英語・そのまま貼る）

```
Editorial lifestyle photograph, 5:4 horizontal. A white cube-shaped music box
with its lid open sits on a cream linen tablecloth, gold music-box mechanism
visible inside, delicate laser-engraved text on the front face. Two simple
ceramic coffee cups sit softly out of focus in the background, suggesting two
people who have just left the table. Warm afternoon window light entering from
the upper left, soft diffused shadows, gentle highlight bloom on the cloth.
Shallow depth of field, the cube in sharp focus, background falling away.
Palette limited to cream, ivory, warm beige and off-white. Quiet, tender,
restrained Japanese product-editorial mood. Negative space in the upper left.
Shot on 50mm, f/2.0, soft film-like grain, muted highlights, no harsh contrast.
```

## 日本語での意図

- **「2人」を人物なしで示す**。カップを2つ、手前ではなくボケた背景に置く。人物は写さない
- 製品は**白1台・開いた状態**。金色のオルゴール機構が見えること
- 記念日は「渡す前の静かな時間」として撮る。花束やハート、リボンなどの記号は使わない
- 光と布は誕生・出産の写真と同系統。生成りのリネン、上手前からの自然光、やわらかい影
- 左上に余白（誕生・出産が右手前に製品を置いているため、7枚並べたときに配置が偏らないよう左右を交互にする）

## ネガティブプロンプト

```
faces, people, hands, hearts, roses, bouquet, ribbon, gift wrap, rings,
candles, text overlay, logo, watermark, saturated colors, red or pink accents,
blue or green cast, harsh flash, clutter, more than one product, cartoon,
illustration, 3D render, oversharpened
```

## 他6枚と揃える共通ルール

| 項目 | 指定 |
| --- | --- |
| サイズ | 1600 × 1280 |
| 光 | 自然光1灯・上手前から・やわらかい影 |
| 色 | 生成り／アイボリー／ベージュ＋その節目の製品色 |
| 製品 | 1台のみ・開いた状態（誕生日のみ2台） |
| 人物 | 顔は写さない |
| 質感 | フィルム調のわずかな粒子。過度なシャープネスなし |

節目ごとの製品色の割り当て:

- 誕生・出産 → ピンク（撮影済み）
- 誕生日 → 黄
- **記念日・カップル → 白**
- 結婚 → 白
- 卒業・部活 → 緑
- 家族・祖父母 → 青
- 送別・退職 → 緑

## 生成後

`assets/scene-anniversary.png` として置いてください。LP側のプレースホルダーを差し替えます。
