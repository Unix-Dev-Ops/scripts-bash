# GitHub setup — scripts-bash (Hermes skill)

Do this in the browser. Takes ~3 minutes. Separate from Kaggle / citizen-benefits.

## What you are creating

| Field | Value |
|--------|--------|
| Owner | **Unix-Dev-Ops** (your GitHub user) |
| Repo name | **scripts-bash** |
| Visibility | **Public** (recommended for a Hermes skill) |
| Description | `Hermes Agent skill: rigid standard for long-lived bash installer/manager scripts` |
| Initialize | **No** README, **No** .gitignore, **No** license (local repo already has all of that) |

This is a **Hermes drop-in skill** under `skills/software-development/`.  
It is **not** the CitizenBenefits / Kaggle project.

## Step 1 — Create empty repo on GitHub

1. Open: https://github.com/new  
2. Owner: **Unix-Dev-Ops**  
3. Repository name: **scripts-bash**  
4. Public  
5. Description: paste the line from the table above  
6. **Uncheck** “Add a README file”  
7. **Uncheck** .gitignore / license  
8. Click **Create repository**

You should land on an empty repo page with push instructions. Stop there.

## Step 2 — Tell Hermes / me

Reply in chat:

```text
Repo created. Push scripts-bash.
```

I will run from `~/.hermes/projects/scripts-bash/`:

```bash
git remote add origin https://github.com/Unix-Dev-Ops/scripts-bash.git
git push -u origin main
```

(Same auth style that already works for `citizen-benefits`.)

## Step 3 — After first push (you, in GitHub UI)

### About box
- Website: `https://hermes-agent.nousresearch.com/` (optional)
- Topics: `hermes-agent`, `hermes-skill`, `bash`, `shell`, `devops`, `installers`, `automation`

### Branch protection (`main`) — Settings → Rules → Rulesets
- Require pull request before merge  
- Require 1 approval  
- Require review from Code Owners  
- Require status checks: **validate**  
- Block force pushes  

Details: `MAINTAINERS.md` in the repo.

### First release (optional)
- Releases → Draft → tag `v4.2.0` → title matching skill version  

## What friends install

```bash
git clone https://github.com/Unix-Dev-Ops/scripts-bash.git
cp -a scripts-bash/skills/software-development/scripts-bash \
  ~/.hermes/skills/software-development/
```

Then in Hermes: `/skill scripts-bash`

## Do not

- Do not copy CitizenBenefits files into this repo  
- Do not add `workspace/installers` production scripts unless you scrub them for public  
- Do not commit `.env` or tokens  
- Do not use the Kaggle writeup as this project’s story  

## Mental model

```text
citizen-benefits  →  your Kaggle / Google agent product
scripts-bash      →  Hermes skill that makes bash installers excellent
neo-backups       →  private Hermes backup mirror (if you use it)
```

Three different repos. One GitHub user. Same identity (`Unix-Dev-Ops`).
