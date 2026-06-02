---
name: pptx-com
description: Use this skill whenever the user asks to read, summarize, review, create, revise, polish, format, preview, or export PowerPoint/PPT/PPTX/slides/deck presentations on Windows, including Chinese requests such as 制作PPT, 生成演示文稿, 根据PDF/论文/文档/报告/笔记/网页/Notion做PPT, 上传材料生成PPT, 修改已有PPT, 用模板做PPT, 制作数据图表/表格/指标页, 复现/临摹/重画图片或论文图到PPT, and image-to-PPT diagram recreation. Use PowerPoint desktop automation through Windows COM for file-producing or editing work, with explicit confirmation before writes. For any new PPT based on documents, PDFs, reports, papers, webpages, Notion pages, or synthesized source materials, require a detailed approved Markdown slide plan before producing PPTX unless the user already supplied a sufficient plan. For non-trivial existing-deck edits, require an approved edit scope and output-copy strategy. For any PPT diagram recreation from a reference image, screenshot, paper figure, or visual draft, require an approved reference-image interpretation/specification before producing the PPT. For data charts/tables, require an approved data baseline. For clear academic paper or literature-presentation tasks, offer optional coordination with nature-paper2ppt.
---

# PPTX COM

Use desktop Microsoft PowerPoint through Windows COM to work with native, editable `.pptx` presentations. This skill is intended for a Windows environment with PowerPoint installed. Do not require a PowerPoint MCP server when local shell execution can call COM directly.

## Hard Gates and Routing

Read `references/hard-gates-and-routing.md` at the start of every PPT creation, edit, export, source-based deck, or reference-image recreation task.

- For any new deck based on documents, PDFs, papers, reports, notes, or synthesized source material, require a detailed user-approved Markdown slide plan before creating any `.pptx`, regardless of whether a template is supplied.
- If the user already supplies a plan, review it for completeness and request approval to use it; do not duplicate an adequate plan.
- For any diagram, layout, screenshot, paper figure, or visual draft recreated into PPT, require a user-approved reference-image interpretation/specification before creating or editing slides.
- If the reference image or paper figure is more than a very simple diagram, do not directly draw it with PowerPoint COM by default. First ask the user to choose one route: draw.io source plus SVG/PNG export, PowerPoint-native editable simplified version, or hybrid version. If the user does not choose, recommend draw.io for slightly complex module/architecture/relationship diagrams.
- For non-trivial edits to an existing deck, require an approved edit scope and modification plan before writing to a copy.
- For data-driven charts, tables, metric slides, or quantitative visuals, require an approved data baseline before production.
- Before any task that creates PPT files, scripts, previews, draw.io files, SVG/PNG exports, PDFs, or other artifacts, require confirmation of a dedicated task subdirectory and keep all generated files inside it unless the user explicitly chooses another location.
- Do not perform COM writes, exports, preview rendering, template copying, overwrites, or broad edits until the relevant plan/specification, task directory, output path, and save strategy have been confirmed.

## Operating Boundary

- Before reading, summarizing, or reviewing an existing presentation, identify the input file and intended read-only action, and obtain explicit confirmation; keep the file unmodified.
- Before creating a presentation, editing a deck, exporting a PDF, exporting slide previews, copying a template, or writing any output, show the intended input, output, save strategy, and actions; obtain explicit confirmation.
- If the user asks to create a new deck from uploaded or specified documents, PDFs, reports, or synthesized source materials, require an approved detailed Markdown slide plan before creating any `.pptx`, whether or not a template is provided.
- If the user already provides a plan, review it for sufficient slide-level detail and required production decisions, show any gaps or adjustments, and request approval to use it; do not generate a redundant replacement plan when the supplied plan is adequate.
- Ask each time whether the PowerPoint window should remain visible during write operations.
- Before producing or substantially revising slides, ask the user to choose a generation execution mode: `快速批量生成` or `PowerPoint 可见逐页生成`. Preserve the existing fast batch-generation path; use visible progressive generation only when the user selects it.
- Default to saving a new file. Never overwrite an original deck or template unless the user explicitly approves the exact output path and overwrite action.
- Do not delete slides, discard originals, or perform broad replacements without explicit approval.

