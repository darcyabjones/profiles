#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)$(current_branch)%{$reset_color%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
} #$(work_in_progress)


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%} git:"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg_bold[blue]%} hg:"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[red]%}" # ✗
ZSH_THEME_HG_PROMPT_CLEAN="%{$fg[green]%}"


function _ssh_prompt_info {
  [[ -n $SSH_CONNECTION ]] && echo '%n@%M:'
}

function _virtualenv_prompt_info {
  if [[ -n $VIRTUAL_ENV ]]; then
    VENV=("${(s|/|)VIRTUAL_ENV}")
    echo "${ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX}${VENV[-2]}/${VENV[-1]}${ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX}"
  fi
}

function _git_prompt_info {
  [[ -n $(whence git_prompt_info) ]] && git_custom_status
}

function _hg_prompt_info {
  [[ -n $(whence hg_prompt_info) ]] && hg_prompt_info
}

function _rvm_prompt_info {
  [[ -n $(whence rvm_prompt_info) ]] && rvm_prompt_info
}

PYENV_PROMPT_DEFAULT_VERSION=${PYENV_PROMPT_DEFAULT_VERSION:="system"}

function _pyenv_prompt_info {
  [[ -n $(whence pyenv_prompt_info) ]] && \
  [[ "$(pyenv_prompt_info)" != "${PYENV_PROMPT_DEFAULT_VERSION}" ]] && \
  echo "${ZSH_THEME_PYENV_PROMPT_PREFIX}$(pyenv_prompt_info)${ZSH_THEME_PYENV_PROMPT_SUFFIX}"
}

ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%}%s)" #➜

# Combine it all into a final right-side prompt
RPS1='$(_git_prompt_info)$(_hg_prompt_info)$(_rvm_prompt_info)$(_virtualenv_prompt_info) $EPS1'
PROMPT='${ret_status}$(_ssh_prompt_info)%p%c % %{$reset_color%}'


ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg_bold[blue]%} python:%{$fg[green]%}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_PYENV_PROMPT_PREFIX="%{$fg_bold[blue]%} python:%{$fg[green]%}"
ZSH_THEME_PYENV_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_RVM_PROMPT_PREFIX="%{$fg_bold[blue]%} ruby:%{$fg[green]%}"
ZSH_THEME_RVM_PROMPT_SUFFIX="%{$reset_color%}"
