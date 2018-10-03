load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"

begin
;¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
;----- Extraendo archivos
;dir     = "/mnt/j/Universidad/San Marcos/Mecanica de Medios Continuos/"    ;--> en windows
;f_csv   = "practica1/Libro222.csv"                                         ;--> en windows
f_csv   = "Libro222.csv"                                                    ;--> en linux, trabajar dentro de la carpeta
;f_csv  := asciiread(dir+f_csv,-1,"string")  ;--> leendo ascii 
f_csv  := asciiread(f_csv,-1,"string")  ;--> leendo ascii 
f_csv  := str_split_csv(f_csv,";",0)        ;--> convirtiendo en matriz
fecha   = f_csv(1:,0)
hora    = f_csv(1:,1)


date    = ispan(0,dimsizes(fecha)-1,1)*15
date@units = "minutes since 2015-01-01 00:00"

temp    = tofloat(f_csv(1:,2))
temp!0  = "date"
temp&date = date

;¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
;----- Alistando dataframe
;type        = "png"
type        = "x11"
wks         = gsn_open_wks(type,"prueba")


resplot                 = True
resplot@tiMainString    = "Basic XY plot"
restick                 = True
restick@ttmFormat       = "%N/%D %H:%M"
time_axis_labels(temp&date,resplot,restick) ; call the formatting procedure

plot = gsn_csm_xy(wks,temp&date,temp,resplot)
;plot = gsn_csm_y(wks, temp, resplot)

end