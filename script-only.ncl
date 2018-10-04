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
;hora    = f_csv(1:,1)
date    = ispan(0,dimsizes(fecha)-1,1)*15
date@units = "minutes since 2015-01-01 00:00"
;¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
;----- Graficas
temp        = tofloat(f_csv(1:,2))
hr          = tofloat(f_csv(1:,3))
w_speed     = tofloat(f_csv(1:,4))
w_direc     = tofloat(f_csv(1:,5))
solar_r     = tofloat(f_csv(1:,6))
titulos     = (/"Temperatura","Humedad Relativa","Velocidad del Viento","Direccion del Viento","Radiacion Solar"/)
unidades    = (/"~S~o~N~C","%","m/s","Grados","w/m2"/)
i           = 0
dy          = temp
;dy          = hr
;dy          = w_speed
;dy          = w_direc
;dy          = solar_r
;¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
;----- Alistando dataframe
type        = "png"
;type        = "x11"
titulo      = titulos(i)
wks         = gsn_open_wks(type,titulo+" Isla Soto")
;¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
;----- Detalle del Frame
resplot                     = True
resplot@tiMainString        = "Datos Meteorologicos ~C~~Z50~ Estacion Isla de Soto - Lago Titicaca"
resplot@vpHeightF           = 0.4
resplot@vpWidthF            = 0.8
resplot@tmXBLabelAngleF     = 90. ;-- rotate x-axis labels
resplot@gsnLeftString       = unidades(i)
resplot@tiYAxisString       = titulo
resplot@xyMarkLineModes     = "Markers"
resplot@xyMarkers           = 1
resplot@xyMarkerColors      = "blue"
resplot@tiXAxisString       = "mes/dia hora" 

restick                     = True
restick@ttmFormat           = "%N/%D %H:%M"
restick@ttmMajorStride      = 2500

time_axis_labels(date,resplot,restick) ; call the formatting procedure

plot = gsn_csm_xy(wks,date,dy,resplot)

end