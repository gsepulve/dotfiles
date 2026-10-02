#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

#Color variables
W="\033[0m"
B="\033[01;36m"
R="\033[01;31m"
G="\033[01;32m"
#echo -e "
#        $B. $W
#       $B/#\ $W                     _     $B _ _
#      $B/###\ $W      __ _ _ __ ___| |__  $B| (_)_ __  _   ___  __
#     $B/#####\ $W    / _' | '__/ __| '_ \ $B| | | '_ \| | | \ \/ /
#    $B/##.-.##\ $W  | (_| | | | (__| | | |$B| | | | | | |_| |>  <
#   $B/##(   )##\ $W  \__,_|_|  \___|_| |_|$B|_|_|_| |_|\__._/_/\_\
#  $B/#.--   --.#\ $W
# $B/'           '\ "
#echo -e "       $B Leche con platano $W- Esto es$B ARCH$W conchetumare$B que wea "
#echo -e "$W"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias emedes='/usr/bin/git --git-dir=$HOME/emedes.git --work-tree=$HOME'

#export GDK_SCALE=1
#export GDK_DPI_SCALE=0.5
#alias zeal="QT_OPENGL=software QTWEBENGINE_CHROMIUM_FLAGS=--disable-gpu zeal"

export TERMINAL=kitty
export EDITOR="nvim"

export PATH="$HOME/.local/bin:$PATH"

alias wlr-1="wlr-randr --output eDP-1 --scale 2.0 --pos 1920,0 --output HDMI-A-2 --scale 1.0 --pos 0,0"
epub2pdf() {
	"find . -type f -name "*.epub" -exec bash -c 'for f; do pdf="${f%.epub}.pdf"; [ ! -f "$pdf" ] && ebook-convert "$f" "$pdf"; done' _ {} +"
} # not working

eval "$(starship init bash)"

add-cover() {
	local x=$(pdfinfo "$2" | awk '/Page size:/ {print $3}')
	img2pdf "$1" --pagesize "${x}x" -o "${2%.pdf}_temp.pdf"
	qpdf --empty --pages "${2%.pdf}_temp.pdf" "$2" -- "${2%.pdf} (cover).pdf" && rm "${2%.pdf}_temp.pdf"
}
