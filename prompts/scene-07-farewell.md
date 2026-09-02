# SCENES 画像生成プロンプト — 07 送別・退職

対象: `MemoriO Congrats LP.dc.html` → SCENESセクション「送別・退職」の写真枠
出力サイズ: **1600 × 1280**（5:4 横長）

参考: 既存6枚が基準。**同じ光・同じ距離感・同じ刻印の作り**で揃える。製品色は**緑**。7枚の最後の1枚。

---

## プロンプト（英語・そのまま貼る）

```
Editorial lifestyle photograph, 5:4 horizontal. A pale sage green cube-shaped
music box with its lid open, placed on a light wooden office desk, gold
music-box mechanism visible inside, delicate laser-engraved text on the front
face reading "MemoriO Congrats" with a date and two short English lines. Its
matching pale green paper box stands beside it. A small potted plant and a
cleared desk tray sit near it. Behind, an office interior recedes far out of
focus: rows of empty desks, office chairs, a low shelving unit and tall windows,
all softly blurred, suggesting a workplace on someone's last day. Warm
late-afternoon light entering from the tall windows on the left, soft diffused
shadows and gentle light streaks across the wood grain. Shallow depth of field, the green cube in sharp focus. Palette limited
to cream, ivory, warm beige, light wood tones and pale sage green. Quiet,
tender, restrained Japanese product-editorial mood. Negative space in the upper
right. Shot on 50mm, f/2.0, soft film-like grain, muted highlights, no harsh
contrast.
```

## 日本語での意図

- **「最終出勤日の、片付いた机」**を撮る。送別会の賑わいではなく、荷物が減って静かになった机の上に残された1台
- 場所は**オフィス**。明るい木のデスクの上に1台、背景に無人のデスクと椅子の列・低い書棚・大きな窓を大きくボカして入れる（家族・祖父母が居間の棚なので、こちらはオフィスで差をつける）
- 人物は写さない。小さな鉢植えと空になったトレーを手前に置き、そこで働いていた人の気配だけ残す
- 製品は**緑1台・開いた状態**＋緑のパッケージ。既存6枚と同じ構図の作り方
- 花束、色紙、寄せ書き、名刺、PC、書類の山は使わない（生活感が出すぎ、既存6枚の静けさから外れる）
- 光はレースカーテン越しの西日。既存6枚と同じ「左上手前からの斜光・やわらかい影」
- 右上に余白

## ネガティブプロンプト

```
faces, people, hands, bouquet, flowers wrapped in paper, signed message board,
business cards, laptop, monitor, stacks of documents, cardboard boxes,
whiteboard writing, company signage, text overlay, logo, watermark, saturated
colors, bright green, cold fluorescent light, harsh flash, clutter, busy
background, more than one music box, cartoon, illustration, 3D render,
oversharpened
```

## 他の節目と揃える共通ルール

| 項目 | 指定 |
| --- | --- |
| サイズ | 1600 × 1280 |
| 光 | 自然光1灯・左上手前から・やわらかい影（オフィスの大きな窓からの西日） |
| 台・場所 | 明るい木のデスク／背景はオフィス（無人のデスク列・書棚・大きな窓を大きくボカす） |
| 色 | 生成り／アイボリー／ベージュ＋その節目の製品色 |
| 製品 | 1台のみ・開いた状態＋パッケージ（誕生日のみ2台） |
| 人物 | 顔は写さない |
| 刻印 | 前面に "MemoriO Congrats" ＋日付＋短い英文2行 |
| 質感 | フィルム調のわずかな粒子。過度なシャープネスなし |

節目ごとの製品色の割り当て（これで7枚完了）:

- 誕生・出産 → 白（撮影済み）
- 誕生日 → 黄（撮影済み）
- 記念日・カップル → 白（撮影済み）
- 結婚 → 白（撮影済み）
- 卒業・部活 → 青（撮影済み）
- 家族・祖父母 → 青（撮影済み）
- **送別・退職 → 緑**

## 生成後

`assets/scene-farewell.png` として置いてください。LP側のプレースホルダーを差し替えます。これでSCENESの7枚すべてが実写になります。
