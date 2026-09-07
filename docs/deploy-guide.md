# デプロイ手順（memorio.gift × Vercel）

## 状態: ✅ 公開完了（2026-09-08 確認）

`https://memorio.gift` は本番稼働中。**このガイドの作業は全て終わっています。**
以降の更新は `git push` するだけ（→「以降のデプロイ方法」へ）。

### 検証済みの内容

| 項目 | 結果 |
|---|---|
| ネームサーバー | `ns1.vercel-dns.com` / `ns2.vercel-dns.com` |
| `www.memorio.gift` | HTTP 200 / title 正常 |
| `memorio.gift` | 308 → `www` へリダイレクト（正常） |
| HTTPS証明書 | Let's Encrypt、2026-12-06まで・自動更新 |
| `support.js` / favicon / MV / 3D | 全て200、キャッシュヘッダも `vercel.json` 通り |
| `CLAUDE.md` `plan.txt` `teaser-wf.dc.html` | 404（`.vercelignore` 有効） |

> apex が `www` に転送されるのは、Vercel側で `www.memorio.gift` が主ドメインになっているため。
> 逆向きにしたい場合のみ、Vercel の Domains で主ドメインを切り替える。

---

## 進捗チェックリスト

全て完了。以下は再設定・トラブル時の参照用。

- [x] STEP 1 — VercelにGitHubリポジトリをImport ✅ 完了
- [x] STEP 2 — Vercelにドメインを追加 ✅ 完了
- [x] STEP 3 — Xserverのネームサーバーを書き換える ✅ 完了
- [x] STEP 4 — 反映を待って確認する ✅ 完了

---

## 前提（作業開始時点の現状・記録用）

| 項目 | 現在の状態 |
|---|---|
| ドメイン | `memorio.gift` |
| 登録日 | 2026-09-07 |
| レジストラ | XServer, Inc. |
| ネームサーバー | 登録時 `ns1.xserver.jp` 〜 `ns5.xserver.jp` → **現在はVercelに変更済み** |
| DNSゾーン | Vercel管理（Settings → Domains → DNS Records） |
| メール利用 | まだ無し |

**ゾーンが未作成＝壊すものが何も無い。** だからネームサーバーごとVercelに預けるのが最短で最も安全。

---

## STEP 1 — VercelにGitHubリポジトリをImport

**✅ 完了済み。STEP 2 へ進む。**

---

## STEP 2 — Vercelにドメインを追加

1. Vercelダッシュボード → 対象プロジェクト → **Settings** タブ
2. 左メニュー **Domains**
3. 入力欄に `memorio.gift` を入れて **Add**
4. 案内が出たら **Nameservers**（ネームサーバー方式）を選ぶ
   - `A / CNAME` 方式も出るが、**Nameservers を選ぶ**
5. 表示されたネームサーバー2件を下にメモする

| # | Vercelが表示した値         | 想定される値 |
|---|----------------------|---|
| 1 | `ns1.vercel-dns.com` | `ns1.vercel-dns.com` |
| 2 | `ns2.vercel-dns.com`                    | `ns2.vercel-dns.com` |

> 右列は一般的な値。**画面に出た値が違っていたら、画面の値が正解。**

6. `www.memorio.gift` は **Add しなくてよい**
   - ネームサーバー方式では、ルートと第一階層サブドメインのレコードが自動生成される
   - `www` からのリダイレクトが欲しければ、この画面で後から追加すればよい

✅ **STEP 2 完了の合図**: 上の表の2行が埋まっている

---

## STEP 3 — Xserverのネームサーバーを書き換える

> ❓ **「ドメイン適用先サービス」を聞かれたら → 「Xserverドメイン」を選ぶ**（レンタルサーバーではない）。
> どちらでもSTEP 3でネームサーバーを上書きするので結果は同じだが、
> レンタルサーバーを選ぶとサーバーパネルに使わないドメイン設定とSSLが残る。
> **すでにレンタルサーバーで登録済みでもやり直し不要。** そのままSTEP 3を進めてよい。

1. **Xserverアカウント**（`secure.xserver.ne.jp`）にログイン
   - サーバーパネルではない。**Xserverアカウント**の方
2. 左メニュー **ドメイン** → **ドメイン一覧**
3. `memorio.gift` の行にある **ネームサーバー設定** を押す
4. **「その他のサービスで利用する」** を選ぶ
5. 入力欄に STEP 2 でメモした値を入れる

| 欄 | 入れる値 |
|---|---|
| ネームサーバー1 | `ns1.vercel-dns.com` |
| ネームサーバー2 | `ns2.vercel-dns.com` |
| ネームサーバー3〜5 | **空欄にする**（`ns3.xserver.jp` 等が残っていたら消す） |

