" #####################
" ##### functions #####
" #####################

" Converts current file from DOS format to UNIX format.
function! ConvertDosFileToUnix ()
    :update
    :e ++ff=dos
    :setlocal ff=unix
    :w
endfunction

" Removes trailing spaces without moving the cursor from current place.
function! RemoveTrailingSpaces ()
    call CommandToExecuteWithoutMovingCursor(":%s/\\s\\+$//e")
endfunction

" Allows other functions to be executed without changing the cursor position.
function! CommandToExecuteWithoutMovingCursor(command)
    let cp=getpos('.')
    exec a:command
    call cursor(cp[1],cp[2])
endfunction

" Indent file without moving cursor.
function! IndentCurrentFile()
    call CommandToExecuteWithoutMovingCursor("normal gg=G\<CR>")
    exec "normal zz"
endfunction

" Detects if it is dark already.
function! IsDark()
python << endpython
from datetime import datetime as dt
from datetime import date
from datetime import time
from datetime import timedelta
import vim

present = dt.now()
today = date.today()
evening_time = time(19, 00)
morning_time = time(6, 00)
evening = dt.combine(today, evening_time)
morning = dt.combine(today + timedelta(days=1), morning_time)
if (present > evening) and (present < morning) :
    vim.command("return 1")
else:
    vim.command("return 0")
endpython
endfunction

