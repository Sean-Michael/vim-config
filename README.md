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

Notes:

- vim-plug is committed at `autoload/plug.vim`, so plugins install on the first `:PlugInstall`.
- coc.nvim needs Node.js installed.
- Icons (vim-devicons) need a [Nerd Font](https://www.nerdfonts.com/) in your terminal.