## Toolchain

Primary execution path:

```text
PowerShell or task-specific script
-> Windows COM
-> PowerPoint.Application
-> native PowerPoint objects and files
```

Prefer native PowerPoint objects for text, shapes, connectors, tables, charts, notes, images, themes, and layouts. Do not use `PptxGenJS`, raw PPTX XML editing, or a PowerPoint MCP server as the default generation/editing backend.

Read `references/powerpoint-com-operations.md` before writing task-specific COM automation or when diagnosing COM behavior.
Read `references/failure-handling.md` when COM, draw.io, SVG import, preview export, PDF export, file access, or any task-specific script fails.

### Generation Execution Modes

- `快速批量生成`: Use the existing COM production flow to create or update the approved deck efficiently, then perform the required validation and QA.
- `PowerPoint 可见逐页生成`: Keep PowerPoint visible and make progress observable in the open presentation. Build the deck slide by slide, navigate to the slide currently being constructed, add its principal elements in meaningful stages, and save at safe checkpoints so the user can watch progress and intervene if needed.
- Both modes use the same approved plan, content constraints, template rules, native editable PowerPoint objects, save policy, and final QA requirements.
- Progressive generation is an execution/display option only. Do not reduce validation, introduce unsupported claims, or alter agreed visual/content decisions because the user selected it.

## Task Subdirectory

For any task that creates or modifies PPT files or related artifacts, confirm a dedicated task subdirectory before writing. Recommended structure:

```text
<YYYY-MM-DD_short-topic>/
  plan/       # slide plans, reference specs, QA notes
  source/     # copied or referenced source materials when approved
  scripts/    # task-specific PowerShell or helper scripts
  drawio/     # .drawio source files
  exports/    # SVG, PNG, PDF, and other exported assets
  previews/   # slide previews and QA screenshots
  output/     # final .pptx and optional .pdf
```

- Ask the user to confirm the parent folder, directory name, and whether source/template/reference files should be copied into `source/` or only referenced by path.
- Store generated plans, reference specifications, scripts, draw.io files, exported SVG/PNG/PDF, previews, QA notes, and final PPTX inside the confirmed task directory.
- Do not scatter `.ps1`, `.drawio`, `.svg`, `.png`, preview, plan, or QA files in the workspace root unless the user explicitly requests it.
- Keep the directory rule lightweight: read only files needed for the current step, and do not recursively load the whole task directory into context.

## Supported Work

- Read slide titles, body text, notes, shape inventory, slide count, and basic layout information.
- Summarize an existing deck or review it for structure, density, visual clarity, consistency, and likely presentation issues.
- Create a presentation from a user outline, report, document, images, or content synthesized from supplied materials.
- Copy and populate a template or revise an existing presentation.
- Insert user-provided images and, when allowed, images generated by the currently available image generation tool.
- Draw simple process diagrams, timelines, comparisons, and callout layouts as editable PowerPoint objects.
- Create or modify data tables, charts, metric slides, and quantitative comparison visuals only after confirming the data baseline.
- Create slides containing mathematical definitions, derivations, loss functions, metrics, quantization expressions, and other complex formulas with formula-specific verification.
- Export PDF only when requested and confirmed.

## Input and Content Planning

For creation tasks, establish:

1. Purpose, audience, speaking context, target duration, and expected slide count.
2. Input sources and whether claims, figures, or numbers must be reproduced exactly.
3. Whether a template or reference presentation exists.
4. Language, terminology constraints, font overrides, and output deliverables.
5. Whether the requested result is a quick draft or a formal deliverable.

When building from summarized content, convert material into a slide-level narrative before opening PowerPoint for production. Each slide should have one primary communication job. Do not invent missing claims, figures, citations, or data.

If the source is a Notion page, webpage, URL, or other external link, treat it as read-only source material: fetch or inspect only what is needed, record the page title/URL/access date or equivalent source identity in the plan, and do not write back to the source unless the user explicitly requests a separate write operation under that tool's rules.

### Source-Based Creation Planning Gate

If the user supplies or identifies documents, PDFs, reports, or synthesized content and requests a new presentation, regardless of whether a `.pptx` or `.potx` template is provided:

