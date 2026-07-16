# Dotfiles

macOS setup for a new machine: dotfiles, Homebrew packages (`Brewfile`),
iTerm2 + Zed settings, macOS defaults, and a `bootstrap.sh` that ties it
all together.

```
├── bootstrap.sh          # one-shot new-machine setup (idempotent)
├── Brewfile              # everything installed via Homebrew
├── dotfiles-install.sh   # copies src/ dotfiles into ~
├── dotfiles-uninstall.sh # removes them again
├── setup-osx.sh          # macOS defaults (Dock, keyboard, Finder, …)
├── iterm/                # iTerm2 preferences (loaded directly from here)
├── zed/                  # Zed settings.json + keymap.json
├── scripts/
│   ├── dump-repos.sh     # old machine: list all ~/projects repo URLs
│   └── clone-repos.sh    # new machine: re-clone them
└── src/                  # the dotfiles themselves (.bash_profile, .gitconfig, …)
```

## Migrating to a new machine

### Phase 0 — on the OLD machine

1. Make sure this repo is up to date and pushed (see [Keeping things in
   sync](#keeping-things-in-sync) below).
2. Dump the list of project repos:
   ```bash
   ./scripts/dump-repos.sh
   ```
   This writes `repos.txt` (gitignored — don't commit it).
3. AirDrop (or copy via SSD) the things that must never go into git:
   - `repos.txt`
   - `~/.ssh/` — keys, config, **and the `git-signing` key** (commits are
     signed with it, see `.gitconfig`)
   - `~/.profabevjava` (ABEVJAVA)
   - anything in `~/Documents` etc. that isn't in a repo or in the cloud

### Phase 1 — new machine, first boot

1. Go through Setup Assistant and sign in with your **Apple ID** (iCloud
   Keychain comes along).
2. **Jamf enrolls here** — a company machine picks up MDM enrollment during
   Setup Assistant (or via IT's onboarding instructions). Jamf and Jamf
   Protect are IT-deployed; nothing to migrate, don't install them via brew.
3. Install **1Password** early if you want it before brew gets to it — or
   just wait, it's in the Brewfile.

### Phase 2 — get git and this repo

A chicken-and-egg note: you need `git` to clone this repo, and macOS ships
without it. Running **any** git command triggers the Xcode Command Line
Tools install popup — accept it, wait, retry.

```bash
mkdir -p ~/projects && cd ~/projects
git clone https://github.com/leventebalogh/.dotfiles.git dotfiles
cd dotfiles
```

> Clone over **HTTPS** at this point — SSH keys aren't set up yet. (After
> the dotfiles are installed, `.gitconfig` rewrites HTTPS GitHub URLs to
> SSH, so this ordering only works before installation. If the repo is
> private, use a browser-downloaded zip or `gh auth login` instead.)

Now restore your SSH keys (AirDropped in Phase 0) **before** running
bootstrap, so the ai-config and project-repo clones work:

```bash
cp -R "<airdropped ssh folder>" ~/.ssh
chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_* ~/.ssh/git-signing
```

Also drop `repos.txt` into the repo root.

### Phase 3 — run bootstrap

```bash
./bootstrap.sh              # everything except macOS defaults
./bootstrap.sh --with-osx   # …including setup-osx.sh
```

What it does, in order:

1. Xcode Command Line Tools (exits and asks you to re-run if missing)
2. Homebrew
3. `brew bundle` — all formulae, casks, and VS Code extensions
4. Copies `src/` dotfiles into `~`
5. fnm → latest LTS node → global npm packages
6. Points iTerm2 at `iterm/` in this repo
7. Copies `zed/*.json` to `~/.config/zed/`
8. Clones [rupa/z](https://github.com/rupa/z) to `~/projects/z`
9. Clones `ai-config` and runs its setup (creates `~/.local/bin/sync`)
10. Sets the login shell to `/bin/bash`
11. Re-clones all project repos from `repos.txt`
12. (`--with-osx`) applies macOS defaults — some need a logout to apply

It's idempotent — if a step fails (e.g. a cask needs a password), fix it
and re-run.

### Phase 4 — manual checklist (~20 minutes)

Logins, roughly in dependency order:

- [ ] **1Password** — sign in (unblocks everything else)
- [ ] **Chrome** — sign in with the Google account → syncs extensions,
      passwords, open tabs
- [ ] **gh auth login** — GitHub CLI
- [ ] **claude** — run it, it walks through login
- [ ] **codex** — same
- [ ] **gcloud init** / `gcloud auth login`
- [ ] **Slack, Telegram, Zed** — sign in in the apps

Keychain tokens (read by `.bash_profile` on every shell) — re-add each one,
pasting the value when prompted:

```bash
security add-internet-password -s github.com  -a GITHUB_PERSONAL_ACCESS_TOKEN -w
security add-internet-password -s context7.com -a API_KEY -w
security add-internet-password -s grafana.com -a GRAFANA_METRICS_API_KEY -w
security add-internet-password -s brave.com   -a BRAVE_SEARCH_MCP_CLAUDE -w
```

Everything else:

- [ ] Copy `~/.profabevjava` into place (AirDropped in Phase 0)
- [ ] iTerm2 → confirm it picked up the profile (it reads prefs from
      `iterm/` in this repo; restart iTerm2 once)
- [ ] Grant the terminal **Full Disk Access** if tools need to read
      protected folders (System Settings → Privacy & Security)
- [ ] Click through the System Settings that `setup-osx.sh` doesn't cover
      (displays, Touch ID, trackpad feel, …)
- [ ] Verify Jamf: Self Service app present, Jamf Protect running

## Keeping things in sync

- **Brew packages**: `brew bundle dump --force --file=Brewfile` (then prune
  the transitive deps the dump adds), or just edit `Brewfile` by hand.
- **iTerm2**: nothing to do — iTerm2 loads *and saves* its prefs directly
  in `iterm/`, so changes show up as a git diff here.
- **Zed**: copy `~/.config/zed/{settings,keymap}.json` into `zed/`.
- **Dotfiles**: edit in `src/` and re-run `./dotfiles-install.sh`, or edit
  in `~` and copy back. Commit either way.

## Uninstall dotfiles

```bash
./dotfiles-uninstall.sh
```
