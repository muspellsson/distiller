# variables:
#  ftvals
#  fcanvas
#  coeffa
#  coeffb
#  fcomment

package require Tktable

foreach n {1 2} {
    ttk::frame $fcalc.c$n
    set fcol$n $fcalc.c$n
    pack $fcalc.c$n -side left -expand true -fill both
}

proc rowtag row {
    if {$row == 0} {
	return title
    } elseif {$row == 1 || $row == 7 || \
	$row == 9 || $row == 12 || $row == 15} {
	return subtitle
    }
}

proc coltag col {
    if {$col != 1} {
	return readonly
    }
}

set ftvals(0,0) "Параметр"
set ftvals(0,1) "Значение"
set ftvals(0,2) "Размерность"
set ftvals(0,3) "Справочник"
set ftvals(1,0) "Низкокипящий компонент"
set ftvals(7,0) "Высококипящий компонент"
set ftvals(9,0) "Параметры куба колонны"
set ftvals(12,0) "Параметры дефлегматора колонны"
set ftvals(15,0) "Параметры массопереноса"

set ftable $fcol1.table
table $ftable -variable ftvals \
    -colwidth 15 -cols 4 \
    -rows 17 \
    -rowtagcommand rowtag -coltagcommand coltag \
    -selectmode none
pack $ftable

$ftable spans 1,0 0,4
$ftable spans 7,0 0,4
$ftable spans 9,0 0,4
$ftable spans 12,0 0,4
$ftable spans 15,0 0,4

$ftable tag configure readonly -state disabled
$ftable tag configure title -bg lightgreen -fg black
$ftable tag configure subtitle -bg yellow -fg black


set fcanvas $fcol2.canvas
canvas $fcanvas -bg white -height 300 -width 300
pack $fcanvas

if 0 {
foreach n {1 2 3 4} {
    ttk::frame $fcalc.c$n
    set fcol$n $fcalc.c$n
    pack $fcalc.c$n -side left -expand true -fill both
}

proc isposreal {val} {
    puts $val
    if {[string is double $val]} {
	return [expr $val > 0]
    } else {
	return false
    }
}

proc fieldinvalid {reason} {
    tk_messageBox -title "Ошибка" -message "Произошла ошибка!" \
	-detail $reason -icon error -type ok
}

set fcoeffs $fcol2.coeffs
ttk::labelframe $fcoeffs -text "Коэффициенты"
pack $fcoeffs

set betaD 0
set betaB 0
set coeffK 0
set coeffR 0

ttk::label $fcoeffs.l1 -text "Теплопереноса\nв дефлегматоре,\nВт/К"
pack $fcoeffs.l1 -anchor w
ttk::entry $fcoeffs.e1 -textvariable betaD -justify right \
    -validate focusout -validatecommand {isposreal %P} \
    -invalidcommand {fieldinvalid "ahah"}
pack $fcoeffs.e1
ttk::label $fcoeffs.l2 -text "Теплопереноса\nв кубе,Вт/К"
pack $fcoeffs.l2 -anchor w
ttk::entry $fcoeffs.e2 -textvariable betaD -justify right
pack $fcoeffs.e2
ttk::label $fcoeffs.l3 -text "Массопереноса\nмоль²∙K/Дж∙с"
pack $fcoeffs.l3 -anchor w
ttk::entry $fcoeffs.e3 -textvariable betaD -justify right
pack $fcoeffs.e3
ttk::label $fcoeffs.l4 \
    -text "Мольная теплота\nпарообразования\nнизкокипящего,\nДж/моль"
pack $fcoeffs.l4 -anchor w
ttk::entry $fcoeffs.e4 -textvariable betaD -justify right
pack $fcoeffs.e4

ttk::labelframe $fcol3.canvas -text "Область реализуемости"
pack $fcol3.canvas

set fcanvas $fcol3.canvas.canvas
canvas $fcanvas -bg white -height 300 -width 300
pack $fcanvas

set fcoeffs $fcol3.coeffs
ttk::labelframe $fcoeffs -text "Характеристические коэффициенты"
pack $fcoeffs -expand true -fill x

set coeffa 0
set coeffb 0

ttk::label $fcoeffs.l1 -text "Обратимый КПД, моль/кДж"
grid $fcoeffs.l1 -row 0 -column 0 -sticky w
ttk::label $fcoeffs.l2 -text "Коэффициент необратимости,\nмоль∙c/кДж²"
grid $fcoeffs.l2 -row 1 -column 0 -sticky w
ttk::entry $fcoeffs.e1 -textvariable coeffb -state readonly -justify right
grid $fcoeffs.e1 -row 0 -column 1 -sticky e
ttk::entry $fcoeffs.e2 -textvariable coeffa -state readonly -justify right
grid $fcoeffs.e2 -row 1 -column 1 -sticky e

ttk::labelframe $fcol4.comment -text "Комментарий"
pack $fcol4.comment

set fcomment $fcol4.comment.comment
text $fcomment -width 30
pack $fcomment
}