1. Analyze the document before creating any presentation file.
2. If no plan is supplied, produce a detailed Markdown planning document and request approval.
3. If the user supplies a plan, review it rather than duplicating it: verify page count, per-slide content, source/evidence mapping, template usage if any, design requirements, and unresolved production decisions. Request approval after documenting necessary corrections or confirming it is adequate.
4. Name a newly generated plan `<topic>_ppt_plan.md` in the specified output directory, or in the current workspace if no output directory has yet been specified.
5. Include in a newly generated plan the source analysis, proposed page count, speaking duration when inferable or supplied, template mapping when a template exists, visual direction, color/font proposal, image-generation suggestion, and a detailed per-slide execution plan.
6. If reference images are also supplied for recreating PPT diagrams or layouts, include a content-to-visual mapping: source document facts first, reference image visual structure second, and the proposed mapping between document content and image-inspired PPT objects.
7. Make every accepted plan auditable and editable by the user: for each slide identify slide objective, core takeaway, intended on-slide content, formulas and their intended rendering, image/figure choice and production route, table/chart/data baseline, required references/workflows to read, source location, and unresolved questions or risks.
8. Even if the user requests a quick PPT draft, require an approved abbreviated but still reviewable plan before generating `.pptx`.
9. After plan approval, confirm the output/save/display/image/PDF options before performing COM write operations.

Read `references/document-to-deck-planning.md` whenever this workflow applies.

### Academic Presentation Coordination

- Only mention `nature-paper2ppt` when the input clearly concerns a paper, preprint, literature review, journal club, paper-sharing presentation, thesis/academic defense material, or comparable academic evidence-driven presentation.
- For ordinary business, project, course, training, or general document-to-slide tasks, do not proactively mention `nature-paper2ppt`.
- For a clear academic presentation task, check whether `nature-paper2ppt` is available. If installed, offer optional joint use and wait for the user's decision. If it is unavailable, explain its optional role and ask whether the user wants help installing it.
- When jointly used, `nature-paper2ppt` supplies academic argument planning, evidence/figure selection, and slide narrative; this skill remains responsible for approved PowerPoint COM production, native-object refinement, and validation.
- Do not automatically enable the joint workflow or install another skill without user confirmation.
- For academic paper presentations, the slide plan must include a figure/block handling decision for important paper visuals: cite/insert the original figure, crop or screenshot a key block, recreate/redraw it as a PPT diagram, create an explanatory simplified version, or skip it with a reason. Do not assume all important paper figures should be recreated; choose the handling mode based on evidence integrity, editability, visual complexity, and presentation value, then request user approval.
- When inserting or cropping original paper figures, screenshots, or evidence blocks, keep source attribution visible or recorded: paper title/author/year when available, figure/table number, page or section, and whether the visual is original, cropped, recreated, or simplified. Do not present copied or cropped paper visuals as newly generated results.

## Existing Deck Edits

Read `references/existing-deck-edit-workflow.md` when the task edits, restructures, polishes, translates, shortens, expands, restyles, reviews-and-fixes, or exports from an existing presentation.

- Default to editing a confirmed output copy.
- For non-trivial edits, present affected slides/sections, intended changes, preserved content, removal/hide/replace decisions, and QA level before writing.
- Do not silently delete, hide, summarize, or move existing slide content without approval.

## Data, Charts, and Tables

Read `references/data-chart-table-workflow.md` whenever slides contain factual numbers, units, data tables, metric cards, charts, axes, legends, percentages, dates, sample sizes, or quantitative comparisons.

- Establish a data baseline before production.
- Do not infer missing values, units, denominators, axes, legends, or category labels without confirmation.
- For formal outputs, compare rendered charts/tables against the approved baseline during QA.

## Template Workflow

If the user provides a template or existing deck, strictly prefer its established system:

- Master/layout choices, theme colors, font family, header/footer treatment, spacing, and recurring visual patterns take precedence over default styling.
- First inspect the deck structure and reusable layouts; then map the requested content to suitable pages or layouts.
- Work on a confirmed output copy unless the user explicitly approves direct modification.
- Preserve editable native objects wherever practical.

Read `references/template-workflow.md` when a template, branded deck, existing presentation, or visual reference is provided.

## Language and Typography

