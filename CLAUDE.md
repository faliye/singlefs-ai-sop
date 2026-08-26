<!-- doc-lint:rule-definition -->
# singlefs-ai-sop-zh

**贡献者治理规范与门禁工具（Contributor Governance）。**
管的是**项目怎么和 AI 协作**，不管文件系统怎么设计。
使用者只有 singlefs 一个。在本仓库里工作时同样受这些规则约束。

改 `rules/` 或 `scripts/` **必须同时抬 `VERSION`**，否则项目侧的门禁会报版本不一致。

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

**这套 SOP 是为 singlefs 做的，使用者只有 singlefs 一个，不预设在别的项目上通用。**
所以判据不是「别的项目会不会也需要它」——没有别的项目可看，
那句话谁都能答「会」，答完什么都往上游放。

一条内容该放哪，看它管的是什么：

- **管协作**——提交要带什么证据、文档怎么写、决策记在哪、门禁拒绝时给什么下一步。
  → 本仓库。方法论进 `rules/`，流程进 `skills/`，能跑的进 `scripts/`。
- **管文件系统怎么设计**——事务、崩溃一致性、盘上格式，这一类系统特有的纪律。
  → 项目本地。设计决策进 `kb/decisions.md`，不变量进 `kb/invariants.md`，
  **项目专有的规则进 `.claude/rules/`**，项目专用脚本留在 `.claude/scripts/`。

**拿不准就放项目本地。** 上游一条不该上游的规矩，此后每一轮工作都要绕开它；
放项目本地放错了，改回来只动一个文件。

## 接法

项目不复制本仓库内容，三层各有接法（**不使用符号链接**）：

| 层 | 接法 |
|---|---|
| rules | 项目 `CLAUDE.md` 用 `@.claude/singlefs-ai-sop/rules/x.md` 引用，项目里不留副本 |
| 项目本地规则 | 放 `.claude/rules/x.md`，项目 `CLAUDE.md` 里用 `@.claude/rules/x.md` 引用。不上游 |
| skills | 项目 `.claude/skills/<名>/SKILL.md` 是**桩**：frontmatter + 指向共享正文 |
| scripts | 项目 `.claude/scripts/x.sh` 是**包装**：设好环境后 `exec` 共享脚本 |

桩和包装里不写正文/逻辑——正文只该有一处，写进桩里就多出第二处，两处早晚说不同的话。
