
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

/opt/homebrew/etc/profile.d/z.sh

plugins=(git)

alias ts="tmux ls"
alias tdb="tmux attach -t doctariBackend"
alias tdf="tmux attach -t doctariFrontend"

alias jv="jira issue list -a 'Daniel Gruescu' -s 'In Progress'"

alias qDev="gh workflow run quickDev.yml -r $(git branch --show-current)"

source $ZSH/oh-my-zsh.sh
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"

export JIRA_API_TOKE=ATATT3xFfGF0DCqVe7N3TkSb7cZjboRDRo1jdBPqYJEQBppm15GT2ZikMJ66GWSYYpGSjME9y4pR4a02CwNFanYHmIegdQmX0kwMxIMx2FolPSbH7NyhYeY-IuhdUTUePIRQhTtffvhViTEnZ2e_4OI9KMLW0ptTOcBRHfRmdqCmKWdfqSYb8S4=BD5B9E31
export ACCESS_TOKEN_READ_GITHUB_PACKAGES=ghp_DMJA0e5X4MDUvWqdXOF9Ggj9bpSsFi038td

export DEV_TOKEN=eyJ0eXAiOiJKV1QiLCJraWQiOiJpbnRlZ3JhdGlvbi10ZXN0LWRvd25zdHJlYW0tYXV0aC9kZGRjNWM4YWM3ZDIzMzU2IiwiYWxnIjoiRVMyNTYifQ.eyJjdXN0b21lcl9pZCI6MSwic2NvcGUiOiJzZWxmIiwibmFtZSI6IkRyLiBKYW5lIERvZSIsImVtYWlsIjoiamFuZS5kb2VAaG9zcGl0YWwuZXhhbXBsZS5jb20iLCJsb2NhbGUiOiJkZV9ERSIsImNvbW1lbnQiOiJPTkxZIEZPUiBURVNUSU5HIFBVUlBPU0VTISIsImlzX2FkbWluIjp0cnVlLCJzdWIiOiJkNTIyMTEyYi05NjIwLTQzN2EtYTNkYi01MWEzNzE3NGRjN2UiLCJhdWQiOiJsb2NhbC1kZXYvdGVzdGluZyIsImlhdCI6MTY2NTc1NjcwNCwiZXhwIjoxOTgxMzMyNzA0fQ.Ir6bctQuEkXZyUthBwMe6lS2CJ9dIRIr5kOSm3kcEkIWPmYUNNixGp8hIhJ4UjXChjI3Y95dqy0DlYL9R7SwTA
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
