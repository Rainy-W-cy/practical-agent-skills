# Failure Handling and Recovery

Use this reference when PowerPoint COM, draw.io export, SVG import, preview export, PDF export, file access, or any task-specific script fails.

## Failure Rules

- Stop and identify the failed stage: input inspection, planning, script generation, COM open, COM write, save, preview export, draw.io export, SVG check, PPT import, PDF export, or QA.
- Preserve task-specific scripts, logs, intermediate files, previews, and outputs inside the confirmed task directory unless the user asks to delete them.
- Do not silently switch to another backend or generation mode. Ask before changing from COM-native drawing to draw.io, from SVG to PNG fallback, from visible generation to batch generation, or from editable objects to raster images.
- Do not repeatedly blind-retry. After a repeated failure, summarize the error, likely cause, files produced so far, and recommended recovery path.
- Never overwrite the original deck during recovery unless the user explicitly approved that exact overwrite.

## Common Recovery Paths

| Failure | Recommended response |
| --- | --- |
| PowerPoint COM unavailable | Run or suggest COM availability test; ask whether to troubleshoot Office/PowerPoint installation |
| Deck locked or already open | Ask user to close it or approve working on a copy |
| Save/export path invalid | Confirm a new path inside the task directory |
| Preview export fails | Keep PPTX output, report missing QA artifact, and ask whether to retry or inspect manually |
| draw.io unavailable | Ask whether to install/enable draw.io or use native COM/SVG/PNG fallback |
| SVG fails PPT compatibility | Use draw.io-exported PNG only after explaining editability loss |
| Formula creation fails | Ask whether to use vector formula fallback; do not silently convert to plain text |

## Final Report

If a failure remains unresolved, report:

- What was attempted.
- Which file or stage failed.
- What artifacts were saved.
- What is safe to reuse.
- What user decision is needed next.
