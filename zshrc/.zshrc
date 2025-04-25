export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"\

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k



# Add in zsh plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Add in snippets
zinit snippet OMZP::sudo
# zinit snippet OMZP::gitfast
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

# Keybindings
bindkey '^f' autosuggest-accept
bindkey '^[OA' history-search-backward
bindkey '^[OB' history-search-forward
bindkey '^[v' .describe-key-briefly

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias c='clear'
alias gpush='git push origin '
alias gf='git fetch upstream uat'
alias gr='git rebase upstream/uat'
alias g='git'
alias seto='git branch --set-upstream-to=origin/tests tests'
alias setu='git branch --set-upstream-to=upstream/uat tests'
alias ti="nvm use 18 && pushd ~/projects/tianxia"
alias bf="bazel run format"
alias port="sudo lsof -i"
alias killport="sudo kill -9"
alias neo='cd ~/.config/nvim'
alias n='nvim'

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.json)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Setting up NVM
export NVM_DIR="$XDG_CONFIG_HOME"/nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Lazy loading NVM
# function nvm() {
#   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#   nvm "$@"
# }
# Ensure NVM is loaded before using it
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Run these commands only in interactive shells (to prevent issues in scripts)
if [[ $- == *i* ]]; then
  # Use Node.js 18 without printing output
  nvm use 18 > /dev/null

  # Change directory silently
  cd ~/projects/tianxia
fi

# Define test targets
declare -A BAZEL_TARGETS
BAZEL_TARGETS[dungeon]="//apps/dungeon/ui/e2e:e2e"
BAZEL_TARGETS[livestream]="//apps/livestream/ui/e2e:e2e"
BAZEL_TARGETS[backdrop]="//apps/backdrop-showcase/e2e:e2e"

# Define test arguments specific to each target
declare -A DUNGEON_TEST_ARGS
DUNGEON_TEST_ARGS[repeat]="--test_arg=--repeat-each=5"
DUNGEON_TEST_ARGS[navigation-bar]='--test_arg="e2e/specs/navigation-bar.spec.js"'
DUNGEON_TEST_ARGS[installment-page]='--test_arg="e2e/specs/installment-page.spec.js"'
DUNGEON_TEST_ARGS[home-page]='--test_arg="e2e/specs/home-page.spec.js"'
DUNGEON_TEST_ARGS[asset-page]='--test_arg="e2e/specs/asset-page.spec.js"'

declare -A LIVESTREAM_TEST_ARGS
LIVESTREAM_TEST_ARGS[repeat]="--test_arg=--repeat-each=5"
LIVESTREAM_TEST_ARGS[advanced-filters]='--test_arg="e2e/specs/advanced-filters.spec.js"'
LIVESTREAM_TEST_ARGS[home-page]='--test_arg="e2e/specs/home-page.spec.js"'
LIVESTREAM_TEST_ARGS[modal-form]='--test_arg="e2e/specs/modal-form.spec.js"'
LIVESTREAM_TEST_ARGS[opening-data-stream]='--test_arg="e2e/specs/opening-data-stream.spec.js"'
LIVESTREAM_TEST_ARGS[stream-filters]='--test_arg="e2e/specs/stream-filters.spec.js"'
LIVESTREAM_TEST_ARGS[tooltip]='--test_arg="e2e/specs/tooltip.spec.js"'
LIVESTREAM_TEST_ARGS[user-tutorial]='--test_arg="e2e/specs/user-tutorial.spec.js"'


declare -A BACKDROP_TEST_ARGS
BACKDROP_TEST_ARGS[repeat]="--test_arg=--repeat-each=5"
BACKDROP_TEST_ARGS[examples-page]='--test_arg="e2e/specs/examples-page.spec.js"'
BACKDROP_TEST_ARGS[navigation-bar]='--test_arg="e2e/specs/navigation-bar.spec.js"'
BACKDROP_TEST_ARGS[showcases]='--test_arg="e2e/specs/showcases.spec.js"'
BACKDROP_TEST_ARGS[examples]='--test_arg="e2e/specs/examples.spec.js"'

# Function to run bazel test with multiple arguments
bazeltest() {
  local target_key="$1"
  shift  # Remove the first argument so $@ contains only test arguments

  # Check if target is provided
  if [[ -z "$target_key" ]]; then
    echo "Usage: bazeltest <dungeon|livestream|backdrop> [arg1 arg2 ...]"
    return 1
  fi

  # Get the target path
  local target="${BAZEL_TARGETS[$target_key]}"
  if [[ -z "$target" ]]; then
    echo "Error: Unknown target '$target_key'. Available targets: ${!BAZEL_TARGETS[@]}"
    return 1
  fi

  # Initialize an array to hold the final test arguments
  local final_args=()

  # Loop through the provided arguments (like 'repeat', 'navigation-bar', etc.)
for arg in "$@"; do
  if [[ "$target_key" == "dungeon" && -n "${DUNGEON_TEST_ARGS[$arg]}" ]]; then
    final_args+=("${DUNGEON_TEST_ARGS[$arg]}")
  elif [[ "$target_key" == "livestream" && -n "${LIVESTREAM_TEST_ARGS[$arg]}" ]]; then
    final_args+=("${LIVESTREAM_TEST_ARGS[$arg]}")
  elif [[ "$target_key" == "backdrop" && -n "${BACKDROP_TEST_ARGS[$arg]}" ]]; then
    final_args+=("${BACKDROP_TEST_ARGS[$arg]}")
  else
    echo "Error: Unknown test argument '$arg' for target '$target_key'."
    return 1
  fi
done

  # If no valid arguments were provided, warn the user
  if [[ ${#final_args[@]} -eq 0 ]]; then
    echo "No test arguments provided for target '$target_key'."
    return 1
  fi

  # Construct the bazel test command
  command="bazel test $target --cache_test_results=no --test_output=all ${final_args[@]}"

  # Print the constructed command for debugging purposes
  echo "Running command: $command"

  # Run the command
  eval "$command"
}

# Unbind Ctrl-L, Ctrl-K, Ctrl-I (Tab), and Ctrl-J (Newline)
bindkey -r '^L'           # Clear screen
bindkey -r '^K'           # Kill buffer
bindkey -r '^I'           # Self-insert (Tab key)
bindkey -r '^J'           # Self-insert (newline)
bindkey -r '^[^I'         # Escape + Ctrl-I
bindkey -r '^[^J'         # Escape + Ctrl-J
bindkey -r '^[^L'         # Escape + Ctrl-L
bindkey -r '^X^J'         # vi-join
bindkey -r '^X^K'         # kill-buffer
