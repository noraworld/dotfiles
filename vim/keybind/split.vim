nnoremap s  <Nop>
nnoremap ss :<C-u>vs<CR><C-w>l
nnoremap sp :<C-u>sp<CR><C-w>j
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sw <C-w>w
call submode#enter_with("bufmove", "n", "", "s>", "<C-w>>")
call submode#enter_with("bufmove", "n", "", "s<", "<C-w><")
call submode#enter_with("bufmove", "n", "", "s+", "<C-w>+")
call submode#enter_with("bufmove", "n", "", "s-", "<C-w>-")
call submode#map("bufmove", "n", "", ">", "<C-w>>")
call submode#map("bufmove", "n", "", "<", "<C-w><")
call submode#map("bufmove", "n", "", "+", "<C-w>+")
call submode#map("bufmove", "n", "", "-", "<C-w>-")
