import subprocess
import os
from qutebrowser.api import interceptor

"""
qutebrowser settings for video

for more settings check out
https://qutebrowser.org/doc/help/settings.html
"""

# To load settings configured via the GUI
config.load_autoconfig()
# To not load settings configured via the GUI
# config.load_autoconfig(False)

# ================== Youtube Add Blocking ======================= {{{
def filter_yt(info: interceptor.Request):
    """Block the given request if necessary."""
    url = info.request_url
    if (
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block()


interceptor.register(filter_yt)
# }}}

# ====================== Special Format Yanking =========== {{{
config.bind("<y><o>", "yank inline [[{url}][{title}]]")
# }}}

## =================== Launch Qutebrowser from Dmenu ====== {{{

#"""
##!/bin/sh

## Originally from lukesmith with some changes
## Gives a dmenu prompt to search DuckDuckGo.
## Without input, will open DuckDuckGo.com.
## Anything else, it search it.

#LAUNCER="dmenu -l 5 -i -p "
#[ -z "${DISPLAY}" ] && LAUNCER="fzf --prompt "

#localBROWSER="$BROWSER "
#[ -n "$*" ] && localBROWSER="$*"
#[ -z "${DISPLAY}" ] && localBROWSER="w3m "

#if [ -f ~/.config/bookmarks ]; then
#	choice=$( (echo "🦆" && cat ~/.config/bookmarks) | $LAUNCER"Search:") || exit 1
#else
#	choice=$(echo "🦆" | $LAUNCER -i -p "Search DuckDuckGo:") || exit 1
#fi

#case "$choice" in
#*🦆*)
#	$localBROWSER"https://duckduckgo.com"
#	exit
#	;;
#http*)
#	$localBROWSER"$(echo $choice | awk '{print $1}')"
#	exit
#	;;
#*) $localBROWSER"https://duckduckgo.com/?q=$choice"
#	exit
#	;;
#esac
##vim:ft=sh
#"""

# }}}
# ====================== Open Notes From Qutebrowser ====== {{{
# notecmd = "yank inline [[{url}][{title}]];; spawn " +\
#         os.environ["TERMINAL"] + " -e " + os.environ["EDITOR"] + \
#         " -c 'call CreateCapture(\"e\" , \"qutebrowser\")'"
# config.bind("gn", notecmd)



"""
" PART OF MY VIMRC
" I used minisnip to execute the vimscript but you could just use autocommands

" Simple implementation of org-capture using minisnip
function! CreateCapture(window, ...)
        " file used to store all captures
	let g:org_refile='~/Documents/org/refile.org'
	if a:0 == 1 && a:1 == 'qutebrowser'
		exec a:window . ' ' . g:org_refile
		exec '$read ' . globpath(&rtp, 'extra/org/templateQUTE.org')
	endif
	call feedkeys("i\\<Plug>(minisnip)", 'i')
endfunction
"""

"""
" ~/.vim/extra/org/templateQUTE.org
* TODO {{+~getreg('+')+}}
SCHEDULED: <{{+~strftime(g:org_date_format)+}}>
"""
# }}}
# ======================= External Open =================== {{{
# config.bind("V", "hint links spawn " + os.environ["BROWSER"] + ' "{hint-url}"')
# config.bind("v", 'hint links spawn funnel "{hint-url}"')
# config.bind("\\", 'spawn dmenuhandler "{url}"')
# }}}
# ======================= Redline Insert Mode ============= {{{
# Awesome way to open vim from qutebrowser
# c.editor.command = [
#     os.environ["TERMINAL"],
#     "-e",
#     os.environ["EDITOR"],
#     "-f",
#     "{file}",
#     "-c",
#     "normal {line}G{column0}1",
# ]

config.bind("<Ctrl-h>", "fake-key <Backspace>", "insert")
config.bind("<Ctrl-a>", "fake-key <Home>", "insert")
config.bind("<Ctrl-e>", "fake-key <End>", "insert")
config.bind("<Ctrl-b>", "fake-key <Left>", "insert")
config.bind("<Mod1-b>", "fake-key <Ctrl-Left>", "insert")
config.bind("<Ctrl-f>", "fake-key <Right>", "insert")
config.bind("<Mod1-f>", "fake-key <Ctrl-Right>", "insert")
config.bind("<Ctrl-p>", "fake-key <Up>", "insert")
config.bind("<Ctrl-n>", "fake-key <Down>", "insert")
config.bind("<Mod1-d>", "fake-key <Ctrl-Delete>", "insert")
config.bind("<Ctrl-d>", "fake-key <Delete>", "insert")
config.bind("<Ctrl-w>", "fake-key <Ctrl-Backspace>", "insert")
config.bind("<Ctrl-u>", "fake-key <Shift-Home><Delete>", "insert")
config.bind("<Ctrl-k>", "fake-key <Shift-End><Delete>", "insert")
config.bind("<Ctrl-x><Ctrl-e>", "open-editor", "insert")
# }}}

c.statusbar.show = "always"

# fonts
c.fonts.web.size.default = 15

