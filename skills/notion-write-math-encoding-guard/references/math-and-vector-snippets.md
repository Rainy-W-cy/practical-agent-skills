# Math and Vector Snippets

Use these snippets when writing Notion pages with formulas.

## Inline Math

- `$y = ax + b$`
- `$\\alpha + \\beta = \\gamma$`
- `$\\|x\\|_2$`

## Block Math

```text
$$
\\hat{y} = \\arg\\max_i\\; p(i \\mid x)
$$
```

## Vectors and Matrices

- `$$\\vec{x} = (x_1, x_2, \\ldots, x_n)^T$$`
- `$$\\mathbf{w}^T \\mathbf{x} + b$$`
- `$$A = \\begin{bmatrix} a & b \\\\ c & d \\end{bmatrix}$$`

## Piecewise Function

```text
$$
f(x) = \\begin{cases}
0, & x < 0 \\\\
1, & x \\ge 0
\\end{cases}
$$
```

## Safe Writing Tips

- Keep formulas ASCII-first (LaTeX commands) for portability.
- Do not mix decorative Unicode symbols inside LaTeX commands.
- Ensure each `\\begin{...}` has a matching `\\end{...}`.