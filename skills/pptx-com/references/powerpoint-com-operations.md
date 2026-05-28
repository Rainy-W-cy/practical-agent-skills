# PowerPoint COM 操作指南

本 skill 的执行环境为 Windows 桌面版 PowerPoint。使用 PowerShell 调用 `PowerPoint.Application`，让 PowerPoint 处理原生可编辑对象。

## 基本对象层级

```text
PowerPoint.Application
  Presentations
    Presentation
      Slides
        Slide
          Shapes
```

常见对象：

- `Presentation`: 演示文稿与保存/导出。
- `Slide`: 页面管理、复制和排列。
- `Shapes`: 文本框、图片、形状、表格与图表。
- `TextFrame.TextRange`: 可编辑文字与文字格式。

## 安全准则

- 只读分析可以打开用户明确指定的文件，并在关闭时不保存。
- 所有写入任务先确认输出路径与保存策略。
- 修改现有内容时先复制到目标路径，再打开目标副本编辑。
- 使用 `try/finally` 关闭文稿与释放 COM 对象。
- 未经确认，不调用保存覆盖原文件的操作。

## 示例模式

启动 PowerPoint 并保持可见：

```powershell
$ppt = New-Object -ComObject PowerPoint.Application
$ppt.Visible = -1
```

创建页面与文本：

```powershell
$pres = $ppt.Presentations.Add()
$slide = $pres.Slides.Add(1, 1)
$slide.Shapes.Title.TextFrame.TextRange.Text = '标题'
```

插入图片：

```powershell
$slide.Shapes.AddPicture($imagePath, 0, -1, $left, $top, $width, $height)
```

保存为新文件：

```powershell
$pres.SaveAs($outputPath)
```

## 复杂公式与 Office Math

- 对分式、上下标、求和、条件概率、矩阵、帽符号或多步推导，优先在 PowerPoint 中创建可编辑的 Office Math 公式对象。
- Microsoft 365 的 PowerPoint 支持将 LaTeX 数学表达式转换为 Office Math（OMML）；在可可靠自动化时，可将经确认的 LaTeX 基准导入公式区域并转换为专业格式。
- PowerPoint COM 路径必须先通过任务内的最小测试确认公式对象可建立并正确保存。不能可靠建立时，不得将复杂公式静默改成普通文本框；应向用户说明并征求是否采用矢量公式回退。
- 写入脚本中保留一份与页面公式对应的基准表达式清单，便于导出预览后逐项核对。
- 在当前验证通过的 Windows PowerPoint COM 路径中，可在选定文本承载区后调用 `InsertBuildingBlocksEquationsGallery`，写入经确认的 `UnicodeMath` 线性表达式，再调用 `EquationProfessional` 转换为专业格式；生成后同时检查 `TextFrame2.TextRange.MathZones.Count` 与页面预览。
- `EquationProfessional` 会按分式、求和和大括号结构自动扩张公式的实际显示高度。排版时应为公式保留充足垂直空间，并在预览中确认其未超出装饰底框或侵入相邻内容；复杂大公式优先使用开放留白区域而不是紧贴公式的固定高度卡片。

## 生成执行模式

制作或大幅修改幻灯片前，先确认用户选择以下哪一种执行模式。

### 快速批量生成

- 保持现有 COM 生成方式，高效完成已确认的页面内容和版式写入。
- PowerPoint 是否可见仍按用户确认执行。
- 完成写入后再执行适用的打开验证与预览 QA。

### PowerPoint 可见逐页生成

- 将 `$ppt.Visible` 设置为 `-1`，保持 PowerPoint 窗口可见。
- 在开始制作每一页时切换到当前页，例如通过 `$ppt.ActiveWindow.View.GotoSlide($slideIndex)`。
- 按可观察的阶段添加主要元素，例如先页面结构与标题，再图形/图片，最后正文与标注。
- 在完成每页或关键阶段后调用 `$pres.Save()`；可加入短暂等待，以便用户观察当前状态，但不要为了表演而拆成过细的操作。
- 用户在制作途中提出暂停或调整时，保存当前安全状态后停止继续生成，等待确认。
- 完成全部页面后，仍按正式稿或快速草稿规则执行验证与视觉 QA。

逐页模式只改变制作过程的可见性和节奏，不改变经确认的内容、模板、字体、保存策略、可编辑对象要求或 QA 标准。

## 任务脚本要求

- 使用绝对路径。
- 在写入前验证输入存在、目标目录存在且输出策略已获确认。
- 页面制作尽量使用原生对象，以便用户继续在 PowerPoint 中编辑。
- 复杂设计可先在 workspace 生成图片或 SVG，再经确认插入演示文稿。
- 对正式稿使用导出预览脚本完成 QA。
