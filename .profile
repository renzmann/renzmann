export HISTFILESIZE=100000
export HISTSIZE=100000
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

[ -z $GOPATH ] && export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

[ -d "$HOME/.cargo" ] && . "$HOME/.cargo/env"

if [ -d "$HOME/.coursier" ]; then
    export PATH="$HOME/.coursier:$PATH"
    export PATH="$HOME/.local/share/coursier/bin:$PATH"
fi

[ -d "$HOME/Applications/kitty.app" ] && export PATH="$PATH:$HOME/Applications/kitty.app/Contents/MacOS/"
[ -d "$HOME/Applications/Emacs.app" ] && export PATH="$PATH:$HOME/Applications/Emacs.app/Contents/MacOS/bin"
[ -d "$HOME/Applications/CMake.app" ] && export PATH="$PATH:$HOME/Applications/CMake.app/Contents/bin"
[ -d "$HOME/Library/Application Support/Coursier" ] && export PATH=$PATH:"$HOME/Library/Application Support/Coursier/bin"
[ -d "$HOME/.jabba" ] && source "$HOME/.jabba/jabba.sh"
[ -d "$HOME/.emacs.d/bin" ] && export PATH="$PATH:$HOME/.emacs.d/bin"

if [[ "$OSTYPE" =~ darwin ]]; then
    for x in $(echo "$HOME/Library/Python/*/bin"); do
        export PATH="${PATH}:${x}"
    done
fi

case $- in
    *i*)
        # Interactive session. Try switching to bash.
        if [ -z "$BASH" ]; then
            bash=$(command -v bash)
            if [ -x "$bash" ]; then
                export SHELL="$bash"
                exec "$bash"
            fi
        fi
esac

case "$TERM" in
    dumb|emacs*|eterm*)
        # M-x shell from emacs can't handle interactive output
        alias m='cat'
        alias less='cat'
        alias more='cat'
        export PAGER=cat
        command -v emacsclient &>/dev/null && export EDITOR=ec || export EDITOR=vi
        ;;
    *)
        alias m='more'
        alias l='less'
        command -v emacsclient &>/dev/null && export EDITOR=ec || export EDITOR=vi
        ;;
esac

[ -d "/usr/local/opt/llvm@12/" ] && export LLVM_SYS_120_PREFIX="/usr/local/opt/llvm@12"

urlencode() {
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}

urldecode() {
    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

enable-proxy(){
    echo -n "Proxy host: "
    read proxyhost
    echo -n "Proxy port: "
    read proxyport
    echo -n "Proxy user ID: "
    read myuser
    echo -n "Enter your password: "
    read -s mypass
    export HTTP_PROXY='http://'$myuser':'$(urlencode ${mypass})'@'$proxyhost':'$proxyport'/'
    export HTTPS_PROXY="$HTTP_PROXY"
    export http_proxy="$HTTP_PROXY"
    export https_proxy="$HTTPS_PROXY"
}

disable-proxy(){
    unset HTTP_PROXY
    unset http_proxy
    unset HTTPS_PROXY
    unset https_proxy
}

# For info files
export INFOPATH="/usr/local/share/info:/usr/share/info/emacs:/usr/share/info"

# .bash_functions/bash-profile.sh sets the correct VIRTUAL_ENV position
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Machine-specific sources
[ -r $HOME/.locals ] && . "$HOME/.locals"
