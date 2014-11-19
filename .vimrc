" Default configuration file for Vim
" Written by Aron Griffis <agriffis@gentoo.org>
" Modified by Ryan Phillips <rphillips@gentoo.org>
" Added Redhat's vimrc info by Seemant Kulleen <seemant@gentoo.org>

" The following are some sensible defaults for Vim for most users.
" We attempt to change as little as possible from Vim's defaults,
" deviating only where it makes sense
set number
set nocompatible        " Use Vim defaults (much better!)
set bs=2                " Allow backspacing over everything in insert mode
set ai                  " Always set auto-indenting on
set smartindent
set cindent
"set backup             " Keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file -- limit to only 50
set history=50          " keep 50 lines of command history
set ruler               " Show the cursor position all the time
set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
" Added to default to high security within Gentoo. Fixes bug #14088
set modelines=0
set background=dark
set ts=4
set guifont=Menlo\ Regular:h12
" set number
set splitright
set mouse=a

if v:lang =~ "^ko"
   set fileencodings=euc-kr
   set guifontset=-*-*-medium-r-normal--16-*-*-*-*-*-*-*
elseif v:lang =~ "^ja_JP"
   set fileencodings=euc-jp
   set guifontset=-misc-fixed-medium-r-normal--14-*-*-*-*-*-*-*
elseif v:lang =~ "^zh_TW"
   set fileencodings=big5
   set guifontset=-sony-fixed-medium-r-normal--16-150-75-75-c-80-iso8859-1,-taipei-fixed-medium-r-normal--16-150-75-75-c-160-big5-0
elseif v:lang =~ "^zh_CN"
   set fileencodings=gb2312
   set guifontset=*-r-*
endif
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif


" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" awitch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
  set hlsearch
  

if &term=="xterm"
	set t_RV=          " don't check terminal version
	set t_Co=8
	set t_Sb=^[4%dm
	set t_Sf=^[3%dm
endif

if has("autocmd")

" Gentoo-specific settings for ebuilds.  These are the federally-mandated
" required tab settings.  See the following for more information:
" http://www.gentoo.org/doc/en/xml/gentoo-howto.xml
augroup gentoo
    au!
    au BufRead,BufNewFile *.e{build,class} let is_bash=1|set ft=sh
	au BufRead,BufNewFile *.e{build,class} set ts=4 sw=4 noexpandtab
augroup END
autocmd BufWritePost    *.php   !php -l <afile>

endif " has("autocmd")

if has("python")
" let python figure out the path to pydoc
python << EOF
import sys
import vim
vim.command("let g:pydoc_path=\'" + sys.prefix + "/lib/pydoc.py\'")
EOF
else
	" manually set the path to pydoc
	let g:pydoc_path = "/path/to/python/lib/pydoc.py"
endif

command! -nargs=1 Pyhelp :call ShowPydoc(<f-args>)
function! ShowPydoc(module)
	" compose a tempfile path using the module name
	let path = $TEMP . '/' . a:module . '.pydoc'
" run pydoc on the module, and redirect the output to the tempfile
	call system(shellescape(g:pydoc_path . " " . a:module . " > " . path))
	" open the tempfile in the preview window
	execute ":pedit " . path
endfunction


"let spell_root_menu   = '-' 
"let spell_auto_type   = ''
"let spell_insert_mode = 0
"noremap <F8> :so `vimspell.sh %`<CR><CR>
"noremap <F7> :syntax clear SpellErrors<CR>

 let g:DoxygenToolkit_briefTag_pre="  "
 let g:DoxygenToolkit_paramTag_pre="@param "
 let g:DoxygenToolkit_returnTag="@return   "
 let g:DoxygenToolkit_blockHeader=""
 let g:DoxygenToolkit_blockFooter=""
 let g:DoxygenToolkit_authorName="Kofi Osei"
" let g:DoxygenToolkit_licenseTag="My own license\<enter>"   <-- Do not forget
 "ending "\<enter>"
 "helptags '/Users/kofi/.vim/doc/'
 "php Vim Documentation
 autocmd BufNewFile,Bufread *.php,*.php3,*.php4 set keywordprg="help"
 set runtimepath+="$HOME/.vim/"
 set incsearch
syntax on

autocmd BufEnter * silent! lcd %:p:h
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
colorscheme wombat

highlight LineNr ctermbg=DarkGrey
