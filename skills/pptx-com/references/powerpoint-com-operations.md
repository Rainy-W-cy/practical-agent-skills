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

## 任务脚本要求

- 使用绝对路径。
- 在写入前验证输入存在、目标目录存在且输出策略已获确认。
- 页面制作尽量使用原生对象，以便用户继续在 PowerPoint 中编辑。
- 复杂设计可先在 workspace 生成图片或 SVG，再经确认插入演示文稿。
- 对正式稿使用导出预览脚本完成 QA。

