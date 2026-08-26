# singlefs-ai-sop-zh

**singlefs 工程的贡献者治理规范与门禁工具（Contributor Governance），独立分发。**

> **实现上 AI 友好，审核上人类友好。**
>
> 这是整套规范的组织原则，展开见 [rules/engineering-philosophy.md](rules/engineering-philosophy.md)。

任何参与 singlefs 的人克隆这个仓库到自己的工作副本里，就拿到**同一份**规矩、
**同一套**门禁脚本、**同一批** skill。一致性靠共享同一个源保证，不靠各自抄。

## 里面有什么

| 目录 | 内容 |
|---|---|
| `CLAUDE.md` | **共享规范正文。** 文档铁律、Show me test 准入铁律、设计纪律、测试纪律、命令规范 |
| `scripts/` | **门禁脚本。本仓库最重要的部分**，规矩的可执行形式 |
| `skills/` | Claude Code skill：怎么跑门禁、怎么记决策、怎么做崩溃测试 |
| `templates/` | 项目侧 `CLAUDE.md` 与 `kb/` 的骨架 |
| `VERSION` | 规范版本号。门禁会检查目标项目声明的版本是否与本包一致 |

## 装到一个项目里

```bash
cd <你的项目>
git clone https://<host>/singlefs-ai-sop-zh .claude/singlefs-ai-sop
bash .claude/singlefs-ai-sop/install.sh
```

`install.sh` 做三件事，**每一步都会回读验证，失败即非零退出**：

1. 在项目根写 `CLAUDE.md`（若不存在），内容是一层薄壳 + 指向共享规范
2. 建 `.claude/kb/` 骨架（若不存在）
3. 在项目根写 `.singlefs-ai-sop-version`，记录当前规范版本

**已存在的文件一律不覆盖**，只报告差异。

## 为什么规范要独立成仓

因为 [rules/show-me-test.md](rules/show-me-test.md) 那条准入铁律——**判据是自动化验证**——
只有在所有人跑的是同一套门禁时才成立。各项目各自维护一份 `.claude`，
三个月后就会出现"我这边是过的"，那条铁律当场失效，
**提交者也就无从知道自己该验到什么程度**——而那正是门禁要替他们回答的问题。

## 多语言：蓝本在本仓，译本各自成仓

**中文是蓝本，不是权威。**

蓝本指的是「改动从哪里发起」——用中文写是为了**效率和表达精度**，
不代表它比别的语言更正确。**三份文本地位相同**，没有哪一份是真理。

真正消歧的是 `scripts/`：**各语言读法不一致时，以脚本的实际行为为准。**
脚本是这套规则唯一没有歧义的表述，这也是 `sop-first.md`
要求「一条规则要能变成一个会失败的检查」的第二个理由——
**能变成检查的规则，翻译不走样。**

### 三个仓，一个目录名

```
singlefs-ai-sop-zh     中文（蓝本）
singlefs-ai-sop-ja     日文
singlefs-ai-sop-en     英文
```

声明的语言列在 `LANGUAGES` 里。译本不进本仓——
把 N 种语言塞进同一个仓会让它随语言数线性膨胀，而「薄」正是这个仓的卖点。

项目安装时**只 clone 自己那一种**，目录名统一：

```bash
git clone https://<host>/singlefs-ai-sop-ja .claude/singlefs-ai-sop
```

因为目录名一样，`@` 引用路径和脚本包装**一个字都不用改**——换语言就是换 clone 源。

### 三份必须同步更新

**改了任何一份，其余两份必须一起更新。** 由门禁强制，见 `scripts/i18n-sync.sh`。

对账靠 `MANIFEST.sha256`——`rules/*.md` 的路径与哈希。
译本仓在生成时抄走一份存成 `SOURCE-MANIFEST.sha256`，
之后只要比两份清单，就知道哪几篇落后了。
本仓因此只多**两个小文件**，仍然是单语言、薄的。

改了 `rules/` 就要跑 `bash scripts/manifest.sh --update`，
否则门禁会红——**清单停滞等于所有译本都显示「最新」，而它们其实已经落后。**

### 译本是生成物，不是平行版本

不许直接编辑译本来修正规则——要改就改蓝本，然后重新生成三份。

理由是本仓自己的规矩（`kb-discipline.md`）：**矛盾比空白更糟**。
三份手工维护的规则文件，几次改动之后必然分叉，
而读译本的人不会知道自己读的是旧的。

**唯一的例外**：翻译本身错了（译错、走样、术语不一致）——
那要改译本，并且**回头检查蓝本是不是也表述得不够清楚**。
翻译暴露歧义是它的附带价值，别浪费。

## 更新规范

改 `CLAUDE.md` 或 `scripts/` 必须同时抬 `VERSION`。
各项目 `git pull` 后跑一次 `scripts/gate.sh`，版本不匹配会报出来。

## 许可

双许可：[Apache-2.0](LICENSE-APACHE) 或 [MIT](LICENSE-MIT)，任选其一，
与 [singlefs](https://github.com/faliye/singlefs) 保持一致。

除非你明确另行声明，任何你有意提交并被本项目采纳的贡献，
按 Apache-2.0 的定义，都将按上述双许可授权，不附加任何额外条款。
