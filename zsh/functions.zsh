function a {
    local sel xs cmd cmd2
    if [ -z "$1" ] ; then
        cmd="sk --ansi -i -c 'rg --color=always --line-number \"{}\"' --delimiter ':' --preview \"bat --plain --color=always {1} --highlight-line {2} | grep --color=always -e {cq} -e '$'\" --preview-window 25%"
    else
        cmd="rg --color=always --line-number $@ | sk --ansi --exact --delimiter ':' --preview \"bat --plain --color=always {1} --highlight-line {2} | grep --color=always -e \"$@\" -e '$'\" --preview-window 25%"
    fi
    eval $cmd | while read sel; do
        if [ ! -z "$sel" ] ; then
            xs=("${(@s/:/)sel}")  # splitt with `:`
            echo "$xs[1]"
            e "$xs[1]" && e --eval "(with-current-buffer (window-buffer (selected-window)) (goto-line $xs[2]))" > /dev/null
        fi
    done
}

alias ga > /dev/null && unalias ga
function ga {
    local sel
    if [ "0" -eq `git status -s | grep -v '^[AM]' | awk 'END{print NR}'` ] ; then
        echo 'No files to add.'
        return 0
    fi
    git status -s | grep -v '^[AM]' | sed -e 's/^ /./; s/^\(.\) /\1./;' | sk -m -e --delimiter=' ' --preview='git diff {2}' --preview-window 25% | cut -c 4- | while read sel; do
        echo "$sel"
        git add "$sel"
    done
}

alias gb > /dev/null && unalias gb
function gb {
    if [ ! -z "$1" ] ; then
        git checkout -q "$1" || git fetch && git checkout -q "$1"
    else
        local branch=$(git branch --color=never --no-merged master | grep -Ev 'remotes/origin/[0-9]+/head' | awk '{r=$0;t=substr($0,3)} /remotes\/origin\//{t=substr(t,16); r="R " t} {print t "#" r}' | sk --delimiter '#' --with-nth=2 | awk -F'#' '{print $1}')
        if [ ! -z "$branch" ] ; then
            echo $branch
            git checkout -q $branch
        fi
    fi
}

alias gcb > /dev/null && unalias gcb
function gcb {
    local key name branch
    key=$1
    shift 1
    name=$(echo "$@" | sed -Ee 's|([^ ])([A-Z])|\1-\2|g; s| +|-|g; y/ABCDEFGHIJKLMNOPQRSTUVWXYZ./abcdefghijklmnopqrstuvwxyz-/; s|--|-|g;')
    branch=${key}/${name}
    echo $branch
    git checkout -b $branch
}

alias ge > /dev/null && unalias ge
function ge {
    local sel
    if [ "0" -eq `git status -s | awk 'END{print NR}'` ] ; then
        echo 'No files to edit.'
        return 0
    fi
    git status -s | sed -e 's/^ /./; s/^\(.\) /\1./;' | sk -m -e --delimiter=' ' --preview='git diff {2}' --preview-window 40% | cut -c 4- | while read sel; do
        echo "$sel"
        e "$sel"
    done
}

alias gr > /dev/null && unalias gr
function gr {
    local sel
    if [ "0" -eq `git status -s | grep '^[AM]'  | awk 'END{print NR}'` ] ; then
        echo 'No files to add.'
        return 0
    fi
    git status -s | grep '^[AM]'  | sed -e 's/^ /./; s/^\(.\) /\1./;' | sk -m -e --delimiter=' ' --preview='git diff --staged {2}' --preview-window 40% | cut -c 4- | while read sel; do
        echo "$sel"
        git restore --staged "$sel"
    done
}

alias gt > /dev/null && unalias gt
function gt {
    local tag=$(git tag | sk )
    if [ ! -z "$tag" ] ; then
        echo $tag
        git checkout $tag
    fi
}

alias gw > /dev/null && unalias gw
function gw {
    local tag=$(git worktree list | sk --with-nth 1,3 | awk '{print $1}')
    if [ ! -z "$tag" ] ; then
        local workdir=`git rev-parse --show-prefix`
        cd "$tag/$workdir"
    fi
}

function cdd {
    local dir=$(fd --type d | sk --preview 'ls' --preview-window 25%)
    if [ ! -z "$dir" ] ; then
        echo $dir
        cd "$dir"
    fi
}

function ff {
    local cmd file
    if [ -z "$1" ] ; then
        cmd="sk --preview 'bat --plain --color=always {1}' --preview-window 25%"
    else
        cmd="find . -type f \! -iwholename '*/.git/*' -and -name \*$1\* | cut -c 3- | sk --preview 'bat --plain --color=always {1}' --preview-window 25%"
    fi
    eval $cmd | while read file; do
        if [ ! -z "$file" ] ; then
            echo "$file"
            e "$file"
        fi
    done
}

function d {
    case "$1" in
        i)  shift 1
            docker image "$@"
           ;;
        h)  shift 1
            docker history --no-trunc --format "{{json .}}" "$@"
           ;;
        *) docker "$@"
    esac

}
