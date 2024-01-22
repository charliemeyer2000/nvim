# Charlie's Nvim Config

This is my neovim config. This uses `lazy.nvim` to manage packages. This README Is mostly used to track the useful commands that I have created/found for the specific plugins + also just generally useful motions as a whole.

## Packer

To use packer, just type `:Packer` or do `:PackerSync` to ensure that everything's good to go.

## File Tree Management

Because MacOs uses command for special commands, I use the control button. You can also go to system Settings > Keyboard to remap the caps lock button to control, which I do to make things a lot easier (plus who uses caps lock anyway!). With this, here is what I use (note that a lot of this is VSCode-like mappings):
- Control + P: Fuzzy File Finder
- Control + B: Toggle File Tree
- Control + G: Toggle Git status tree
- Control + W: Close current buffer (file)

## Searching

You can just use the default searcher for searching for stuff, but I also have <leader> (which ihave mapped to the spacebanr) + G to do a live grep of all the files in the current directory.

## Window Management

If you are using neovim's split views, you can tab through them using Control + W and then jk/hl to move through the panes. However, I use tmux to manage windows, which I just have rebound the default trigger to control + A, and then use the vim keymaps jk/hl to move between panes. 

## LSP/Autocomplete/IntelliSense

- shift + k over something to see it's definition
- gd over something to go to definition
- gD over something to go to declaration
- <leader>ca to get code actions

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


