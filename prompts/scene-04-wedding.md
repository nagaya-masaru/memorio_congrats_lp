# SCENES 画像生成プロンプト — 04 結婚

対象: `MemoriO Congrats LP.dc.html` → SCENESセクション「結婚」の写真枠
出力サイズ: **1600 × 1280**（5:4 横長）

参考: `assets/scene-birth.png` / `assets/scene-anniversary.png` が基準。**同じ光・同じ布・同じ距離感**で揃える。

---

## プロンプト（英語・そのまま貼る）

```
Editorial lifestyle photograph, 5:4 horizontal. A white cube-shaped music box
with its lid open on a cream linen tablecloth, gold music-box mechanism visible
inside, delicate laser-engraved text on the front face reading "MemoriO
Congrats". Its matching white paper box stands beside it. A few small white
flowers and a folded ivory place card lie softly out of focus in the
background, suggesting a wedding reception table after the ceremony. Warm
afternoon window light entering from the left through a sheer curtain, soft
diffused shadows and gentle light streaks across the cloth. Shallow depth of
field, the cube in sharp focus. Palette limited to cream, ivory, warm beige and
off-white. Quiet, tender, restrained Japanese product-editorial mood. Negative
space in the upper right. Shot on 50mm, f/2.0, soft film-like grain, muted
highlights, no harsh contrast.
```

## 日本語での意図

- **式の「後」の静けさ**を撮る。挙式中の華やかさではなく、片付き始めたテーブルに残された1台
- 人物は写さない。席札と小さな白い花をボケた背景に置き、ゲストがいた気配だけ残す
- 製品は**白1台・開いた状態**＋パッケージ。既存2枚と同じ構図の作り方
- ブーケ、指輪、シャンパングラス、キャンドルは使わない（記号的になり、既存2枚のトーンから外れる）
- 光はレースカーテン越しの斜光。既存2枚と同じ布・同じ光線
- 右上に余白（記念日が左上余白なので交互に）

## ネガティブプロンプト

```
faces, people, bride, groom, dress, rings, bouquet, champagne glasses, candles,
cake, gold or pink decorations, text overlay, logo, watermark, saturated
colors, blue or green cast, harsh flash, clutter, more than one music box,
cartoon, illustration, 3D render, oversharpened
```

## 他の節目と揃える共通ルール

| 項目 | 指定 |
| --- | --- |
| サイズ | 1600 × 1280 |
| 光 | レースカーテン越しの自然光1灯・左上手前から・やわらかい影 |
| 布 | 生成りのリネン／織り目の見えるクロス |
| 色 | 生成り／アイボリー／ベージュ＋その節目の製品色 |
| 製品 | 1台のみ・開いた状態＋パッケージ（誕生日のみ2台） |
| 人物 | 顔は写さない（手・断片のみ） |
| 刻印 | 前面に "MemoriO Congrats" ＋日付＋短い英文2行 |
| 質感 | フィルム調のわずかな粒子。過度なシャープネスなし |

節目ごとの製品色の割り当て:

- 誕生・出産 → 白（撮影済み）
- 誕生日 → 黄
- 記念日・カップル → 白（撮影済み）
- **結婚 → 白**
- 卒業・部活 → 緑
- 家族・祖父母 → 青
- 送別・退職 → 緑

## 生成後

`assets/scene-wedding.png` として置いてください。LP側のプレースホルダーを差し替えます。
