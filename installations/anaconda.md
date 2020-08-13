Refer to: https://medium.com/ayuth/install-anaconda-on-macos-with-homebrew-c94437d63a37

In MacOS (with ZSH):
1. Use homebrew to install anaconda:
```bash
brew cask install anaconda
```

2. At this point, `jupyter notebook` shouldn't run.

3. Go to `~/.zshrc` and add this line:
```bash
export PATH="/usr/local/anaconda3/bun:$PATH"
```

4. Restart the terminal and run `jupyter notebook` again.
