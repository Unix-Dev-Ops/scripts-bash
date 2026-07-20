# Publish checklist (scripts-bash)

## Ship this tree only

```text
skills/software-development/scripts-bash/
  SKILL.md
  README.md
  PUBLISH.md
  templates/template-base.sh
  references/screaming-snake-case-variables.md
  references/authoring.md
```

## Do not ship

- Duplicate skeletons (`references/template-base.sh`, `examples/` clone)
- Full production installer trees
- Profile `workspace/prompts/` design briefs
- Symlinks
- Secrets / host-private paths as requirements

## Checks

```bash
bash -n templates/template-base.sh
# frontmatter: name, description starts with "Use when"
```

## Local installs

Canonical: `~/.hermes/skills/software-development/scripts-bash/`  
Mirror: `~/.hermes/profiles/<name>/skills/scripts-bash/`  
Git: `~/.hermes/projects/scripts-bash/skills/software-development/scripts-bash/`

After edits: update canonical, then `cp -a` to profile mirror and git skill tree.
