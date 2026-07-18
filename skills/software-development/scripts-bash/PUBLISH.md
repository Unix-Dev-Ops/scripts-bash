# Publish checklist (scripts-bash)

## Ship this tree only

```text
skills/software-development/scripts-bash/
  SKILL.md
  README.md
  PUBLISH.md
  references/template-base.sh
  references/screaming-snake-case-variables.md
  references/authoring.md
  templates/template-base.sh
  examples/minimal-service-installer.sh
```

## Do not ship

- Full production installer trees
- Profile `workspace/prompts/` design briefs
- Symlinks into a private profile workspace
- Hostnames, API keys, machine-local paths as requirements
- Duplicate archives of old SKILL.md versions

## Checks

```bash
bash -n references/template-base.sh
bash -n templates/template-base.sh
bash -n examples/minimal-service-installer.sh
# frontmatter: name, description starts with "Use when"
```

## Local dual install (optional)

Canonical: `~/.hermes/skills/software-development/scripts-bash/`  
Mirror: `~/.hermes/profiles/<name>/skills/scripts-bash/`  

After edits: copy canonical → mirror. Products stay in profile `workspace/`.