- Detect the language from the task. Chinese tasks default to Simplified Chinese.
- Preserve English technical terminology, abbreviations, model names, dataset names, formulas, and code where meaningful.
- Typography precedence: user-specified fonts > template font system > defaults below.

Default fonts when no template or override applies:

| Content | Font |
| --- | --- |
| Chinese title | Microsoft YaHei Bold |
| Chinese body, captions, sources | Microsoft YaHei |
| English title/body and numerals | Times New Roman |
| Code | Consolas |

Default minimum sizing guidance:

| Element | Size |
| --- | ---: |
| Cover title | 30-44 pt |
| Slide title | 26-36 pt |
| Section heading | 20-24 pt |
| Body | 16 pt minimum |
| Caption/source | 10-11 pt minimum |
| Key metric | 40-64 pt |

Read `references/typography-and-layout-zh.md` before designing a deck without a complete template, or when fixing typography/layout problems.

## Complex Formulas and Mathematical Accuracy

- Before writing complex formulas, establish a formula baseline from the user-provided expression, source material, or an explicitly approved correction. Record unresolved operator, index, delimiter, and symbol ambiguities before production.
- Prefer editable native Office Math equations in PowerPoint for fractions, sums, integrals, matrices, subscripts/superscripts, hats, absolute values, conditional probability, aligned expressions, and multi-step derivations.
- Do not typeset complex formulas as ordinary text boxes merely because plain text is easier to automate. If native equation creation cannot be completed reliably, stop and request approval for a clearly labeled vector-formula fallback.
- For formal slides, formula-like text such as `sqrt(d_k)`, `QK^T`, matrix expressions, complexity terms, or mathematical operators must either be rendered as native Office Math or explicitly approved as simplified explanatory text. Do not leave formula approximations in ordinary text without review.
- Treat formula correctness as content integrity: do not silently rewrite mathematical definitions, change normalization factors, replace operators such as `round`, `floor`, or `clip`, or infer missing bounds without confirmation.
- For formal presentations containing formulas, perform formula-specific QA after preview rendering: compare each rendered equation against the approved baseline and verify fractions, exponents, indices, summation limits, hats, absolute values, conditional bars, brackets, operators, minus signs, and surrounding interpretation text.
- If a formula uses data values, constants, or reported results, verify those values against the approved source in addition to checking rendering.

Read `references/formula-workflow.md` whenever a slide contains complex formulas or formula-derived explanation.

## Visual and Layout Principles

- Give every slide a clear focal point; avoid dense text dumps.
- Avoid a monotonous sequence of identical title-plus-bullets slides.
- Left-align body text and lists by default; align titles according to the template or intended composition.
- Maintain consistent margins, spacing, grid alignment, and visual hierarchy.
- Keep text and icon contrast high enough for projection and ordinary displays.
- Use images, diagrams, data displays, or purposeful shapes only when they strengthen the message.
- Avoid generic decoration such as repeated ornamental title underlines unless the supplied template requires it.

## Images, Figures, and Diagrams

Read `references/reference-image-diagram-recreation.md` when the task involves imitating, recreating, redrawing, or making a PPT version of a reference image, paper figure, architecture diagram, relation map, screenshot, or visual draft.

User image folders:

- Read image assets only from directories or files the user identifies for the task.
- Do not silently substitute or alter evidence figures.

Image-reference recreation:

