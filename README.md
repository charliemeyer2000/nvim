# Charlie's Nvim Config

This is my neovim config. This uses `lazy.nvim` to manage packages. This README Is mostly used to track the useful commands that I have created/found for the specific plugins + also just generally useful motions as a whole.

## Lazy.nvim 

To use lazy.nvim, just type `:Lazy`to ensure that everything's good to go.

## File Tree Management

Because MacOs uses command for special commands, I use the control button. You can also go to system Settings > Keyboard to remap the caps lock button to control, which I do to make things a lot easier (plus who uses caps lock anyway!). With this, here is what I use (note that a lot of this is VSCode-like mappings):
- Control + P: Fuzzy File Finder
- Control + B: Toggle File Tree
- Control + G: Toggle Git status tree
- Control + W: Close current buffer (file)

## Searching

You can just use the default searcher for searching for stuff, but I also have <leader> (which i have mapped to the spacebanr) + g to do a live grep of all the files in the current directory.

## Window Management

If you are using neovim's split views, you can tab through them using Control + W and then jk/hl to move through the panes. However, I use tmux to manage windows, which I just have rebound the default trigger to control + A, and then use the vim keymaps jk/hl to move between panes. 

With that being said, this is my entire tmux.conf file:

```.conf
set -g prefix C-a

unbind-key C-b
unbind-key C-a

bind-key - split-window -c "#{pane_current_path}"
bind-key v split-window -h -c "#{pane_current_path}"
bind-key c new-window -c "#{pane_current_path}"

set-window-option -g mode-keys vi

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R


set -g mouse on

# stop prompting for closing pane
unbind x
bind x kill-pane

# drag and drop windows
bind-key -n MouseDrag1Status swap-window -d -t=
```

## LSP/Autocomplete/IntelliSense

- shift + k over something to see it's definition
- gd over something to go to definition
- gD over something to go to declaration
- <leader>ca to get code actions
- <leader>f to format code according to LSP's code style

## Surrounding Shit

here is a basic table for surrounding shit in normal mode thru nvim-surround:

    Old text                    Command         New text
-----------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls

Also while in visual mode, just do S +  bracket/ parenthesis to surround shit.

## Terminal

Use cmd + t to toggle the terminal. It is the vim terminal so it takes a sec to boot up. 
