---
name: markdown-encoding-guard
description: Use this skill whenever the task involves creating or updating Markdown (.md) files that must preview correctly in editors such as VSCode. Ensures UTF-8 without BOM output, supports either Chinese or English content based on user preference, and requires post-write validation to prevent mojibake, question-mark replacement, or BOM-related preview issues.
---

# Markdown Encoding Guard

Use this skill when creating or editing `.md` files for the user, especially when the files must preview correctly in VSCode.

## Required behavior

1. Determine the content language from the user request.
   - If the user explicitly asks for Chinese, write Chinese.
   - If the user explicitly asks for English, write English.
   - If the user does not specify, follow the language used in the current request.

2. Save Markdown files as `UTF-8 without BOM`.
   - Never save `.md` files as ANSI, GBK, UTF-8 with BOM, or platform-default encoding.
   - If an existing `.md` file is corrupted or mis-encoded, rewrite the full file as clean `UTF-8 without BOM` content instead of repeatedly converting a damaged file.

3. When writing Markdown that contains non-ASCII text, use a writing path that cannot silently replace characters.
   - Prefer writing the file through a Unicode-safe method.
   - If the shell or terminal may corrupt Chinese characters, write via a script that constructs the text safely and then writes with `encoding="utf-8"`.
   - A robust fallback is to construct non-ASCII text through Unicode escape sequences inside the script, then decode and write the final text.

4. Validate after writing.
   - Read the file back using UTF-8.
   - Confirm there is no BOM at the file start.
   - Confirm the expected language characters exist when applicable.
   - Confirm the file does not contain bulk replacement artifacts such as many `?` characters where natural language text should appear.

## Minimum validation checklist

After creating or rewriting a Markdown file, verify all of the following:

- File bytes do not start with `EF BB BF`.
- File can be read as UTF-8.
- If the document is supposed to be Chinese, it contains actual CJK characters.
- If the document is supposed to be English, headings and body text are readable plain English.
- The file content is suitable for direct Markdown preview in VSCode.

## Preferred workflow

```text
确定语言
-> 生成 Markdown 正文
-> 以 UTF-8 without BOM 写入
-> 回读验证编码和内容
-> 仅在验证通过后交付
```

## Practical guidance

- Keep Markdown structure simple and standard: headings, paragraphs, tables, fenced code blocks, and plain lists.
- Avoid copy-pasting text through terminal paths that have already shown encoding corruption.
- If the user reports preview??, assume the file content may already be damaged; rebuild the text source cleanly before writing again.
- When fixing an existing document, prefer a full clean rewrite over incremental patching if the current content contains mojibake or `?` replacement.

## Response expectations

When finishing the task, explicitly state:
- the Markdown file path,
- that it was written as `UTF-8 without BOM`,
- and that a post-write validation was performed.
