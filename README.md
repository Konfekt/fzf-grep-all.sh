**Set up command-line key bindings to grep for a string and insert the path of a selected file that contains the searched-for string at the current cursor position**.
In more detail:

The shell script `fzf-grep-all.sh` adds

- shell functions `fs` and `fo` to open a (text/document) file that contains a word fuzzily searched for (using [fzf](https://github.com/junegunn/fzf))

The shell scripts `fzf-grep-all.bash` / `fzf-grep-all.zsh` set up

- key bindings `Alt-G` and `Control-G` in `Bash` and `ZSH` to insert, at the cursor position, the path of a file that contains a word fuzzily searched for (using [fzf](https://github.com/junegunn/fzf))

    - among all text files (when `Alt-G` was hit) using a search tool such as [rg (ripgrep)](https://github.com/BurntSushi/ripgrep), [ag (The Silver Searcher)](https://github.com/ggreer/the_silver_searcher) or `(git) grep`
    - among all document files such as `PDFs`, `Microsoft Word/Powerpoint/Excel` files, ... (when `Control-G` was hit) using [rga](https://github.com/phiresky/ripgrep-all)

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

