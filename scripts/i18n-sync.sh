#!/usr/bin/env bash
# 各语言文本必须同步：改了任何一份，声明的每种语言都要跟上。
# this 标明本仓是哪种语言（清单与门禁脚本放在这儿）；default 是给使用者的默认版本。
#
#   i18n-sync.sh [各语言仓所在目录]   默认找本仓的兄弟目录
#
# 检查什么：对 LANGUAGES 里声明的每种语言，
#   1. 那个语言的仓在不在  —— 不在则「无法检查」，按失败处理，不静默放过
#   2. 它抄走的清单是不是当前清单
#   3. 清单里每一篇在那个仓里有没有对应文件
#
# 判据（按 kb-discipline「矛盾比空白更糟」定，但对已声明的语言收紧）：
#   已声明的语言缺文件或落后 —— 都失败。声明了却不跟，等于给人一份过期的规则。
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

PKG="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROOT="${1:-$(dirname "$PKG")}"
MF="$PKG/MANIFEST.sha256"
CF="$PKG/I18N"

head1 "三语同步"

[[ -f "$CF" ]] || { ok "未声明语言族，本阶段不适用"; exit 0; }
FAMILY="$(sed -n 's/^family=//p' "$CF")"
THIS="$(sed -n 's/^this=//p' "$CF")"
LANGS="$(sed -n 's/^languages=//p' "$CF")"
[[ -n "$FAMILY" && -n "$THIS" && -n "$LANGS" ]] || {
  bad "I18N 配置不完整"
  howto "四行都要有：family=<族名>  this=<本仓语言>  default=<默认版本语言>  languages=<空格分隔>"; exit 1; }
[[ -f "$MF" ]] || { bad "缺 MANIFEST.sha256"; howto "跑： bash scripts/manifest.sh --update"; exit 1; }

fails=0
for lang in $LANGS; do
  [[ "$lang" == "$THIS" ]] && continue   # 本仓就是这一种语言，不用跟自己对账
  repo="$ROOT/$FAMILY-$lang"
  if [[ ! -d "$repo" ]]; then
    bad "$lang  找不到译本仓 $repo"
    howto "克隆到本仓的兄弟目录，或指定位置：" \
          "bash scripts/i18n-sync.sh /path/to/repos" \
          "找不到就无法检查——按失败处理，不静默放过（rules/show-me-test.md）。"
    fails=$((fails+1)); continue
  fi
  sm="$repo/SOURCE-MANIFEST.sha256"
  if [[ ! -f "$sm" ]]; then
    bad "$lang  译本仓缺 SOURCE-MANIFEST.sha256"
    howto "更新该语言时把本仓的 MANIFEST.sha256 抄过去存成这个名字。"
    fails=$((fails+1)); continue
  fi
  if ! diff -q "$MF" "$sm" >/dev/null 2>&1; then
    bad "$lang  落后：与清单不一致"
    diff "$MF" "$sm" | grep '^<' | awk '{print $3}' | sed 's/^/        待重译: /' | head -10
    howto "把上面这几篇在该语言仓里改到位，然后把本仓的 MANIFEST.sha256 抄成它的 SOURCE-MANIFEST.sha256。" \
          "别只抄清单不改内容——那样门禁会绿，而用那种语言的人拿到的是旧规则。"
    fails=$((fails+1)); continue
  fi
  # 版本必须完全一致：一个升级三个升级
  tv="$(cat "$repo/VERSION" 2>/dev/null || echo '')"
  bv="$(cat "$PKG/VERSION" 2>/dev/null || echo '')"
  if [[ "$tv" != "$bv" ]]; then
    bad "$lang  版本不一致：$lang ${tv:-无} / 本仓 ${bv:-无}"
    howto "三份必须同版本。用这条命令一次升全部，不要手改单个 VERSION：" \
          "bash scripts/bump.sh <x.y.z>"
    fails=$((fails+1)); continue
  fi

  miss=0
  while read -r _ path; do
    [[ -f "$repo/$path" ]] || { miss=$((miss+1)); say "        缺: $path"; }
  done < "$MF"
  if [[ $miss -gt 0 ]]; then
    bad "$lang  清单一致但缺 $miss 个文件"
    howto "补齐这几篇译文。声明了这种语言却不给全，等于给人一份残缺的规则。"
    fails=$((fails+1))
  else
    ok "$lang  与清单一致（$(wc -l < "$MF") 篇）"
  fi
done

say ""
[[ $fails -eq 0 ]] || { bad "三语同步失败：$fails 种语言未跟上"; exit 1; }
ok "声明的所有语言都与清单一致"
