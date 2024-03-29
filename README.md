 dotfiles: A bare Git repository

This uses a bare git repository in a _side_ folder. For example $HOME/.cfg

## Starting from scratch

```
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

* Line 1: Creates a folder ~/.cfg which contains a bare repository that will track the files.
* Line 2: Create a alias for config, and use that instead of **git** to interact with the configuration repository.
* Line 3: Set a flag to hide files that are not being explicitly tracked yet.
* Line 4: Add the alias to the .bashrc

Add files to the config repository:

```
config add .vimrc
config commit -m "Add .vimrc"
config push
```

## Installing on a new machine

Add the alias as before

```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

and ignore the **~/.cfg** repository folder

```
echo ".cfg" >> .gitignore
```

Clone configuration into a bare repository

```
git clone --bare <git-repo-url> $HOME/.cfg
```

And checkout

```
config checkout
```

The checkout may fail if there are existing files, just rename them first.



# Shell


## ZSH

Install with:

```
sudo apt install zsh
```

change default shell:

```
chsh -s $(which zsh)
```

## OH-MY-ZSH

```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## SPACESHIP THEME

```
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```
Set ZSH_THEME="spaceship" in your .zshrc.



# VIM

## Plugins

### NERDTree

```
git clone https://github.com/preservim/nerdtree.git
~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
```

### Lightline

```
git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline
```

Keyboard Mapping

```
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
```



