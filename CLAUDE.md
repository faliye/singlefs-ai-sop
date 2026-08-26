<!-- doc-lint:rule-definition -->
# singlefs-ai-sop-zh

**贡献者治理规范与门禁工具（Contributor Governance）。**
管的是**项目怎么和 AI 协作**，不管某一类系统怎么设计。
在本仓库里工作时同样受这些规则约束。

改 `rules/` 或 `scripts/` **必须同时抬 `VERSION`**，否则各项目的门禁会报版本不一致。

## 对话语言

**在本仓工作时，对话与产出一律用中文。**

**开发者按自己的语言选用对应版本**，目前有中文、英语、日语，更多版本开发中，
默认版本是英语。装哪种语言的仓，就用那种语言作业——用中文的不必读英文，
用日文的不必读中文。**AI 也就不必再翻译一道**，少一次转述就少一次信息损失。

规则内容各版本必须一致。读法不一致时不看语种，以 `scripts/` 的实际行为为准。

**改规则就得所有已发布的语言版本一起改、一起合并**，一致性由改的人自己保证——
门禁只看得出哈希对不上，看不出各版本说的是不是同一件事。

## 规则（始终生效）

@rules/engineering-philosophy.md
@rules/sop-first.md
@rules/show-me-test.md
@rules/machine-first.md
@rules/doc-discipline.md
@rules/design-doc-discipline.md
@rules/kb-discipline.md
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
  **项目专有的规则进 `.claude/rules/`**，项目专用脚本留在 `.claude/scripts/`。

判据里的「别的项目」指的是**任何**用这套 SOP 的项目，不是「同类项目」。
一条只有文件系统才需要的纪律，哪怕写得再好，也是项目本地的——
本仓管的是**项目怎么和 AI 协作**，不管某一类系统怎么设计。

反过来：在项目文件里发现一段**别的项目也照抄了一遍**的内容，
那就是本仓库漏了一条——提上来，别抄第三遍。

## 接法

各项目不复制本仓库内容，三层各有接法（**不使用符号链接**）：

| 层 | 接法 |
|---|---|
| rules | 项目 `CLAUDE.md` 用 `@.claude/singlefs-ai-sop/rules/x.md` 引用，项目里不留副本 |
| 项目本地规则 | 放 `.claude/rules/x.md`，项目 `CLAUDE.md` 里用 `@.claude/rules/x.md` 引用。不上游 |
| skills | 项目 `.claude/skills/<名>/SKILL.md` 是**桩**：frontmatter + 指向共享正文 |
| scripts | 项目 `.claude/scripts/x.sh` 是**包装**：设好环境后 `exec` 共享脚本 |

桩和包装里不写正文/逻辑——写在那里别的项目看不到，下次又会被抄一遍。
