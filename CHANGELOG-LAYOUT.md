# Layout change (2026-07-20)

## What changed

- **Live skill only:** `~/.hermes/skills/software-development/scripts-bash/`
- **Removed** profile copy: `~/.hermes/profiles/coder-bash/skills/scripts-bash/`
- **coder-bash** = workspace + SOUL/AGENTS pointing at global skill (auto load + version-bump rewrites)
- **Git** `~/.hermes/projects/scripts-bash/` = GitHub package only (not a second live install)
- Default `~/.hermes/SOUL.md` updated to match
- Skill version **4.2.3**

## Unchanged

- `workspace/installers/*` products (not modified)
- Public skill content (template, registry, authoring)

## Operator flow

1. Edit/test: `~/.hermes/skills/software-development/scripts-bash/`
2. Release: copy that tree into `projects/scripts-bash/skills/software-development/scripts-bash/`
3. `cd ~/.hermes/projects/scripts-bash && git push`
