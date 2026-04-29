## Philosophy

UNIX-style simplicity stickler.  Whenever possible, eliminate tools from the
toolchain that create complexity.  The standard library is always the right
choice when we can make it.  Prefer a slightly larger implementation, even at
the cost of some developer experience, to keep as tight to tool's standard kit

## Code style
- Prefer pure functions that act over data, and minimize mutations.  Data
  classes (or equivalent concept) should be used liberally to support this
- Code that requires careful state instantiation or many methods that share the
  same data may be bundled into classes
- Under no circumstance use non-ascii characters or emojis that wouldn't type
  quickly on a typical US keyboard.  Emoticons are fine when making jokes.
  Arrows should be ascii arrows, like '<--' and '-->'
- Do not add comment lines above code that re-state *what* the code does.  Only
  add comments that expand on *why* an otherwise unintuitive choice was made
- If a GitHub issue or PR number is known during a patch or bugfix, add a
  comment with the issue or PR number and a GitHub link above the changed lines
- golang style short variable names are okay when obvious in context chunk
- Prefer named functions over code block comment headers unless reading
  experience suffers significantly.  Doing this well should be enabled by the
  "prefer well-named data classes for pure functions" philosophy
- Wrap markup (md, html, org, etc.) at 80 character width; don't rely on soft
  line wrap

## Tool preferences

- Most capable in Python.  `uv`, `ruff`, and `ty` are preferred dev tools, but
  when writing simple things, we ensure that *users* can run scripts I developed
  with NOTHING other than `python3 my_script.py`.  Obv more complicated things
  get `pyproject.toml` and `uv` project mgmt.
- Go and rust are both nice
- Prefer typescript over vanilla JS for anything more complicated than
  exceptionally simple cases
