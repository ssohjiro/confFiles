execute pathogen#infect()
syntax on
filetype plugin indent on
set number
set ts=4
set shiftwidth=4
set background=dark
set backup
set showmatch
set ai
"set smartindent
set hls
set backspace=indent,eol,start
set relativenumber

set formatoptions-=cro

syntax on

map , :
map :W :w

map ,f :mkview
map ,l :loadview
map ,e :e./
map ,b :b#
map ㅓ j
map ㅏ k
map ㅗ h
map ㅣ l
map ㅑ i
map ㅈ w
map ㅠ b
map ㅁ a
map ,ㅈ :w

map ,m :mks!
"map ,g :set hls
"map ,gg :set nohls
vmap u y

map ;a ggVG

"Comment
"Comment Quf
map tq :s/^\(.*\)$/\/\* \1 \*\//<CR><Esc>:nohlsearch<CR>
"Comment quf Remove
map tr :s/^\([/(]\*\\|<!--\)\(.*\)\(\*[/)]\\|-->\)$/\2/<CR><Esc>:nohlsearch<CR>

"commenT //
"map tt :s/^/\/\//<CR><Esc>:nohlsearch<CR> 
map tt :s/^\([\t ]*\)/\1\/\/<CR><Esc>:nohlsearch<CR>
"commenT //
"map tw :s/^\/\///<CR><Esc>:nohlsearch<CR> 
map tw :s/^\([\t ]*\)\/\//\1<CR><Esc>:nohlsearch<CR> 

map t< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>

"Tern command
map td :TernDef<CR>
map ts :TernDefSplit<CR>
map tp :TernDefPreview<CR>
map ta :TernDefTab<CR>

"Tagbar
map to :TagbarOpen 
map tb :TernDocBrowse
map te :TernRefs
map tn :TernRename
map ty :TernType

set backupdir=~/viBackup
set dir=~/viBackup
map * #<S-N>zz
"map zl <C-w>w<C-w>w:q<CR><C-w>w<C-w>H<C-w>w<C-d>2<C-y>Hj<C-w>w

"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
set t_Co=256

"----------------------------------------------------------------------
"Open with current file's directory
function! OpenCurrentDir()
	execute ":e " . expand('%:p:h')
endfunction
map ,c :call OpenCurrentDir()<CR>
"----------------------------------------------------------------------
"A mapping to make a backup of the current file.
function! WriteBackup( attachedStr)
	silent execute 'write'
	if a:attachedStr == '0' 
		let l:fname = &backupdir . '/' . expand('%:t') . '_' . strftime('%Y%m%d_%H.%M.%S')
	else
		let l:fname = &backupdir . '/' . expand('%:t') . '_' . strftime('%Y%m%d_%H.%M.%S') . '-' . a:attachedStr
	endif
	silent execute 'write' l:fname
	echomsg 'Wrote' l:fname 
endfunction

" Save & backup with current time
"map ,w :w<ESC>:call WriteBackup(0)<CR>
map ,w :w<CR>
map ,bw :w<ESC>:call WriteBackup(0)<CR>

" Backup with current time and user string. ex) :BA successAjax!!
command! -nargs=1 BA :call WriteBackup(<f-args>)
"----------------------------------------------------------------------
"SnipMate remapping
"imap <S-Tab> <Plug>snipMateNextOrTrigger
"smap <S-Tab> <Plug>snipMateNextOrTrigger
"imap '<Tab> <Plug>snipMateBack
"----------------------------------------------------------------------


"----------------------------------------------------------------------
"change numbering type
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
"----------------------------------------------------------------------
" easy-motion shortcut
map <C-i> <Plug>(easymotion-s)
map <C-h><C-i> <Plug>(easymotion-s2)
"----------------------------------------------------------------------
" c compile!!
map <Insert>g :colder<cr>
map <Insert>l :cnewer<cr>
map <Insert>n :cnext<cr>
map <Insert>p :cprevious<cr>
map <Insert>p :cprevious<cr>

"----------------------------------------------------------------------
"show path/filename status bar
function! ShowFileNameBar()
	if(&laststatus == 0 || &laststatus == 1)
"		set statusline=%F
		set laststatus=2
	else
		set laststatus=0
	endif
endfunc

map <C-n><C-n> :call ShowFileNameBar()<cr>
"----------------------------------------------------------------------
map <S-tab> <CR><C-W><C-W>

"set formatoptions-=r
"below code doesn't operate. so should revise directly related file as using floowing code to find it
":verbose set formatoptions
"setlocal fo-=t fo+=croql

:set makeprg=gcc\ -o\ $*\ $*\.o

vmap <S-y> :<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!awk 'NR > 1 { print h } { h = $0 } END { ORS = ""; print h }' \| pbcopy<CR>u
"vmap <C-c> :<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!xclip -selection c<CR>u




"----------------------------------------------------------------------
"folding complie
function! Precompile()
	if (expand('%:e') == 'jsx' || expand('%:e') == 'JSX')
		:!jsx %:h/%:t > %:r.js
	elseif (expand('%:e') == 'styl' || expand('%:e') == 'STYL')
		:!stylus %:h/%:t
	elseif (expand('%:e') == 'less' || expand('%:e') == 'LESS')
		:!lessc %:h/%:t > %:r.css
	endif
endfunc

map <C-m><C-k> :call Precompile()<CR>


"----------------------------------------------------------------------
"folding complie
function! ToggleFoldMethod()
	if(&foldmethod == 'indent')
		set foldmethod=manual
	else
		set foldmethod=indent
	endif
endfunc
set foldlevel=1
map fzf $V%zf
map fzz :call ToggleFoldMethod()<cr>


"----------------------------------------------------------------------
"snippets
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: "\<TAB>"

" For snippet_complete marker.
"if has('conceal')
"  set conceallevel=2 concealcursor=i
"endif




"----------------------------------------------------------------------
"airline
"let g:airline_section_a = ''
"let g:airline#extensions#whitespace#enabled = 0

"----------------------------------------------------------------------
"Avoding NERDTree broken char
let g:NERDTreeDirArrows=0


"----------------------------------------------------------------------

map gn :tabnew<CR>


"----------------------------------------------------------------------
"for underscore template
au  BufNewFile,BufRead *.jst set syntax=jst
"----------------------------------------------------------------------
"
let g:syntastic_javascript_checkers = ['jsxhint']
