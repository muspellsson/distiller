ttk::notebook .nb
pack .nb

set fcalc .nb.calc
set fappr .nb.appr

ttk::frame $fcalc
ttk::frame $fappr

.nb add $fcalc -text "По параметрам колонны"
.nb add $fappr -text "По данным измерений"
