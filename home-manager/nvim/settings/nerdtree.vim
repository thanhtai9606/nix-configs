" F5 to toggle 
map <silent> <F5> :NERDTreeToggle<CR>

" Open the existing NERDTree on each new tab.
"autocmd BufWinEnter * silent NERDTreeMirror

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Change arrow to expand/collapse tree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"let NERDTreeMapOpenInTab='<ENTER>'

" Git status icon
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

" Hightlight current file
let g:nerdtree_sync_cursorline = 1

inoremap jk <ESC>                          
nmap <C-n> :NERDTreeToggle<CR>             
vmap ++ <plug>NERDCommenterToggle          
nmap ++ <plug>NERDCommenterToggle          
                                           
vmap <silent> <leader>bn  :bn<CR>        
vmap <silent> <leader>bp  :bp<CR>        
vmap <silent> <leader>bd  :bd<CR>        
                                           
nnoremap <silent>  <leader>bn  :bn<CR>  
nnoremap <silent>  <leader>bp  :bp<CR>  
nnoremap <silent>  <leader>bd  :bd<CR>  
