# Data, Chart, and Table Workflow

Use this reference when creating or modifying charts, tables, quantitative comparison slides, metric cards, timelines with dates, or any slide where numbers, units, percentages, axes, legends, or labels are part of the factual content.

## Data Baseline Gate

Before producing data-driven visuals, establish and confirm a data baseline:

- Source file, paper table/figure, page number, user-provided values, or pasted data.
- Exact values to use, including units, percentages, denominators, date ranges, and sample sizes.
- Whether values may be rounded, normalized, converted, translated, or simplified.
- Chart/table type and why it fits the comparison.
- Axis labels, units, legend labels, series names, ordering, and color meaning.
- Whether the result is a faithful reproduction, a cleaned presentation version, or an explanatory simplification.

Do not infer missing values, units, or denominators. Mark them as unresolved and request confirmation.

## Production Rules

- Prefer native PowerPoint tables and charts when editability matters and the data is simple enough to verify.
- Use images only for complex paper plots or evidence figures that should remain visually faithful.
- If recreating a paper chart, record whether it is copied/cropped, redrawn from visible data, or rebuilt from extracted/source data.
- Keep the source data or a compact data table in `plan/`, `source/`, or `exports/` inside the task directory when practical.

## QA

For formal outputs, check:

- Values match the approved baseline.
- Units, axes, legends, categories, colors, and labels match the approved plan.
- Rounding or simplification is disclosed when used.
- Tables do not overflow, truncate, or merge cells incorrectly.
- Charts remain readable in the final PPT preview.
