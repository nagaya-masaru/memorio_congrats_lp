# SCENES 画像生成プロンプト — 05 卒業・部活

対象: `MemoriO Congrats LP.dc.html` → SCENESセクション「卒業・部活」の写真枠
出力サイズ: **1600 × 1280**（5:4 横長）

参考: `assets/scene-birth.png` / `scene-birthday.png` / `scene-anniversary.png` / `scene-wedding.png` が基準。**同じ光・同じ布・同じ距離感**で揃える。製品色はこの節目のみ**青**。

---

## プロンプト（英語・そのまま貼る）

```
Editorial lifestyle photograph, 5:4 horizontal. A pale dusty blue cube-shaped
music box with its lid open on a wooden school desk in an empty Japanese
classroom, gold music-box mechanism visible inside, delicate laser-engraved
text on the front face reading "MemoriO Congrats" with a date and two short
English lines. Its matching white paper box stands beside it. A neatly folded
white sports towel and a rolled diploma tied with a thin ribbon lie softly out
of focus on the desk. Rows of empty desks and chairs fade far out of focus in
the background. Warm late-afternoon light entering from tall classroom windows
on the left, soft diffused shadows and gentle light streaks across the desk
surface. Shallow depth of field, the blue cube in sharp focus. Palette limited
to cream, ivory, warm beige, light wood tones and pale dusty blue. Quiet,
tender, restrained Japanese product-editorial mood. Negative space in the upper
right. Shot on 50mm, f/2.0, soft film-like grain, muted highlights, no harsh
contrast.
```

## 日本語での意図

- **場所はこの節目のみ教室**。誰もいない放課後の教室、木の机の上に1台
- **「終わった日」の静けさ**を撮る。試合中や卒業式の賑わいではなく、片付いた机に残された1台
- 人物は写さない。たたんだタオルと丸めた卒業証書をボケた前景に置き、その場にいた人の気配だけ残す。背景の机と椅子の列は大きくボカす
- 製品は**青1台・開いた状態**＋白いパッケージ。既存4枚と同じ構図の作り方
- ユニフォーム番号、校章、ボール、メダル、トロフィーは使わない（特定の競技・学校に寄りすぎ、既存4枚のトーンから外れる）
- 光は教室の大きな窓からの西日。既存4枚と同じ「左上手前からの斜光・やわらかい影」を保つ
- 右上に余白

## ネガティブプロンプト

```
faces, people, students, uniforms, jersey numbers, school emblems, blackboard
writing, balls, medals, trophies, banners, text overlay, logo, watermark,
saturated colors, bright blue, navy, cold fluorescent light, harsh flash,
clutter, more than one music box, cartoon, illustration, 3D render,
oversharpened
```

## 他の節目と揃える共通ルール

| 項目 | 指定 |
| --- | --- |
| サイズ | 1600 × 1280 |
| 光 | 自然光1灯・左上手前から・やわらかい影（この節目のみ教室の窓からの西日） |
| 台 | 生成りのリネン（この節目のみ木の学習机） |
| 色 | 生成り／アイボリー／ベージュ＋その節目の製品色 |
| 製品 | 1台のみ・開いた状態＋パッケージ（誕生日のみ2台） |
| 人物 | 顔は写さない（手・断片のみ） |
| 刻印 | 前面に "MemoriO Congrats" ＋日付＋短い英文2行 |
| 質感 | フィルム調のわずかな粒子。過度なシャープネスなし |

節目ごとの製品色の割り当て:

- 誕生・出産 → 白（撮影済み）
- 誕生日 → 黄（撮影済み）
- 記念日・カップル → 白（撮影済み）
- 結婚 → 白（撮影済み）
- **卒業・部活 → 青**
- 家族・祖父母 → 青
- 送別・退職 → 緑

## 生成後

`assets/scene-graduation.png` として置いてください。LP側のプレースホルダーを差し替えます。
