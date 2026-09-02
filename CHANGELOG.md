# CHANGELOG

规则与门禁的版本历史。`CLAUDE.md` 与 `rules/*.md` 不留历史节（design-doc-discipline），
历史一律记在这里；逐条改动细节见 `git log`，提交信息即变更说明。

## 0.0.23 — 2026-09-02

对抗审计后的整批门禁修复（审计报告见当轮会话记录）：

- doc-lint：围栏未闭合判红；「历史版本」之后再开 `##` 小节判红；不变量定义
  不再认历史节里的表格；rules 文件留历史节判红；rule-definition 标记限定
  CLAUDE.md / rules / skills 三处；not-numbers 豁免已登记编号判红；
  「脚本文件」「同上游」这类构词不再误判为指代（首字排除）。
- gate-lint：bad 认全形态（单双引号、变量、`;{|&`/`then`/`else` 之后）；
  注释里的 howto 字样不算出路；汇总豁免收紧为「失败/未通过/未过：$计数」。
- Show me test 拆成 show-me-test.sh：注释里的 `#[test]` 不算；tests/ 只认 `.rs`；
  build.rs 也是代码；在默认分支上基准退到 HEAD~1，先提交再跑门禁不再「无对象可判」。
- lkmm：每条 Never 必须有同名 `-nofence` 配对对照，全局数一条 Sometimes 不再算数；
  静态检查前置到 herd7 探测之前；全部拒绝补 howto。
- i18n-sync / manifest：失败分支的 diff 诊断管道在 set -e + pipefail 下会把脚本
  中途带走（howto 与后续语言全丢）——补 `|| true`；三语同步前先验清单新鲜度；
  GLOSSARY.md 并入共享区同步。
- 新增 version-discipline.sh：改规范本体不抬 VERSION 直接红（原是提醒句）。
- selftest 泛化到全部门禁脚本：doc-lint / gate-lint / lkmm 样本目录 +
  show-me-test / version-discipline / manifest / i18n-sync 脚本化用例，共 51 例。

## 0.0.22 — 2026-09-02

- session-wrapup 增补「同一个仓里有没有别的会话在飞」一节；show-me-test 增补
  变异清单；test-discipline 增补「确定性模型 N 轮」「变异测试证明的是断言会红」；
  GLOSSARY 新增变异测试相关术语。

## 0.0.21 及更早

见 `git log --oneline`——每条提交信息都按「版本：改了什么」写。
