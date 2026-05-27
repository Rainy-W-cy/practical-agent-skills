# pptx-com

`pptx-com` 是一个面向 Windows 桌面版 Microsoft PowerPoint 的 Codex skill。它通过 Windows COM 调用真实 PowerPoint，创建或修改可继续编辑的 `.pptx` 文件，而不是依赖额外的 PowerPoint MCP 服务。

## 能做什么

- 读取、总结和审阅已有 PPT。
- 根据提纲、文档、PDF 或图片资料生成 PPT。
- 基于现有模板制作或修改演示文稿。
- 使用 PowerPoint 原生文本、形状、流程图、连接线、表格和图片。
- 按需显示 PowerPoint 窗口，便于实时查看制作过程。
- 按需导出 PDF 或页面预览。

## 核心流程

### 修改已有 PPT

```text
分析原稿
-> 确认保存策略与修改范围
-> 在副本中通过 PowerPoint COM 制作或修改
-> 验证并交付 PPTX
```

### 基于材料生成新的 PPT

```text
分析文档内容
-> 无现成 plan 时输出详细 PPT 规划 Markdown
-> 用户已提供 plan 时审阅并确认其足以制作
-> 用户确认页数、风格和逐页内容
-> 有模板时确认模板继承与页面映射
-> 确认保存与显示设置
-> 通过 PowerPoint COM 生成 PPTX
-> 验证并交付
```

只要是依据文档、PDF、报告或归纳材料生成新的 PPT，无论是否提供模板，都必须先有经过确认的详细 plan。用户已经提供足够完整的 plan 时，不会重复生成新的 plan；即使是快速草稿，也不能跳过确认。

## 默认设计规则

- 中文任务默认使用简体中文。
- 无模板且未指定字体时，中文使用微软雅黑，英文和数字使用 Times New Roman。
- 用户提供模板时，优先继承模板中的字体、颜色、布局和视觉体系。
- 简单流程图优先使用 PowerPoint 原生可编辑形状；复杂架构图可使用 draw.io 或 SVG 后插入。
- 生成图片仅可用于封面、背景或概念性装饰，不可替代真实数据、论文证据图或产品截图。

## 安全与确认

- 用户明确指定的 PPT 可以直接进行只读分析。
- 创建、修改、复制、导出或生成预览前，会先确认输入、输出路径与保存策略。
- 默认保存为新文件，不覆盖原模板或原稿。
- 是否显示 PowerPoint 制作过程、是否导出 PDF、是否使用生成图片，均由用户确认。

## QA 规则

| 输出类型 | 验证方式 |
| --- | --- |
| 快速草稿 | 确认文件可打开、页数与主要内容正确 |
| 正式 PPT | 生成页面预览，完成一次整体视觉检查，修复问题后复核受影响页面 |

## 与 nature-paper2ppt 配合

当任务明显属于论文、预印本、文献汇报、组会分享或学术答辩时，可联合使用 `nature-paper2ppt`：

- `nature-paper2ppt`：负责论文理解、关键证据筛选和学术叙事规划。
- `pptx-com`：负责通过 PowerPoint COM 制作原生可编辑 PPTX、实时修改和质量检查。

普通商务、项目或课程演示任务不会主动引入 `nature-paper2ppt`。

## 示例请求

```text
用 pptx-com 总结并审阅这个已有 PPT，只读不要修改。
```

```text
用 pptx-com 基于这个 PDF 和模板制作一份 8 页汇报 PPT，先生成逐页规划供我确认。
```

```text
用 pptx-com 基于这个模板的副本修改内容，制作时显示 PowerPoint，不覆盖原文件。
```

```text
用 pptx-com 按我提供的 plan 和模板生成 PPT；先检查 plan 是否足够完整，再向我确认写入设置。
```

## 环境要求

- Windows
- 已安装桌面版 Microsoft PowerPoint
- Codex 能执行本地 PowerShell 命令
