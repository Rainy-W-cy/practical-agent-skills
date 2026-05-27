# Practical Agent Skills（实用代理技能）

面向 AI 编码代理的实用技能集，重点覆盖研究、论文阅读、写作、演示文稿制作、编码安全和工作流支持。

本仓库包含彼此独立的技能目录。每个技能均由自身的 `SKILL.md` 进行说明，并可根据需要包含额外的 `references/`、`scripts/`、`agents/` 或 `assets/` 目录。

## 技能列表

| 技能 | 简介 |
|---|---|
| `find-skills` | 查找、评估、比较、适配或推荐 Agent Skills，帮助判断应使用本地技能、安装外部技能、组合或修改现有技能、创建自定义技能，还是直接完成任务。 |
| `generic-paper-reader-zh` | 通用中文论文解读与评审技能，适用于各学科论文的快速初筛、系统总结、贡献分析、证据检查、局限评估和阅读建议。 |
| `markdown-encoding-guard` | 确保 Markdown 文件以 UTF-8 without BOM 编码写入，并校验乱码或替换字符导致的内容损坏。 |
| `notion-write-math-encoding-guard` | 在为 Notion 页面准备中英混排的 Markdown 与 LaTeX 内容时，防止文本和公式损坏。 |
| `pptx-com` | 面向 Windows 桌面版 Microsoft PowerPoint 的原生可编辑 PPTX 工作流，通过 COM 完成读取、制作、修改、导出和质量检查。 |
| `specialized-paper-reader-zh` | 面向 AI、加速器、NPU、模型量化、推理优化、编译部署和系统架构方向的中文论文解读与评审技能。 |

## 仓库结构

```text
practical-agent-skills/
├─ README.md
├─ LICENSE
└─ skills/
   ├─ find-skills/
   │  └─ SKILL.md
   ├─ generic-paper-reader-zh/
   │  ├─ SKILL.md
   │  └─ references/
   ├─ markdown-encoding-guard/
   │  └─ SKILL.md
   ├─ notion-write-math-encoding-guard/
   │  ├─ SKILL.md
   │  ├─ agents/
   │  └─ references/
   ├─ pptx-com/
   │  ├─ SKILL.md
   │  ├─ README.md
   │  ├─ agents/
   │  ├─ references/
   │  └─ scripts/
   └─ specialized-paper-reader-zh/
      ├─ SKILL.md
      ├─ agents/
      └─ references/
```

## 安装

使用 Skills CLI 安装指定技能：

```bash
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill find-skills
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill generic-paper-reader-zh
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill markdown-encoding-guard
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill notion-write-math-encoding-guard
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill pptx-com
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill specialized-paper-reader-zh
```

如果所使用的 Skills CLI 支持指定目标代理，可添加目标代理参数：

```bash
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill find-skills -a codex
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill find-skills -a claude-code
```

安装完成后，请重启目标代理。

## 手动安装

请复制完整的技能目录，而不是仅复制 `SKILL.md`，因为部分技能还包含配套文件。

Codex:

```bash
mkdir -p ~/.codex/skills/find-skills
cp -R skills/find-skills/* ~/.codex/skills/find-skills/
```

Claude Code:

```bash
mkdir -p ~/.claude/skills/find-skills
cp -R skills/find-skills/* ~/.claude/skills/find-skills/
```

对于其他代理，请使用该代理文档指定的技能目录。如果代理不支持直接加载技能，可以将对应 `SKILL.md` 的内容适配为项目规则或自定义指令。

## 使用示例

```text
使用 find-skills 查找适合学术论文写作的技能。
使用 generic-paper-reader-zh 解读这篇论文，并判断是否值得精读。
使用 markdown-encoding-guard 编写这份需要在 VSCode 中预览的中文 Markdown 笔记。
使用 notion-write-math-encoding-guard 为 Notion 准备这段包含公式的中英混排内容。
使用 pptx-com 审阅这个 PowerPoint 演示文稿，或在 Windows 上制作可编辑的演示文稿。
使用 specialized-paper-reader-zh 从可复现性角度评审这篇 AI 加速器论文。
```

## 注意事项

- 安装第三方技能或运行其附带脚本前，请先检查其内容。
- 在公开、学术或商业项目中复用技能前，请检查其许可证。
- 每个技能应在 `skills/<skill-name>/` 目录下保持自包含。