- When the user asks to imitate, recreate, redraw, or make a PPT version of a diagram, chart, layout, screenshot, draft, or visual reference image, first produce a short interpretation plan and obtain confirmation before creating or editing slides.
- The interpretation plan must identify the reference image, intended slide/page target, visible text to reproduce, diagram structure, key shapes, colors, approximate layout, editable-object goal, and any illegible or ambiguous content.
- If the user supplies documents, PDFs, reports, or notes together with reference images, treat the documents as the content authority and the images as visual/layout references unless the user explicitly says otherwise.
- In that combined case, analyze the documents first, extract the facts/terms/relationships to be shown, then interpret the reference image, then present a source-to-visual mapping for approval before production.
- Ask whether the goal is faithful visual recreation, editable conceptual recreation, or stylistic inspiration. Do not assume exact copying is desired when the user only provides an image.
- Do not invent missing labels, data values, axis text, legends, formulas, or relationships from the image. Mark uncertain content and request user confirmation or source material.
- Default to PowerPoint COM native editable objects only for simple diagrams and ordinary flowcharts where the object count, arrows, and layout are easy to control.
- For slightly complex diagrams, module diagrams, relation maps, architecture sketches, or diagrams with non-trivial arrows/groups, prefer the installed draw.io capability when available. Do not modify draw.io skill/tool rules; use it as the diagram authoring backend.
- Draw.io workflow: use the draw.io skill/capability to create the source diagram, use the local draw.io application to export both SVG and PNG, inspect the PNG for layout/visual QA, and inspect the SVG text/rendering for mojibake, missing labels, and PowerPoint compatibility before importing into PowerPoint.
- A draw.io-exported SVG is PPT-compatible only if it has no visible mojibake/missing labels and does not contain unsupported HTML text fallbacks such as `foreignObject`, embedded `data:image` label fallbacks, or the draw.io warning text `Text is not SVG - cannot display`. If any of these appear, treat the SVG as not suitable for PPT insertion.
- Import the draw.io-exported SVG into PowerPoint through COM only after the SVG passes the no-mojibake/no-missing-label and PPT-compatibility checks. Keep the PNG as a preview/reference artifact for QA.
- If the SVG is invalid, visually broken in PowerPoint, has mojibake, drops labels, contains unsupported HTML/foreignObject text, or otherwise fails the SVG check, use the draw.io-exported PNG as the PPT fallback after telling the user that the inserted diagram will be a raster image and not conveniently editable inside PowerPoint.
- If draw.io software or the draw.io skill/capability is not installed or unavailable, tell the user and ask whether to install/enable it or fall back to PowerPoint COM native drawing/SVG generation.
- For dense paper figures, relation maps, multi-branch taxonomy diagrams, or diagrams with many small labels/edges, use a diagram-first workflow: produce a diagram specification, render it as SVG/draw.io/vector artwork when high visual fidelity matters, then insert it into PowerPoint through COM.
- Before producing a complex recreated diagram, ask the user to confirm one production mode: `高保真视觉复刻` (SVG/vector inserted, limited PPT editability), `PPT 原生可编辑简化版` (editable but less faithful), or `混合版` (vector base plus editable labels/callouts where practical). If a non-native/vector/image path is chosen, explicitly state which parts will not be conveniently editable in PowerPoint.
- The diagram specification must list nodes, visible text, hierarchy/regions, connector directions, colors, approximate layout, source-to-visual mapping, and any uncertain labels. Obtain approval for this specification before rendering.
- For COM-native recreated diagrams, the specification must also include connector routing, object layering, drawing order, and special-symbol handling before writing the automation script.
- If the user wants a new diagram inspired by a reference image and based on documents, the documents define content and relationships; the reference image defines only visual grammar unless the user explicitly says to copy its content.
- For formal outputs based on a reference image, include reference-image comparison in QA: check text, labels, hierarchy, directionality, relative placement, color intent, aspect ratio, alignment, and whether any approved ambiguities remain unresolved.

Generated images:

- Use the currently available image generation capability only after the user permits generated imagery for the deck.
- Suitable uses: cover visual, background, section divider, conceptual illustration, non-factual decoration.
- Never use generated visuals as experimental results, paper evidence, product screenshots, real-world measurements, statistical plots, or text-heavy factual diagrams.
- Keep slide text as native PowerPoint text, not baked into generated imagery.

Diagram defaults:

| Diagram | Production path |
| --- | --- |
| Very simple diagram or ordinary flowchart | Editable native PowerPoint shapes/connectors through COM |
| Slightly complex module diagram, relation map, architecture sketch, or grouped arrow diagram | Prefer draw.io skill/source; export SVG and PNG with draw.io software, verify PNG layout and SVG text, import SVG if valid, otherwise insert PNG fallback with editability warning |
| Complex architecture, dense relation map, or paper taxonomy figure | Use draw.io/SVG/vector workflow, then insert into PowerPoint after confirming editability tradeoff |
| Fully editable complex diagram explicitly requested | Use native objects as far as practical and explain tradeoffs |

