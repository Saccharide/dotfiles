# Set prefix key to Ctrl-a
unbind-key C-b
set-option -g prefix C-a

# send the prefix to client inside window
bind-key C-a send-prefix

# toggle last window like screen
bind-key C-a last-window

# open a man page in new window
bind-key / command-prompt "split-window 'exec man %%'"

# quick view of processes
#bind-key "~" split-window "exec htop"

# scrollback buffer n lines
set -g history-limit 5000

# listen for activity on all windows
set -g bell-action any
#set -g bell-action none

# start window indexing at zero (default)
set -g base-index 0

# instructs tmux to expect UTF-8 sequences
#setw -g utf8 on

# tell tmux to use 256 colour terminal
set -g default-terminal "screen-256color"

# xterm-style function key sequences
setw -g xterm-keys on

# control automatic window renaming
setw -g automatic-rename off
set-option -g allow-rename off

# enable wm window titles
set -g set-titles on

# wm window title string (uses statusbar variables)
#set -g set-titles-string "tmux.#I.#W"

# don't close windows. just deactivate them. use respawn-window to reactivate.
#setw -g remain-on-exit on


# Key bindings

# reload settings
bind-key R source-file ~/.tmux.conf

# detach client
bind-key d detach
bind-key C-d detach

# choose a client to detach
bind-key D choose-client

# choose window/session
bind-key "'" choose-window
bind-key '"' choose-session

# display visible indicator of each pane
bind-key w display-panes

# navigate panes using jk, and ctrl+jk (no prefix)
bind-key -r j select-pane -t :.-
bind-key -r k select-pane -t :.+
bind-key -r C-j select-pane -t :.-
bind-key -r C-k select-pane -t :.+

# navigate windows using hl, and ctrl-hl (no prefix)
bind-key -r h select-window -t :-
bind-key -r l select-window -t :+
bind-key -r C-h select-window -t :-
bind-key -r C-l select-window -t :+

# swap panes
bind-key -r J swap-pane -D
bind-key -r K swap-pane -U

# Ctrl-Left/Right cycles thru windows (no prefix)
bind-key -n "C-Left"  select-window -t :-
bind-key -n "C-Right" select-window -t :+

# Ctrl-Up/Down cyles thru panes (no prefix)
bind-key -n "C-Up"   select-pane -t :.-
bind-key -n "C-Down" select-pane -t :.+

# Cycle to next pane
bind-key -r Tab select-pane -t :.+

# kill current pane/window
bind-key q confirm-before kill-pane
bind-key Q confirm-before kill-window
bind-key C-q confirm-before kill-pane
#bind-key x kill-pane
#bind-key X kill-window

# window layouts (emacs-like)
#bind-key 1 break-pane
#bind-key 2 select-layout even-vertical
#bind-key 3 select-layout even-horizontal
#bind-key o select-pane -U

# specific window layouts
#bind -r y next-layout
#bind o select-layout "active-only"
#bind O select-layout "main-vertical"

# copying and pasting
bind-key [ copy-mode
bind-key ] paste-buffer -s \015

# vi-style controls for copy mode
setw -g mode-keys vi

# enable mouse selection in copy mode
#setw -g mode-mouse on

# list all paste buffers (default key is '#')
bind-key b list-buffers

# choose buffer to paste interactively (default key was '=')
bind-key p choose-buffer

# delete the most recently copied buffer of text (default key was '-')
bind-key x delete-buffer


# Screen-like key bindings

# new window
bind-key C-c new-window -c "#{pane_current_path}"
bind-key c new-window -c "#{pane_current_path}"

# next
bind-key -r Space next-window
bind-key -r "C-Space" next-window

# prev
bind-key BSpace previous-window

# title (default key in tmux is ',')
bind-key A command-prompt "rename-window %%"

# quit
#bind-key \ confirm-before kill-server

# displays
bind-key * list-clients

# redisplay (default key in tmux is 'r')
#bind-key C-l refresh-client
#bind-key l refresh-client
bind-key r refresh-client


# Split windows like vim

# vim's definition of a horizontal/vertical split is reversed from tmux's
#bind-key s split-window -v
#bind-key v split-window -h

# alternatively, use better mnemonics for horizontal/vertical splits
bind-key - split-window -v -c "#{pane_current_path}"
bind-key _ split-window -v -c "#{pane_current_path}"
bind-key | split-window -h -c "#{pane_current_path}"

# resize panes like vim
bind-key -r < resize-pane -L 3
bind-key -r > resize-pane -R 3
bind-key -r + resize-pane -U 1
bind-key -r = resize-pane -D 1


# Statusbar settings

# toggle statusbar
bind-key s set status

# use vi-style key bindings in the status line
set -g status-keys vi

# amount of time for which status line messages and other indicators
# are displayed. time is in milliseconds.
set -g display-time 2000

# default statusbar colors
set -g status-fg white
set -g status-bg default
#set -g status-attr default

# default window title colors
#setw -g window-status-fg white
#setw -g window-status-bg default
#setw -g window-status-attr dim

# active window title colors
#setw -g window-status-current-fg cyan
#setw -g window-status-current-bg default
#setw -g window-status-current-attr bright
#setw -g window-status-current-attr underscore

# command/message line colors
#set -g message-fg white
#set -g message-bg black
#set -g message-attr bright


# Session initialization

# Note:
#   new  - alias for new-session
#   neww - alias for new-window

# first session
#new -d -s0
#neww -d
#neww -d
#neww -d

# second session
#new -d -s1
#neww -d
#neww -d

#select-window -t1

# -----------------------------------------------------------------------------
# vim: fen fdl=0 fdm=marker
"'"'"
