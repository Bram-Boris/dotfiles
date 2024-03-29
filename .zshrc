## Options section
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

## Alias section
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias ls="ls --color=auto"
## Search file contents, respects .gitignore
alias grop="ag --nobreak --nonumbers --noheading . | fzf"
alias cpu="watch -n.5 'cat /proc/cpuinfo | grep \"^[c]pu MHz\"'"

## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use autosuggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
#By default, there is a 0.4 second delay after you hit the <ESC> key and when the mode change is registered.
#This results in a very jarring and frustrating transition between modes. Let's reduce this delay to 0.1 seconds.
export KEYTIMEOUT=1
# FZF
## Keybindings and completion
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
## Enable fd as the base find command, faster and respects .gitignore, --type f set the search mode to only files
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Theme
source ~/.config/zsh/themes/minimal.zsh

bindkey "^[[24~" clear-screen

export QT_QPA_PLATFORMTHEME=qt5ct
export EDITOR=nvim
export VISUAL=nvim
# Add composer(php) bin folder to the path
export PATH=~/.config/composer/vendor/bin:$PATH
# Add my bin folder to the path
export PATH=~/bin:$PATH
