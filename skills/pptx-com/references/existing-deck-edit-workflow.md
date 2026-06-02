# Existing Deck Edit Workflow

Use this reference when the user asks to modify, polish, restructure, restyle, shorten, expand, translate, review-and-fix, or otherwise edit an existing `.pptx`/PowerPoint file.

## Edit Gate

Before editing any existing deck, confirm:

- Input deck path and whether it is only being inspected or actually modified.
- Dedicated task subdirectory.
- Output copy path. Default to a new copy; do not modify the original unless the user explicitly approves direct modification.
- Affected slides or scope: whole deck, selected slides, selected sections, or specific objects.
- Edit intent: content rewrite, layout cleanup, style consistency, template migration, image/diagram replacement, speaker-note changes, or export only.
- Whether original slides should be preserved, duplicated before editing, hidden, or replaced.
- Whether PowerPoint should remain visible.
- Quick draft or formal QA.

## Modification Plan

For non-trivial edits, produce a short edit plan before writing:

| Field | Requirement |
| --- | --- |
| Slide/section | Target slide numbers, titles, or sections |
| Current issue | What is wrong or needs improvement |
| Proposed change | Exact content/layout/style operation |
| Risk | Possible loss of original content, layout mismatch, or source ambiguity |
| Confirmation needed | Any user choice required before editing |

Do not silently delete content. If content must be removed, summarized, hidden, or moved to notes, say so in the edit plan and request approval.

## QA

- Quick edits: confirm the output file opens and affected slides exist.
- Formal edits: export previews or otherwise inspect affected slides after changes.
- If edits affect theme, layout, page size, fonts, diagrams, formulas, or data charts, use the corresponding reference workflow as well.
