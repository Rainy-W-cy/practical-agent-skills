---
name: notion-write-math-encoding-guard
description: Prevent mojibake and formula corruption when creating or updating Notion pages that contain Markdown, LaTeX formulas, vectors/matrices, and mixed Chinese-English text. Use when Notion content includes non-ASCII symbols, math delimiters, previously corrupted escapes, or unstable Notion formula rendering.
---

# Notion Write Math Encoding Guard

## Overview

Use this skill when Notion page content must stay readable after upload, especially for formula-heavy technical notes.
The goal is not only to prevent mojibake, but also to keep formula presentation stable in Notion preview, fetch output, and later edits.

## Workflow

1. Determine language, math density, and whether the user wants full rewrite or local edits.
2. Determine content ownership before drafting:
   - user-provided text that must be preserved
   - assistant-authored explanation that may be reformatted
3. Classify formulas before drafting:
   - plain-text-safe
   - inline-math-needed
   - block-math-needed
4. Build content in Notion-friendly Markdown with LaTeX-safe formulas and preview-stable layout.
5. For existing pages, fetch first and decide `replace_content` vs `update_content`.
6. Write to Notion.
7. Fetch again and validate encoding, delimiters, wording fidelity, and rendering stability.

## Authoring Rules

- If the user gives text to write into Notion, preserve the user's wording and intent by default.
- Do not autonomously rewrite, polish, summarize, or strengthen the user's wording unless the user explicitly asks for that.
- You may only normalize formatting, formula delimiters, headings, spacing, list structure, and obvious encoding issues when writing the user's content into Notion.
- When user wording and Notion preview stability conflict, keep the wording and change only the presentation layer.
- Prefer block formulas (`$$...$$`) for complex expressions.
- Use inline formulas (`$...$`) only for short symbols that truly need math rendering.
- Prefer LaTeX commands over decorative Unicode math glyphs.
- Use canonical forms: `\\vec{x}`, `\\mathbf{x}`, `\\begin{bmatrix}...\\end{bmatrix}`.
- Keep punctuation in formulas ASCII-only.
- Keep mixed-language prose outside formula delimiters where possible.
- Prefer plain text for simple function names and short variables in prose.
- Do not wrap every symbol in inline math by default.
- Avoid mixing backticks and math delimiters around the same token.
- For long-term notes, prefer "few block formulas + mostly plain text" over dense inline math.

## Preview-Stable Notion Layout Rules

- Write for Notion page preview first, not for raw Markdown aesthetics.
- Avoid layouts that commonly render badly in Notion preview:
  - dense inline formulas inside long Chinese sentences
  - mixed backticks and math delimiters on the same token
  - deeply nested lists containing formulas
  - long multi-clause paragraphs that alternate prose and symbols repeatedly
- Prefer short paragraphs, flat lists, and separated block formulas.
- Keep headings concise and aligned with the user's original structure.
- If the user provides an existing section order, preserve that order unless the user explicitly requests restructuring.
- Do not add explanatory sections, transition sentences, or editorial comments unless the user asked for them.
- If a table is likely to misalign or degrade in Notion preview, rewrite it into a flat bullet list only if this does not change the user-requested content structure.
- When formatting user-provided content, optimize spacing and alignment only to improve Notion readability, never to change meaning.

## Formula Style Guide

### Use plain text when:

- Mentioning a function name in prose
- Describing thresholds or parameter ranges
- Referring to simple scalars or settings
- Explaining hardware control flow, FSM names, or module names

Examples:

- `Softmax`
- `LayerNorm`
- `exp(x)`
- `sqrt(a)`
- `h <= 4`
- `N >= 3`
- `a in [0, 2]`

### Use inline math when:

- A short symbol would be ambiguous in plain text
- A sentence needs one compact mathematical token

Examples:

- `$x_i$`
- `$\\mu$`
- `$\\sigma^2$`

### Use block math when:

- The expression contains fractions, roots, summations, matrices, or updates
- The formula is central to the explanation
- The same formula may be referenced later

Examples:

$$
\\mathrm{Softmax}(x_i) = \\frac{e^{x_i}}{\\sum_{j=1}^{N} e^{x_j}}
$$

$$
x_{n+1} = \\frac{1}{2}\\left(x_n + \\frac{a}{x_n}\\right)
$$

## Notion Write Rules

- For new pages, create with title in properties and body in content.
- For existing pages, always fetch before editing.
- Prefer full `replace_content` when corruption is widespread.
- Prefer `update_content` for small, exact-match edits.
- Avoid blind global replacements on formula-heavy content.
- When a page has repeated formula corruption, prefer rebuilding the affected section from clean source text rather than patching escaped fragments in place.
- If both encoding cleanup and formula-style cleanup are needed, prefer one controlled full rewrite over many small edits.
- If the user asks to "write this content into Notion", treat the provided content as source-of-truth text.
- In that case, editing scope is limited to:
  - encoding repair
  - math delimiter stabilization
  - line break and heading normalization
  - preview-safe list and paragraph formatting
- In that case, do not:
  - rewrite the tone
  - add missing analysis on your own
  - compress or expand the substance
  - silently convert the content into a different style

## Wording Fidelity Rules

- Preserve terminology exactly when it appears intentional, including mixed Chinese-English technical phrases.
- Preserve emphasis markers, section names, and user-specified ordering unless they directly cause rendering failure.
- If a phrase is awkward but readable, keep it.
- If a phrase is unreadable because of corruption, reconstruct the smallest necessary fragment only.
- When you must repair a corrupted expression, keep the nearest recoverable wording rather than producing a cleaner paraphrase.

## Validation Checklist

After writing to Notion, verify all checks:

- Page fetch returns readable text in the requested language.
- User-provided wording has not been unintentionally rewritten.
- No mojibake markers such as `???`, replacement bursts, or obviously garbled character runs.
- Formula delimiters remain balanced.
- Backslashes in LaTeX commands are preserved.
- Critical formulas and vector/matrix snippets render in Notion UI.
- Plain-text function names do not appear wrapped in accidental math delimiters.
- API fetch noise is distinguished from true corruption:
  - escaped backslashes alone do not prove the page is broken
  - repeated `$`\...`$`-style fragments or mixed backticks/math usually indicate unstable authoring
- If API text shows escaped backslashes, verify UI rendering before concluding corruption.
- Headings, bullets, spacing, and formula blocks remain visually aligned in Notion preview.

## Failure Handling

If validation fails:

1. Rebuild the affected section from clean source text.
2. Reduce inline formulas; convert complex inline math to block formulas.
3. Convert non-essential inline math to plain text function or variable notation.
4. Revert any unnecessary wording changes and keep only formatting repairs.
5. Re-apply update with exact snippet boundaries.
6. Fetch again and re-check delimiters, backslashes, wording fidelity, and UI rendering.

## Decision Heuristics

- If the page is mostly readable but a few formulas are ugly, use `update_content`.
- If formulas are broadly inconsistent, mixed with escaped fragments, or preview is unstable, use `replace_content`.
- If the user wants a long-term notes page, optimize for stability, not for maximal LaTeX density.
- If a formula-heavy page keeps regressing after edits, simplify the notation style rather than adding more escapes.
- If the user provides final text for direct write-in, prefer preserving wording over stylistic optimization.
- If preview stability can be fixed by layout changes alone, do not touch the wording.

## Quick Snippets

See `references/math-and-vector-snippets.md` for safe equation, vector, and matrix templates.
