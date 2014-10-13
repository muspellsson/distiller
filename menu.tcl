menu .mb
menu .mb.file -tearoff false
menu .mb.help -tearoff false

.mb add cascade -label "Файл" -menu .mb.file
.mb add cascade -label "Помощь" -menu .mb.help

.mb.file add command -label "Открыть" -accelerator "Ctrl-O" -command fileopen
.mb.file add command -label "Сохранить" -accelerator "Ctrl-S" -command filesave
.mb.file add separator
.mb.file add command -label "Выход" -accelerator "Ctrl-Q" -command quit

.mb.help add command -label "Помощь" -accelerator "F1" -command showhelp
.mb.help add separator
.mb.help add command -label "О программе" -accelerator "Ctrl-A" \
    -command showabout

. configure -menu .mb

bind . <Control-q> quit
