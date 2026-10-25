# Authoring guide — scripts-bash

How to use this skill to produce excellent long-lived bash installer/manager scripts.

## Mental model

| Layer | Role |
|-------|------|
| **Skill** | Law: structure, colors, spinners, naming, gates |
| **Template** | `templates/template-base.sh` — only skeleton; copy it, never freestyle past it |
| **Brief** (optional) | Intent: ports, routines, paths, non-goals |
| **Product** | The `.sh` you run, under profile `workspace/` |

You are not "vibe coding from zero." You are **filling a rigid form** with domain details.


## Short rewrite (automatic)

User says only: `Rewrite this script: /path/to/foo.sh`

Agent must:

1. Load scripts-bash from `~/.hermes/skills/software-development/scripts-bash/`
2. Read source
3. Write version-bumped sibling in the **same directory** (`.foo.sh` → `.foo-01.sh`)
4. **Issue write_file without preamble** (no "Writing now" status essays)
5. `bash -n`; report path + size only

User does not list skill files or steps.

## Clone existing installer (named new path)

User says copy / adapt an existing installer into a **new folder** (new recipe pin, sibling product).

This is **not** a rewrite and **not** interactive creation. Do not ask Q1–Q6. Do not write `name-01.sh` next to the source.

1. Load this skill; read the **working product** (not only the template)
2. Write the full copy to the **user-named path** the operator gave you — that path is the brief.
3. Same engine family: change only the values that differ — image tag, memory floor, published numbers. New engine family, or a different checkpoint: treat it as a new product folder, not a value swap.
