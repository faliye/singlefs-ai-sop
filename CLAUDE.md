<!-- doc-lint:rule-definition -->
# singlefs-ai-sop-zh

**singlefs 工程的贡献者治理规范与门禁工具（Contributor Governance）。**
在本仓库里工作时同样受这些规则约束。

改 `rules/` 或 `scripts/` **必须同时抬 `VERSION`**，否则各项目的门禁会报版本不一致。

## 规则（始终生效）

@rules/engineering-philosophy.md
@rules/sop-first.md
@rules/show-me-test.md
@rules/machine-first.md
@rules/doc-discipline.md
@rules/design-doc-discipline.md
@rules/kb-discipline.md
@rules/fs-design.md
@rules/format-evolution.md
@rules/test-discipline.md
@rules/evidence-discipline.md
@rules/verify-before-claiming.md
@rules/command-safety.md
@rules/writing-economy.md
@rules/session-wrapup.md

## 分工判据

一条内容该放哪，问一句「**别的项目会不会也需要它**」：

- 会 → 本仓库。方法论进 `rules/`，流程进 `skills/`，能跑的进 `scripts/`。
- 不会 → 项目本地。设计决策进 `kb/decisions.md`，不变量进 `kb/invariants.md`，
  项目专用脚本留在项目 `.claude/scripts/`。

反过来：在项目文件里发现一段**别的项目也照抄了一遍**的内容，
那就是本仓库漏了一条——提上来，别抄第三遍。

## 接法

各项目不复制本仓库内容，三层各有接法（**不使用符号链接**）：

| 层 | 接法 |
|---|---|
| rules | 项目 `CLAUDE.md` 用 `@.claude/singlefs-ai-sop/rules/x.md` 引用，项目里不留副本 |
| skills | 项目 `.claude/skills/<名>/SKILL.md` 是**桩**：frontmatter + 指向共享正文 |
| scripts | 项目 `.claude/scripts/x.sh` 是**包装**：设好环境后 `exec` 共享脚本 |

桩和包装里不写正文/逻辑——写在那里别的项目看不到，下次又会被抄一遍。
