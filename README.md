# Charlie's Nvim Config

This is my neovim config. This uses `lazy.nvim` to manage packages. This README is mostly used to track the useful commands that I have created/found for the specific plugins + also just generally useful motions as a whole.

**For those in UVA CS**: You can add this on the CS portal as well. Add to your `.bashrc`:

```
# ... existing bashrc - add just loading tmux and neovim!

case "$-" in
*i*) module load git; module load tmux; module load neovim; module load nano; module load clang-llvm-14.0.6;;
*)  ;;
esac

# ... 
```
This loads `neovim` and `tmux` modules so you can use them. Then, just create your `.config` directory, and place this folder in there (thus it will be at `.config/nvim`), which is where neovim looks for its configuration. 

You can also style your terminal through adding themes in your `.bashrc` as well if you want :) but that's not relevant to this repo.

## Lazy.nvim 

To use lazy.nvim, just type `:Lazy` to ensure that everything's good to go.

## File Tree Management

Because MacOs uses command for special commands, I use the control button. You can also go to system Settings > Keyboard to remap the caps lock button to control, which I do to make things a lot easier (plus who uses caps lock anyway!). With this, here is what I use (note that a lot of this is VSCode-like mappings):
- Control + p: Fuzzy File Finder
- Control + b: Toggle File Tree
- Control + g: Toggle Git status tree
- Control + w: Close current buffer (file)
- Control + o: open most recently closed buffer

## Searching

You can just use the default searcher for searching for stuff, but I also have <leader> (which i have mapped to the spacebanr) + g to do a live grep of all the files in the current directory.

## Window Management

If you are using neovim's split views, you can tab through them using Control + W and then jk/hl to move through the panes. However, I use tmux to manage windows, which I just have rebound the default trigger to control + A, and then use the vim keymaps jk/hl to move between panes. 

With that being said, this is my entire tmux.conf file (place this at `~/.tmux.conf`):

```
set -g prefix C-a

unbind-key C-b
unbind-key C-a

bind-key - split-window -c "#pane_current_path"
bind-key v split-window -h -c "#pane_current_path"
bind-key c new-window -c "#pane_current_path"

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

I also have this quick script that runs that i put at the top of my `.zshrc` (or `.bashrc`, if you use bash) file so that i don't really have to worry about sessions & panes and stuff with tmux. All it does is if a session exists, kill it, and start a new one and attach to it. This makes it easier to not have to worry about session management, so you don't end up with just a ton of sessions.

```
# Run tmux commands only if not already in a tmux session
if [[ -z "$TMUX" ]]; then
    # Create a new session named '0' if it doesn't exist
    tmux has-session -t 0 || tmux new-session -d -s 0

    # Attach to the '0' session
    tmux attach-session -t 0

    # Set the 'destroy-unattached' option for the '0' session
    tmux set-option -t 0 destroy-unattached
fi
```
## LSP/Autocomplete/IntelliSense

- shift + k over something to see it's definition
- gd over something to go to definition
- gD over something to go to declaration
- <leader>ca to get code actions
- <leader>f to format code according to LSP's code style

## Surrounding Stuff

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

Also while in visual mode, just do S +  bracket/ parenthesis to surround stuff.

## Terminal

Use cmd + t to toggle the terminal. It is the vim terminal so it takes a sec to boot up. if you need more terminals, you should be using tmux to manage multiple terminals to run stuff.
