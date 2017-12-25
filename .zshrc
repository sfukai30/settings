#ws いろんな設定
export PATH=$PATH:/opt/local/bin:
export PATH=/usr/local:$PATH
export EDITOR=vim
bindkey -v  # vim keybind
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export TERM=xterm-256color
export PGDATA=/usr/local/var/postgres

# set alias
alias redis_start="redis-server /usr/local/etc/redis.conf"
alias postgres_start="pg_ctl -D /usr/local/var/postgres -l /tmp/postgres_log start"
alias postgres_stop="pg_ctl -D /usr/local/var/postgres stop"
alias mysql_start="sudo mysql.server start"
alias mysql_stop="sudo mysql.server stop"
alias bundle="nocorrect bundle"
alias zmv='noglob zmv -W'

# ビープ音を鳴らさないようにする
setopt no_beep
setopt nolistbeep

# 補完系設定
autoload -U compinit; compinit                  # 補完機能を有効にする
autoload -Uz zmv
setopt list_packed                              # 補完候補リストを詰めて表示
setopt list_types                               # auto_listの補完候補一覧でファイルの種別をマーク表示
setopt auto_list                                # 保管候補が複数あるときに，一覧表示する
setopt magic_equal_subst                        # =以降の補完
setopt auto_param_keys                          # カッコ対応も自動補完
setopt auto_param_slash                         # ディレクトリ名の保管で末尾の / を自動的に付加
setopt auto_menu                                # 補完キーを押すと順に保管する
setopt print_eight_bit                          # 日本語も正しく表示
setopt complete_aliases                         # alias も補完対象にする
setopt hist_no_store                            # history コマンドは追加しない
setopt always_to_end                            # 保管したら文字列末尾へ移動

# その他便利機能
setopt brace_ccl                # {a-c} を a b cに展開する
setopt auto_cd                  # ディレクトリ名でcdする
setopt pushd_ignore_dups        # ディレクトリスタックに同じディレクトリを追加しないようにする
setopt correct                  # コマンドのスペルチェック
setopt correct_all              # コマンドライン全てのスペルチェック
setopt no_clobber               # 上書きリダイレクトの禁止
setopt path_dirs                # コマンド名に / が含まれている時PATH中のサブディレクトリを探す

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history        # 履歴を共有する
#setopt inc_append_history
setopt hist_ignore_dups     # 直前と同じコマンドは履歴に追加しない
setopt hist_reduce_blanks   # 余分な空白は詰める
setopt hist_ignore_space    # 先頭が空白だったならば履歴に追加しな
setopt hist_verify          # 履歴を呼び出してからも編集可能
setopt extended_history     # 実行時刻，実行時間も履歴に残す

# 色設定
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# プロンプトの設定
autoload colors
colors

case ${UID} in
0)
    PROMPT="%{${fg[red]}%}%n@%m%#%{${reset_color}%} "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    RPROMPT="%{${fg[green]}%}[%~:%T]%{${reset_color}%}"
    ;;
*)
    PROMPT="%{${fg[magenta]}%}[%n]%{${reset_color}%}%{${fg[yellow]}%}[%/]%%%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    RPROMPT="%{${fg[green]}%}[%T]%{${reset_color}%}"
#RPROMPT="%1(v|%F{green}%1v%f|)"
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac
source /sw/bin/init.sh

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


