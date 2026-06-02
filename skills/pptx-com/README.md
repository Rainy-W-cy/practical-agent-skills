# pptx-com

`pptx-com` 是一个面向 Windows 桌面版 Microsoft PowerPoint 的 Codex skill。它通过 Windows COM 调用真实 PowerPoint，创建、修改、审阅、预览或导出 `.pptx` 文件，而不是默认依赖 PowerPoint MCP、PptxGenJS 或直接修改 PPTX XML。

README 只用于介绍流程；执行规则以 `SKILL.md` 和 `references/` 中的门禁与细则为准。

## 能做什么

- 读取、总结、审阅已有 PPT。
- 修改、润色、重排、翻译、缩短、扩展或统一已有 PPT，但默认在副本中进行。
- 根据提纲、PDF、论文、文档、报告、Markdown、笔记或归纳材料生成 PPT。
- 基于模板副本制作或修改演示文稿。
- 根据参考图、截图、论文图或视觉草稿复现 PPT 图。
- 使用 PowerPoint 原生文本、形状、连接线、表格、图表、图片和公式。
- 根据确认的数据基准制作或修改表格、图表、指标卡和定量对比页。
- 可选使用 draw.io 生成复杂图，并导出 SVG/PNG 后插入 PPT。
- 按需显示 PowerPoint 逐页生成过程。
- 按需导出 PDF 或页面预览。

## 硬门禁

### 文档/PDF/论文生成新 PPT

只要是依据文档、PDF、论文、报告、笔记或归纳材料生成新的 PPT，无论是否提供模板，都必须先有经过用户确认的详细 Markdown plan。

用户已经提供足够完整的 plan 时，不重复生成新的 plan；但必须先审阅 plan 是否包含页数、逐页目标、核心结论、具体内容、素材/证据来源、视觉形式和仍需确认的制作决策。

plan 必须可被用户手动修改，并且逐页写清楚：页面内容、公式/符号写法、图片或论文图选择、图片制作格式、表格/数据基准、是否需要补充材料，以及该页必须触发的 reference/workflow。若这些内容没有写清楚，不得进入 PPT 制作。

### 参考图复现 PPT 图

只要是根据图片、截图、论文图、架构图、流程图、关系图或视觉草稿复现 PPT 图，必须先输出参考图分析或图形规格，并获得用户确认。

如果同时提供文档和参考图，文档负责内容事实和关系，参考图只负责视觉结构，除非用户明确要求复制图中内容。

稍复杂及以上的参考图不得默认直接用 PowerPoint 原生对象绘制，必须先让用户确认路线：draw.io 源图 + SVG/PNG、PPT 原生可编辑简化版、或混合版。默认推荐 draw.io 处理模块图、架构图、关系图和分组箭头图。

### 已有 PPT 修改

修改已有 PPT 前，必须确认输入文件、任务子目录、输出副本、影响页范围、修改意图、是否保留/隐藏/替换原内容，以及 QA 级别。默认不直接覆盖原文件。

### 数据图表与表格

凡是生成或修改数据表格、柱状图、折线图、指标卡、坐标轴、图例、百分比、单位或定量对比页，必须先确认数据基准。缺失数值、单位、分母、轴标签或图例时，不得自行推断。

### 外部来源

Notion 页面、网页、URL 或其他外部链接默认作为只读来源。规划稿需要记录页面标题、URL、访问日期或相关章节，不写回来源页面。

### 任务子目录

任何会产生 PPT、脚本、预览图、draw.io 源文件、SVG、PNG、PDF、QA 记录或中间素材的任务，都必须先确认一个独立任务子目录，并把产物收束进去。

推荐结构：

```text
<YYYY-MM-DD_short-topic>/
  plan/       # slide plan、reference spec、QA notes
  source/     # 用户批准复制的源材料、模板、参考图
  scripts/    # PowerShell 或辅助脚本
  drawio/     # .drawio 源文件
  exports/    # SVG、PNG、PDF 等导出文件
  previews/   # 页面预览、QA 截图
  output/     # 最终 .pptx / .pdf
```

目录规则是为了防止文件散落，不要求每次递归读取整个目录；只读取当前步骤需要的文件。

## 核心流程

### 基于材料生成 PPT

```text
确认任务子目录
-> 分析材料
-> 生成或审阅 Markdown plan
-> 用户确认 plan
-> 确认模板、保存策略、生成模式、QA 级别
-> PowerPoint COM 生成 PPTX
-> 预览/验证
-> 交付 output/ 中的 PPTX
```

