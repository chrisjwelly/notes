Shell-related notes

# Zsh

## Customising iterm2 with Zsh
I watched this [video](https://youtu.be/pTW02GMeI74) to help configure my iterm2 in Macbook Pro. However, the video is a little outdated and it will talk about PowerLevel9k. The links that it gave will reference PowerLevel10k.

I also had to install some more fonts, but during the Oh My Zsh configuration they will prompt you whether you have the necessary icons and will adapt accordingly.

## Zsh environment variables
While setting up ReactNative environment, they mention adding environment variables to the bash shell.
`~/.bash_profile` equivalent in Zsh is `~/.zshenv` ([reference](https://stackoverflow.com/questions/23090390/is-there-anything-in-zsh-like-bash-profile))
`~/.bashrc` equivalent in Zsh is `~/.zshrc` (this one is by experience as many tutorials would talk about updating zshrc)

### Adding new entry to the PATH variable in ZSH
Refer to this [Stack Overflow post](https://stackoverflow.com/questions/11530090/adding-a-new-entry-to-the-path-variable-in-zsh).

For example, I added these to `~/.zshrc` for React Native set up for Android Development:
```
# Configure ANDROID_HOME environment variable for React Native
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
```
Do a restart of the terminal (because I read that we are not supposed to call `source` on it). Then ensure that everything is good by calling `echo $PATH`.

The Stack Overflow post also seems to talk about better alternatives for Zsh and no reason to use the standard export notation. I chose to use those because I am lazy (oops) and I suppose for simplicity.
