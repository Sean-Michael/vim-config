# vim-config

Comfy IDE-ish Vim setup for Python / TypeScript / Markdown.
Nord theme · vim-plug · coc.nvim for LSP/completion.

## Setup on a new machine

```sh
git clone https://github.com/Sean-Michael/vim-config.git ~/.vim
```

Vim reads `~/.vim/vimrc` automatically — no symlinks needed. Then open vim and run:

```
:PlugInstall
:CocInstall coc-pyright coc-tsserver coc-json coc-html coc-css coc-eslint coc-prettier coc-markdownlint
```

## iTerm2 settings

The `iterm2/` folder holds the full settings plist (XML) and the Nord dynamic profile. To restore on a new machine:

```sh
defaults import com.googlecode.iterm2 ~/.vim/iterm2/com.googlecode.iterm2.plist
mkdir -p ~/Library/"Application Support"/iTerm2/DynamicProfiles
cp ~/.vim/iterm2/Nord.json ~/Library/"Application Support"/iTerm2/DynamicProfiles/
```

Run this while iTerm2 is quit, then launch it. Alternatively, for ongoing two-way sync, point iTerm2 at the repo: **Settings → General → Settings tab → "Load settings from a custom folder"** → choose `~/.vim/iterm2` (iTerm2 will then read and write its plist there directly).

To refresh the export on this machine after changing settings:

```sh
plutil -convert xml1 -o ~/.vim/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
```

Notes:

- vim-plug is committed at `autoload/plug.vim`, so plugins install on the first `:PlugInstall`.
- coc.nvim needs Node.js installed.
- Icons (vim-devicons) need a [Nerd Font](https://www.nerdfonts.com/) in your terminal.
