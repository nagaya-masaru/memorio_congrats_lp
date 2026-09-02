# SCENES 画像生成プロンプト — 06 家族・祖父母

対象: `MemoriO Congrats LP.dc.html` → SCENESセクション「家族・祖父母」の写真枠
出力サイズ: **1600 × 1280**（5:4 横長）

参考: 既存5枚（`scene-birth` / `birthday` / `anniversary` / `wedding` / `graduation`）が基準。**同じ光・同じ距離感・同じ刻印の作り**で揃える。製品色は**青**。

---

## プロンプト（英語・そのまま貼る）

```
Editorial lifestyle photograph, 5:4 horizontal. A pale dusty blue cube-shaped
music box with its lid open, placed on a warm wooden shelf in a Japanese
living room, gold music-box mechanism visible inside, delicate laser-engraved
text on the front face reading "MemoriO Congrats" with a date and two short
English lines. Its matching pale blue paper box stands beside it. A folded
knitted blanket and a small framed photograph, its image not readable, sit
softly out of focus in the background. Warm late-afternoon light entering from
the left through a sheer curtain, soft diffused shadows and gentle light
streaks across the wood grain. Shallow depth of field, the blue cube in sharp
focus. Palette limited to cream, ivory, warm beige, warm wood tones and pale
dusty blue. Quiet, tender, restrained Japanese product-editorial mood. Negative
space in the upper right. Shot on 50mm, f/2.0, soft film-like grain, muted
highlights, no harsh contrast.
```

## 日本語での意図

- **「日常のそばに置いてある」状態**を撮る。贈る瞬間ではなく、置き場所が決まったあとの棚の上
- 場所は居間の木の棚。卒業・部活が教室、他が布の上なので、この節目は木の棚で差をつける
- 人物は写さない。たたんだ膝掛けと小さな写真立て（中身は判別できないほどボカす）で、そこに人の生活があることだけ示す
- 製品は**青1台・開いた状態**＋青いパッケージ。既存5枚と同じ構図の作り方
- 「高齢者」の記号（老眼鏡、杖、湯呑み、仏具、和柄）は使わない。年齢を特定せず、贈る相手を限定しない
- 光はレースカーテン越しの西日。既存5枚と同じ「左上手前からの斜光・やわらかい影」
- 右上に余白

## ネガティブプロンプト

```
faces, people, hands, elderly stereotypes, reading glasses, walking cane,
tea cups, Buddhist altar, traditional Japanese patterns, readable photograph,
text overlay, logo, watermark, saturated colors, bright blue, navy, cold
light, harsh flash, clutter, more than one music box, cartoon, illustration,
3D render, oversharpened
```

## 他の節目と揃える共通ルール

| 項目 | 指定 |
| --- | --- |
| サイズ | 1600 × 1280 |
| 光 | 自然光1灯・左上手前から・やわらかい影 |
| 台 | 木の棚（この節目のみ。他は布／学習机） |
| 色 | 生成り／アイボリー／ベージュ＋その節目の製品色 |
| 製品 | 1台のみ・開いた状態＋パッケージ（誕生日のみ2台） |
| 人物 | 顔は写さない |
| 刻印 | 前面に "MemoriO Congrats" ＋日付＋短い英文2行 |
| 質感 | フィルム調のわずかな粒子。過度なシャープネスなし |

節目ごとの製品色の割り当て:

- 誕生・出産 → 白（撮影済み）
- 誕生日 → 黄（撮影済み）
- 記念日・カップル → 白（撮影済み）
- 結婚 → 白（撮影済み）
- 卒業・部活 → 青（撮影済み）
- **家族・祖父母 → 青**
- 送別・退職 → 緑

## 生成後

`assets/scene-family.png` として置いてください。LP側のプレースホルダーを差し替えます。