## Required Confirmation Before Writes

Before any creation, edit, copy, export, or preview-render operation, present and confirm:

- Input deck/template/materials.
- Dedicated task subdirectory, directory name, and where generated plans, scripts, draw.io files, exports, previews, and output files will be stored.
- Proposed output path and file name.
- Whether work is performed on a copy.
- Whether any existing file will be overwritten; recommend no overwrite.
- Whether PowerPoint should remain visible during execution.
- Whether PDF export is needed.
- Whether generated images or a specified image directory may be used.
- For draw.io routes, whether draw.io skill/capability and local draw.io software are available, where `.drawio`, SVG, and PNG files will be saved, and whether PNG fallback is acceptable if SVG is not PowerPoint-compatible.
- For existing deck edits, whether the edit scope, affected slides, modification plan, preservation/removal choices, and output copy have been approved.
- For data charts/tables, whether the data baseline, units, axes, labels, legends, rounding/simplification policy, and source attribution have been approved.
- For image-reference recreation, whether the image interpretation plan and uncertain text/data have been approved.
- For any reference-image/paper-figure recreation beyond a very simple diagram, whether the user approved draw.io, PPT-native simplified, or hybrid production route before drawing.
- For document-plus-reference-image recreation, whether the source-to-visual mapping has been approved and any conflict between source content and image appearance has been resolved.
- Whether the output is a quick draft or formal presentation.
- Generation execution mode: `快速批量生成` or `PowerPoint 可见逐页生成`.
- For source-based creation of a new deck, whether a detailed Markdown plan has been approved, either newly generated or user-supplied and reviewed.

## Validation and QA

Read `references/visual-qa.md` for checks and execution details.

Quick draft:

- Save successfully.
- Reopen or open with PowerPoint to confirm the presentation is readable.
- Confirm expected slide count and principal content were produced.
- Do not require full-slide preview inspection unless a visible problem is found.

Formal presentation:

- Confirm it opens successfully.
- Produce a preview of the deck for visual inspection.
- Perform one full-deck visual review.
- Treat mojibake, replacement glyphs, unexpected symbols, wrong bullet characters, broken math text, missing labels, or white-on-light unreadable text in previews as QA failures that must be fixed before delivery.
- When slides recreate a reference image, compare the preview against the approved interpretation plan and reference image.
- When formulas are present, perform formula-specific comparison against the approved formula baseline.
- Fix discovered issues.
- Recheck affected slides after fixes before delivery; a repair is not complete until a new preview or equivalent visual check confirms the repaired slide.
- Limit formal visual QA to at most two preview/check cycles unless the user explicitly asks to continue. If the second QA pass still shows that the slide or diagram has not reached the approved target, stop, explain the remaining mismatch, and recommend the next production mode or required source material instead of continuing blind patching.
- For draw.io-based diagrams, QA must include both the exported PNG preview and the SVG text/rendering check before importing or delivering the PPT. If SVG import is rejected and PNG fallback is used, the final PPT preview must be checked again with the inserted PNG.
- For complex recreated diagrams, if repeated repair cycles still fail to match the approved specification closely enough within the two-QA limit, stop and report the remaining mismatch and the recommended next production mode.

## Bundled Scripts

- `scripts/test_powerpoint_com.ps1`: verify that PowerPoint COM is available without saving a file.
- `scripts/inspect_presentation.ps1`: read-only slide/text/shape inventory for an explicitly identified deck.
- `scripts/copy_template.ps1`: make a safe working copy after write approval.
- `scripts/export_preview.ps1`: export slide PNG previews after write/export approval.

For substantive generation and edits, write a task-specific PowerShell script in the user workspace after confirmation, using the references and the requested presentation structure. Keep reusable scripts safe and narrowly scoped rather than attempting to encode every possible design operation.

## Delivery

- Primary output is `.pptx`.
- Export `.pdf` only when requested and confirmed.
- Report output paths, whether the original file remained untouched, the validation level performed, and any unresolved visual or content risks.
- If the work created task-specific PowerShell scripts (`.ps1`) or preview artifacts that are not required final deliverables, tell the user they are intermediate files and ask whether to keep or delete them; never delete them without explicit confirmation.
