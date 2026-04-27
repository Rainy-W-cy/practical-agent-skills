# Practical Agent Skills

Practical Agent Skills for AI coding agents, with a focus on research, paper reading, writing, and workflow support.

This repository contains independent skill folders. Each skill is documented by its own `SKILL.md` and may include additional `references/`, `scripts/`, `agents/`, or `assets/` when needed.

## Skills

| Skill | Summary |
|---|---|
| `find-skills` | Finds, evaluates, compares, adapts, or recommends Agent Skills. It helps decide whether to use a local skill, install an external skill, combine skills, modify an existing skill, create a custom skill, or complete the task directly. |
| `generic-paper-reader-zh` | 通用中文论文解读与评审技能，适用于各学科论文的快速初筛、系统总结、贡献分析、证据检查、局限评估和阅读建议。 |
| `specialized-paper-reader-zh` | 面向 AI、加速器、NPU、模型量化、推理优化、编译部署和系统架构方向的中文论文解读与 review 技能。 |

## Repository Layout

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
   └─ specialized-paper-reader-zh/
      ├─ SKILL.md
      ├─ agents/
      └─ references/
```

## Install

Install a specific skill with the Skills CLI:

```bash
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill find-skills
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill generic-paper-reader-zh
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill specialized-paper-reader-zh
```

If your Skills CLI supports target agents, you may specify one:

```bash
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill find-skills -a codex
npx skills add https://github.com/Rainy-W-cy/practical-agent-skills --skill find-skills -a claude-code
```

Restart the target agent after installation.

## Manual Install

Copy the whole skill folder, not only `SKILL.md`, because some skills include supporting files.

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

For other agents, use the skill directory documented by that agent. If direct skill loading is not supported, adapt the relevant `SKILL.md` content into project rules or custom instructions.

## Usage Examples

```text
Use find-skills to find a skill for academic paper writing.
Use generic-paper-reader-zh to explain this paper and judge whether it is worth reading carefully.
Use specialized-paper-reader-zh to review this AI accelerator paper from a reproducibility perspective.
```

## Notes

- Inspect third-party skills before installing or running bundled scripts.
- Check licenses before reusing skills in public, academic, or commercial projects.
- Keep each skill self-contained under `skills/<skill-name>/`.
