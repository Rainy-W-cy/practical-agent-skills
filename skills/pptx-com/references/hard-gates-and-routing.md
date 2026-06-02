# Hard Gates and Routing

This file is the first routing reference for `pptx-com`. Use it to decide which confirmations and detailed references are required before any PPT work continues.

## Non-Negotiable Gates

Do not create, edit, export, preview-render, copy templates, run COM write scripts, or overwrite files until the relevant gates below are satisfied.

1. Source-based new deck gate
   - Applies when the user asks to create a new PPT from documents, PDFs, papers, reports, Markdown, notes, summarized material, or synthesized source content.
   - A detailed Markdown slide plan must be approved before creating any `.pptx`, whether or not a template is supplied.
   - If the user already supplied a plan, review it for completeness and request approval to use it instead of generating a duplicate plan.
   - For academic paper presentations, the plan must identify important figures, tables, method diagrams, result plots, ablation blocks, architecture blocks, or local regions worth showing, and assign each one a handling mode: insert/cite the original, crop or screenshot the key block, recreate/redraw as a PPT diagram, create an explanatory simplified version, or skip with a reason.
   - Then read `document-to-deck-planning.md`.

2. Reference-image recreation gate
   - Applies when the user asks to imitate, recreate, redraw, or make a PPT version of a reference image, screenshot, paper figure, architecture diagram, visual draft, or image-based layout.
   - A reference-image interpretation/specification must be approved before creating or editing slides.
   - If documents and reference images are both supplied, documents define content and relationships; images define visual grammar unless the user says otherwise.
   - If the figure is more than a very simple diagram, route selection is mandatory before drawing: draw.io source plus SVG/PNG export, PowerPoint-native editable simplified version, or hybrid version. Recommend draw.io for slightly complex module, architecture, relationship, or grouped-arrow diagrams when available.
   - Then read `reference-image-diagram-recreation.md`.

3. Existing deck edit gate
   - Applies when the user asks to modify, polish, restructure, restyle, translate, shorten, expand, review-and-fix, or export from an existing deck.
   - Confirm the edit scope, affected slides/sections, output copy, preservation/removal choices, and QA level before writing.
   - Then read `existing-deck-edit-workflow.md`.

4. Data/chart/table gate
   - Applies when slides contain factual numbers, units, tables, charts, axes, legends, percentages, dates, sample sizes, metric cards, or quantitative comparisons.
   - Confirm a data baseline before production and check rendered output against that baseline during QA.
   - Then read `data-chart-table-workflow.md`.

5. External source gate
   - Applies when source material is a Notion page, webpage, URL, or other external link.
   - Treat the source as read-only unless the user separately requests a write operation under that tool's own rules.
   - Record source identity such as page title, URL, access date, and relevant section in the plan.

6. Failure handling gate
   - Applies when PowerPoint COM, draw.io, SVG import, preview export, PDF export, file access, or any task-specific script fails.
   - Stop, preserve artifacts in the task directory, identify the failed stage, and ask before switching backend, fallback, or generation mode.
   - Then read `failure-handling.md`.

7. Task subdirectory gate
   - Applies to any task that creates PPT files, scripts, previews, draw.io files, SVG/PNG exports, PDFs, QA notes, or other artifacts.
   - Confirm a dedicated task subdirectory before writing. Keep all generated artifacts inside it unless the user explicitly chooses another location.
   - Recommended structure:

```text
<YYYY-MM-DD_short-topic>/
  plan/
  source/
  scripts/
  drawio/
  exports/
  previews/
  output/
```

   - Confirm the parent folder, directory name, whether source/template/reference files should be copied into `source/` or only referenced by path, and whether intermediate scripts/previews should be retained.
   - Do not recursively read the whole task directory. Load only files needed for the current step.

8. Write/export confirmation gate
   - Before any write operation, confirm input materials, output path, copy/overwrite policy, PowerPoint visibility, generation mode, PDF export, image usage, and formal-vs-quick QA level.
   - Default to creating a new output file and preserving originals.

9. QA gate
   - Quick drafts require basic open/readability validation.
   - Formal PPT outputs require preview inspection and repair of visible issues.
   - Formal diagram recreation requires comparison against the approved image/specification.
   - Mojibake, replacement glyphs, unexpected symbols, wrong bullets, broken formula text, missing labels, or unreadable white-on-light text in previews are QA failures.
   - Draw.io routes require PNG visual review and SVG text/PowerPoint-compatibility checks before SVG insertion. If SVG fails, use draw.io-exported PNG only after warning that the PPT object will not be conveniently editable.
   - Limit formal visual QA to two preview/check cycles unless the user explicitly asks to continue.

## Routing Table

| User task | Required gate | Read next |
| --- | --- | --- |
| Create PPT from PDF, paper, document, report, notes, or summarized material | Source-based new deck gate, task subdirectory gate | `document-to-deck-planning.md` |
| Use a user-supplied plan to create PPT | Review supplied plan, task subdirectory gate | `document-to-deck-planning.md` |
| Use a template or existing deck | Template copy/save confirmation, task subdirectory gate | `template-workflow.md` |
| Edit, polish, translate, restructure, restyle, shorten, or expand an existing deck | Existing deck edit gate, task subdirectory gate | `existing-deck-edit-workflow.md` |
| Recreate, imitate, redraw, or make a PPT version of an image, screenshot, paper figure, or visual draft | Reference-image recreation gate, task subdirectory gate | `reference-image-diagram-recreation.md` |
| Create or modify data charts, tables, metric cards, quantitative comparison slides, or date/axis/legend visuals | Data/chart/table gate | `data-chart-table-workflow.md` |
| Create or verify complex formulas | Formula baseline confirmation | `formula-workflow.md` |
| Design typography without a complete template or fix layout/font issues | Typography/layout guidance | `typography-and-layout-zh.md` |
| Write or diagnose PowerPoint COM automation | COM operation guidance | `powerpoint-com-operations.md` |
| Recover from COM, draw.io, SVG, preview, export, file, or script failure | Failure handling gate | `failure-handling.md` |
| Produce final deck, previews, PDF, or repaired slides | QA gate | `visual-qa.md` |

## Academic Coordination

Only mention `nature-paper2ppt` when the input clearly concerns a paper, preprint, literature review, journal club, paper-sharing presentation, thesis/academic defense, or another evidence-driven academic presentation.

- If installed, offer it as optional help for paper understanding, evidence/figure selection, and academic narrative planning.
- If unavailable, explain its optional role and ask whether the user wants installation help.
- Do not mention it for ordinary business, project, training, course, or general document-to-slide tasks.
- `pptx-com` remains responsible for approved PowerPoint COM production, native-object refinement, task-directory organization, and validation.

## Minimal Confirmation Checklist

Before writing, ask for confirmation of:

- Task directory and artifact organization.
- Input materials and source authority.
- Plan or reference specification approval.
- Route choice for non-simple reference image or paper figure recreation: draw.io, PPT-native simplified, or hybrid.
- Existing deck edit scope and modification plan, if relevant.
- Data baseline and source attribution, if relevant.
- Template/copy/overwrite strategy.
- Output `.pptx` path and optional PDF path.
- Generation mode: `快速批量生成` or `PowerPoint 可见逐页生成`.
- PowerPoint visibility.
- Quick draft or formal PPT QA.
- Generated-image permission, if relevant.
- Draw.io availability and SVG/PNG fallback policy, if relevant.
