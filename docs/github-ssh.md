# GitHub SSH Setup

GitHub CLI (`gh`) is included in this configuration. Use it to set up SSH authentication once on your machine.

## Sign in and set up a key

Run:

```bash
gh auth login --hostname github.com --git-protocol ssh --web
```

Follow the prompts to sign in through your browser and upload an existing SSH public key, or generate and upload a new one. Use a passphrase when generating a key. Keep the private key on your machine; only the public key is uploaded to GitHub.

This also sets SSH as the preferred Git protocol for GitHub CLI. See the [GitHub CLI login documentation](https://cli.github.com/manual/gh_auth_login).

## Test authentication

```bash
ssh -T git@github.com
```

## Switch an existing repository to SSH

From inside the repository, inspect its remote:

```bash
git remote -v
```

If `origin` uses HTTPS, replace `OWNER/REPO` below with the same repository's owner and name:

```bash
git remote set-url origin git@github.com:OWNER/REPO.git
```

Signing in with `gh` does not automatically change existing repository remotes. Once the remote uses SSH, use `git pull` and `git push` normally.

## Clone a repository using SSH

Replace `OWNER/REPO` with the repository you want:

```bash
git clone git@github.com:OWNER/REPO.git
```
