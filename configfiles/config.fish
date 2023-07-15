if status is-interactive
    # Commands to run in interactive sessions can go here
end

if command -q sk
    skim_key_bindings
end

set fish_greeting

export EDITOR='nvim';
alias :q 'exit';
alias q 'exit';
alias vim 'nvim';
alias emacs 'emacsclient -nw -c -a ""';
alias ls 'exa --icons --group-directories-first';
alias ll 'exa -alF --icons --group-directories-first';
alias b 'bluetoothctl';

set -U fish_user_paths $fish_user_paths $HOME/.local/bin;
set -U fish_user_paths $fish_user_paths $HOME/.config/emacs/bin/;

export MANPAGER="bat -p"
export PAGER="bat"

set -U fish_escape_delay_ms 300
