#!/usr/bin/env python3
"""index.html の静的検査。make check から呼ばれる。

検査内容:
  1. HTMLタグの対応とコメントの妥当性
  2. ローカル参照アセットの存在
  3. 重いアセット（しきい値超え）の警告
  4. OGP/canonical が本番ドメインを指しているか
  5. LINE URL の定義が1か所か
  6. .vercelignore で除外されるファイルを参照していないか

終了コード: 0=OK / 1=エラーあり（警告のみなら0）
"""
import io
import os
import re
import sys
from html.parser import HTMLParser

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TARGET = os.path.join(ROOT, "index.html")
SITE = "https://www.memorio.gift"
HEAVY_KB = 500

VOID = {"img", "input", "br", "hr", "meta", "link", "source", "area",
        "base", "col", "embed", "param", "track", "wbr"}

errors = []
warnings = []
oks = []


def err(msg):
    errors.append(msg)


def warn(msg):
    warnings.append(msg)


def ok(msg):
    oks.append(msg)


src = io.open(TARGET, encoding="utf-8").read()


# --- 1. タグ対応とコメント -----------------------------------------------
class Balance(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.stack = []
        self.bad = []

    def handle_starttag(self, tag, attrs):
        if tag not in VOID:
            self.stack.append(tag)

    def handle_endtag(self, tag):
        if tag in VOID:
            return
        if not self.stack:
            self.bad.append("余分な </%s>" % tag)
            return
        if self.stack[-1] == tag:
            self.stack.pop()
        elif tag in self.stack:
            while self.stack[-1] != tag:
                self.bad.append("閉じ忘れ <%s>" % self.stack.pop())
            self.stack.pop()
        else:
            self.bad.append("対応しない </%s>" % tag)


b = Balance()
b.feed(src)
if b.bad or b.stack:
    for m in (b.bad + ["閉じ忘れ <%s>" % t for t in b.stack])[:10]:
        err("HTML構造: " + m)
else:
    ok("HTMLタグの対応")

comments = re.findall(r"<!--(.*?)-->", src, re.S)
for c in comments:
    if "--" in c:
        err("HTMLコメント内に `--` があり不正です")
if src.count("<!--") != len(comments):
    err("閉じられていないHTMLコメントがあります")
else:
    ok("HTMLコメント %d 件" % len(comments))


# --- 2. ローカル参照アセットの存在 ---------------------------------------
refs = set()
for m in re.finditer(r'(?:src|href)="([^"{}]+)"', src):
    u = m.group(1)
    if u.startswith(("http://", "https://", "//", "#", "data:", "mailto:")):
        continue
    refs.add(u.split("?")[0].split("#")[0].lstrip("./"))

missing = sorted(r for r in refs if not os.path.exists(os.path.join(ROOT, r)))
if missing:
    for r in missing:
        err("参照先が存在しない: %s" % r)
else:
    ok("ローカル参照 %d 件すべて存在" % len(refs))


# --- 3. 重いアセット -----------------------------------------------------
heavy = []
for r in sorted(refs):
    path = os.path.join(ROOT, r)
    if not os.path.exists(path):
        continue
    kb = os.path.getsize(path) / 1024
    if kb > HEAVY_KB:
        heavy.append((kb, r))
for kb, r in sorted(heavy, reverse=True):
    warn("%.0f KB %s（%d KB超）" % (kb, r, HEAVY_KB))
if not heavy:
    ok("参照アセットはすべて %d KB 以下" % HEAVY_KB)


# --- 4. OGP / canonical --------------------------------------------------
stale = re.findall(r'(?:content|href)="(https://[^"]*vercel\.app[^"]*)"', src)
if stale:
    for u in sorted(set(stale)):
        err("旧ドメインが残っている: %s" % u)
else:
    ok("旧 vercel.app URL なし")

for prop, pat in [
    ("canonical", r'<link rel="canonical" href="([^"]+)"'),
    ("og:url", r'<meta property="og:url" content="([^"]+)"'),
    ("og:image", r'<meta property="og:image" content="([^"]+)"'),
]:
    m = re.search(pat, src)
    if not m:
        err("%s が未設定" % prop)
    elif not m.group(1).startswith(SITE):
        err("%s が本番ドメインを指していない: %s" % (prop, m.group(1)))
    else:
        ok("%s = %s" % (prop, m.group(1)))

m = re.search(r'<meta property="og:image" content="%s(/[^"]+)"' % re.escape(SITE), src)
if m:
    path = os.path.join(ROOT, m.group(1).lstrip("/"))
    if not os.path.exists(path):
        err("og:image のファイルがローカルに無い: %s" % m.group(1))
    else:
        kb = os.path.getsize(path) / 1024
        if kb > 1024:
            err("og:image が %.0f KB。1MB以下にする（make og）" % kb)
        else:
            ok("og:image %.0f KB" % kb)


# --- 5. LINE URL の定義箇所 ----------------------------------------------
line_defs = re.findall(r"lineUrl\s*=\s*'([^']+)'", src)
if len(line_defs) != 1:
    err("lineUrl の定義が %d か所（1か所であるべき）" % len(line_defs))
else:
    ok("lineUrl = %s（定義1か所）" % line_defs[0])

cta = src.count("{{ lineUrl }}")
if cta == 0:
    err("LINE CTA が0件")
else:
    ok("LINE CTA %d 件" % cta)


# --- 6. .vercelignore で除外されるファイルを参照していないか --------------
ignore_path = os.path.join(ROOT, ".vercelignore")
if os.path.exists(ignore_path):
    pats = [l.strip().rstrip("/") for l in io.open(ignore_path, encoding="utf-8")
            if l.strip() and not l.startswith("#")]
    leaked = [r for r in sorted(refs)
              if any(r == p or r.startswith(p + "/") for p in pats)]
    if leaked:
        for r in leaked:
            err("デプロイ除外されるファイルを参照: %s" % r)
    else:
        ok(".vercelignore との矛盾なし")


# --- 出力 ----------------------------------------------------------------
for m in oks:
    print("  \033[32mOK\033[0m   %s" % m)
for m in warnings:
    print("  \033[33mWARN\033[0m %s" % m)
for m in errors:
    print("  \033[31mNG\033[0m   %s" % m)

print()
print("check: OK %d / WARN %d / NG %d" % (len(oks), len(warnings), len(errors)))
sys.exit(1 if errors else 0)
