**Set up command-line key bindings to grep for a string and insert the path of a selected file that contains the searched-for string at the current cursor position**.
In more detail:

The shell script `fzf-grep-all.sh` adds

- shell functions `fs` and `fo` to open a (text/document) file that contains a word fuzzily searched for (using [fzf](https://github.com/junegunn/fzf))

The shell scripts `fzf-grep-all.bash` / `fzf-grep-all.zsh` set up

- key bindings `Alt-G` and `Control-G` in `Bash` and `ZSH` to insert, at the cursor position, the path of a file that contains a word fuzzily searched for (using [fzf](https://github.com/junegunn/fzf))

    - among all text files (when `Alt-G` was hit) using a search tool such as [rg (ripgrep)](https://github.com/BurntSushi/ripgrep), [ugrep](https://github.com/Genivia/ugrep) or `(git) grep`
    - among all document files such as `PDFs`, `Microsoft Word/Powerpoint/Excel` files, ... (when `Control-G` was hit) using [rga](https://github.com/phiresky/ripgrep-all)

Note that, while `ugrep` can search such document files by its [--filter` option](https://github.com/Genivia/ugrep#filter), it is [not meant to be used for indexing](https://github.com/Genivia/ugrep/commit/8702bf6d4bfe28716a502671dba7ebadbb48a93e#diff-2281406f4ec5b9dc1a741e569ba4f9735100ee2afeea8a19fa315db802ea24cd).

# Installation

1. Save these scripts, say to `~/.config/fzf-grep-all`

    ```sh
    git clone https://github.com/Konfekt/fzf-grep-all.sh ~/.config/fzf-grep-all
    ```

1. Source them on shell startup by adding the lines below to the shell configuration file

    - `~/.profile` for Bash

    ```sh
    . "$HOME/.config/fzf-grep-all/fzf-grep-all-bindings.bash"
    ```

    - respectively `~/.zshrc` for ZSH

    ```sh
    . "$HOME/.config/fzf-grep-all/fzf-grep-all-bindings.zsh"
    ```

# Customization

The key bindings can be set by the first argument of the command `bind` (in `Bash`) respectively `bindkey` (in `ZSH`).