6. **確認画面へ進む** → **設定を変更する**

> ⚠️ 3〜5番の欄にXserverのネームサーバーが残っていると、
> Vercelとxserverが半分ずつ応答する不安定な状態になる。**必ず空にする。**

✅ **STEP 3 完了の合図**: ネームサーバー欄がVercelの2件だけになっている

---

## STEP 4 — 反映を待って確認する

ターミナルでこれを打つ:

```bash
dig +short memorio.gift NS
```

**期待する結果**:
```
ns1.vercel-dns.com.
ns2.vercel-dns.com.
```

`ns1.xserver.jp` が返る、または**何も返らない** → **まだ反映中**。正常。

- 目安: **1〜3時間**
- 最大: 48時間（レジストリの更新待ち）

反映されたら、続けてこれを確認:

```bash
dig +short memorio.gift A
curl -I https://memorio.gift
```

そしてVercelの **Settings → Domains** を再読み込みする。
緑の **Valid Configuration** に変われば、HTTPS証明書も自動発行される。

✅ **全STEP完了の合図**: `https://memorio.gift` でLPが表示され、鍵マークが付いている

---

## これで何ができるようになったか

- `main` に push すると、**自動で本番に反映される**
- Pull Request を作ると、**専用のプレビューURL**が発行される（写真差し替えの確認に使える）
- HTTPS証明書は**自動更新**。放置してOK
- DNSレコードの追加・変更は、以後すべて **Vercel の Settings → Domains → DNS Records** で行う

### 以降のデプロイ方法

**自動（ふだん使うのはこっち）**

```bash
git add -A && git commit -m "更新内容" && git push
```

push後1〜2分で本番反映。

**手動で今すぐ上げたいとき**

```bash
npx vercel --prod
```

---

## 詰まったときの対処

| 症状 | 原因 | 対処 |
|---|---|---|
| 半日経っても `dig NS` がxserverのまま | STEP 3 の「設定を変更する」を押していない | Xserverアカウントで設定内容を再確認 |
| つながる時とつながらない時がある | ネームサーバー3〜5にxserverが残っている | STEP 3 の欄を空にする |
| NSは変わったがVercelがInvalid | Vercel側の反映待ち | 30分待ってDomains画面を再読み込み |
| 証明書エラーが出る | 証明書の発行待ち | 10分待つ。1時間超えたらVercelでドメインを一度Removeして再Add |

上のどれでもない場合は、`dig +short memorio.gift NS` と `dig +short memorio.gift A` の出力をそのまま貼って相談する。

---

## 付録A — 後で `info@memorio.gift` を使いたくなったら

DNSはVercelが持っているので、**Xserverのサーバーパネルではなく Vercel 側にMXを入れる**。

1. Xserverのサーバーパネルで対象ドメインのメールアカウントを作る
2. サーバーパネルで**メールサーバーのホスト名**を確認（`svXXXX.xserver.jp` 形式）
3. Vercel → Settings → Domains → **DNS Records** で追加:

| Name | Type | Value | Priority |
|---|---|---|---|
| （空欄） | MX | Xserverのメールサーバー名 | 10 |
| （空欄） | TXT | `v=spf1 +a:svXXXX.xserver.jp ~all` | — |

この作業は**LP公開とは独立**。急がなくてよい。

---

## 付録B — どうしてもDNSをXserverで持ちたい場合

ネームサーバーを `ns*.xserver.jp` のまま使う方式。手数が増えるので**非推奨**だが、記録として残す。

1. Vercelの Domains で `memorio.gift` を Add し、**A / CNAME 方式**を選んで値をメモ
2. Xserverのサーバーパネル → **ドメイン設定** に `memorio.gift` があれば**削除**
3. サーバーパネル → **DNSレコード設定** → XserverのIPを指す **Aレコードを削除**
4. 同画面で追加: ホスト名 空欄 / 種別 `A` / 内容 Vercelの値
5. 同画面で追加: ホスト名 `www` / 種別 `CNAME` / 内容 Vercelの値

STEP 3 の削除漏れが最頻の失敗原因。

---

## 未対応リスト（このデプロイとは別件）

- `assets/main-visual.png` が **2.98MB**。ヒーロー全面背景なのでLCPに直撃する。WebP化＋リサイズで200〜400KBが目標
- 実写画像への差し替え（シーン7枚 / カラー5枚 / アプリ1枚）
- `<head>` の `og:url` / `og:image` が旧 `memorio-congrats-lp.vercel.app` のまま → `www.memorio.gift` に差し替え
