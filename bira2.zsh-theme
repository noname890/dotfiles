COLOR=%{$terminfo[bold]$fg[green]%}
DIRLIST=2

git_prompt() {
 if [ -d .git ]; then
    local ref=$(git symbolic-ref HEAD | cut -d "/" -f3)' ';
    COLOR=%{$terminfo[bold]$fg[green]%}
    if [[ -n $(git diff --name-only --cached) ]]; then
        COLOR=%{$terminfo[bold]$fg[green]%}
        ref+='+'
    fi
    if [[ -n $(git diff --name-only) ]]; then
        COLOR=%{$terminfo[bold]$fg[yellow]%}
        ref+='?';
    fi;
    if [[ -n $(git ls-files --others --exclude-standard) ]]; then
        COLOR=%{$terminfo[bold]$fg[yellow]%}
        ref+='!'
    fi
    if [[ -n $(git ls-files --deleted) ]]; then
        COLOR=%{$terminfo[bold]$fg[red]%}
    fi
 fi;
 ref="$COLOR $ref"
 echo $ref
}

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m %{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n%{$reset_color%}'
    local user_symbol='$'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%} %${DIRLIST}~ %{$reset_color%}'
local git_branch='$(git_prompt)%{$reset_color%}'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="╭─${user_host}${current_dir}${rvm_ruby}${git_branch}${venv_prompt}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX
