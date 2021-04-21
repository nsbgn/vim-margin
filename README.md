vim-margin
===============================================================================

A small plugin to **center** your Vim windows if their width exceeds the 
`&textwidth`. This plugin is similar to the excellent 
[Goyo](https://github.com/junegunn/goyo.vim), but it is much simpler and it is 
intended to be enabled by default --- not just in situations where you want to 
remove *all* distractions.

This plugin is good enough to solve my **personal use case**: comfortable 
writing on a widescreen monitor in fullscreen, while being unobtrusive 
otherwise. Although the basics work, it will likely exhibit strange behaviour 
in others' workflows. Pull requests are welcome!

Add it to your `~/.vimrc` using, for example, 
[vim-plug](https://github.com/junegunn/vim-plug):

    Plug 'https://github.com/slakkenhuis/vim-margin'

If you use this plugin, you will likely want to have more subtle dividers 
between splits:

    highlight VertSplit cterm=NONE ctermfg=gray

... or hide them completely:

    highlight VertSplit cterm=NONE
    set fillchars+=vert:\ 


Usage
-------------------------------------------------------------------------------

After installation, the margin will be active by default. If this is not 
desired, add the following to your `.vimrc` after loading the plugin:

    let g:margin_enabled=1

To toggle the margins:

    :Margin


Related
-------------------------------------------------------------------------------

-   [Goyo](https://github.com/junegunn/goyo.vim)
-   [vim-venter](https://github.com/JMcKiern/vim-venter)
-   [vim-leftmargin](https://github.com/jpaulogg/vim-leftmargin)
-   [vim-mutton](https://github.com/gabenespoli/vim-mutton)
-   [How-to](https://stackoverflow.com/questions/12952479/how-to-center-horizontally-the-contents-of-the-open-file-in-vim)
