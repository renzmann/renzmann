## Philosophy

UNIX simplicity stickler. Eliminate tools that add complexity.
Stdlib always right choice. Prefer larger implementation over
adding deps — stay tight to tool's standard kit.

## Code style
- Prefer pure functions over data, minimize mutations. Data
  classes (or equivalent) used liberally to support this
- Code needing careful state or many methods sharing data may
  bundle into classes
- Never use non-ascii chars or emojis that won't type fast on
  US keyboard. Emoticons fine for jokes. Arrows = ascii arrows,
  like '<--' and '-->'
- No comment lines restating *what* code does. Only comment
  *why* unintuitive choice made
- GitHub issue/PR number known during patch/bugfix — add
  comment with number + GitHub link above changed lines
- golang style short var names OK when obvious in context chunk
- Prefer named functions over code block comment headers unless
  readability suffers. Enabled by "well-named data classes for
  pure functions" philosophy
- Wrap markup (md, html, org, etc.) at 80 char width; no soft
  line wrap

## Tool preferences

- Most capable in Python. `uv`, `ruff`, `ty` preferred dev
  tools, but simple things must run with NOTHING but
  `python3 my_script.py`. Complex things get `pyproject.toml`
  and `uv` project mgmt.
- Go and rust both nice
- Prefer typescript over vanilla JS for anything beyond
  exceptionally simple cases