### 根据图片复现 PPT 图

```text
确认任务子目录
-> 分析参考图
-> 若有文档，先分析文档内容
-> 输出 reference spec / source-to-visual mapping
-> 用户确认
-> 选择 PowerPoint 原生、draw.io/SVG/PNG 或混合方式
-> 生成图并插入 PPT
-> QA 对比和修复
```

## 图形生成规则

- 很简单的流程图或普通图形，优先使用 PowerPoint 原生可编辑形状。
- 稍复杂的模块图、关系图、架构图、分组箭头图，优先使用已安装的 draw.io skill/capability 生成 `.drawio` 源图。
- draw.io 路线必须由本机 draw.io 软件导出 SVG 和 PNG。
- 先检查 PNG 视觉效果，再检查 SVG 文字和 PowerPoint 兼容性。
- SVG 无乱码、无缺字、无 `foreignObject`、无嵌入式 `data:image` 文字 fallback、无 `Text is not SVG - cannot display` 警告时，才优先插入 SVG。
- SVG 不合规或导入 PowerPoint 后损坏时，可用 PNG fallback，但必须说明该图在 PPT 中不方便编辑。

## 生成执行模式

- `快速批量生成`：沿用现有 COM 生成路径，适合尽快得到完整稿。
- `PowerPoint 可见逐页生成`：保持 PowerPoint 可见，按页和主要内容阶段生成，方便实时观察。

两种模式共用同一份已确认 plan/spec、模板继承规则、任务目录、保存策略和 QA 要求。

## 默认设计规则

- 中文任务默认使用简体中文。
- 用户提供模板时，优先继承模板字体、颜色、布局和视觉体系。
- 无模板且未指定字体时，中文默认微软雅黑，英文和数字默认 Times New Roman。
- 生成图片只可用于封面、背景、分隔页或概念性插图，不能替代论文证据图、实验结果、产品截图、统计图或事实性图表。

## QA 规则

| 输出类型 | 验证方式 |
| --- | --- |
| 快速草稿 | 确认文件可打开、页数和主要内容正确 |
| 正式 PPT | 导出或生成页面预览，完成视觉检查，修复问题后复查受影响页面 |
| 参考图复现 | 对照已确认 reference spec 检查文字、层级、连接方向、颜色、比例和布局 |
| draw.io 图 | 同时检查 PNG 视觉、SVG 文本和 SVG 的 PowerPoint 兼容性 |
| 数据图表/表格 | 对照已确认数据基准检查数值、单位、坐标轴、图例、标签和取整策略 |
| 公式和编码 | 检查公式是否按基准渲染；乱码、异常项目符号、替换字符、白字浅底不可读均视为 QA 失败 |

正式视觉 QA 最多两轮。第二轮仍无法达到确认规格时，应中断继续盲修，说明剩余差距并建议切换生成方式、提供高清参考图或降低可编辑性要求。

失败时保留任务目录中的脚本、日志、中间文件和已生成产物，说明失败阶段和建议恢复路径；未经确认不切换生成后端、fallback 或覆盖原文件。

## 与 nature-paper2ppt 配合

只有当任务明显属于论文、预印本、文献汇报、组会分享、学术答辩或其他证据驱动的学术演示时，才提示可选使用 `nature-paper2ppt`。

- `nature-paper2ppt`：辅助论文理解、证据/图表筛选和学术叙事规划。
- `pptx-com`：负责经过确认后的 PowerPoint COM 制作、模板继承、可编辑对象处理、任务目录组织和 QA。

普通商务、项目、课程、培训或一般文档转 PPT 任务，不主动引入 `nature-paper2ppt`。

## 示例请求

```text
用 pptx-com 总结并审阅这个已有 PPT，只读不要修改。
```

```text
用 pptx-com 基于这个 PDF 和模板制作一份 8 页汇报 PPT，先生成逐页规划供我确认。
```

```text
用 pptx-com 根据这张参考图复现一页 PPT，先输出图形规格和保存目录让我确认。
```

```text
用 pptx-com 按我提供的 plan 和模板生成 PPT；先检查 plan 是否足够完整，再向我确认写入设置。
```

## 环境要求

- Windows
- 已安装桌面版 Microsoft PowerPoint
- Codex 能执行本地 PowerShell 命令
- 使用 draw.io 路线时，需要已安装 draw.io skill/capability 和本机 draw.io 软件
