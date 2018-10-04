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
;----- Grafica de Temperatura
temp    = tofloat(f_csv(1:,2))
hr      = tofloat(f_csv(1:,3))
w_speed = tofloat(f_csv(1:,4))
w_direc = tofloat(f_csv(1:,5))
solar_r = tofloat(f_csv(1:,6))
temp!0  = "date"
temp&date = date
;¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
;----- Alistando dataframe
;type        = "png"
type        = "x11"
wks         = gsn_open_wks(type,"prueba")
;¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
;----- Detalle del Frame
res             = True
res@gsnMaximize = True
res@gsnDraw     = False
res@gsnFrame    = False

res@vpWidthF    = 0.8      ; Make plots wider than 
res@vpHeightF   = 0.2      ; they are high.

res@tmYUseLeft           = False   ; Make right axis independent of left
res@tmYLOn               = False   ; Turn off left tickmarks
res@tmYROn               = True    ; Turn on right tickmarks
res@tmXTOn               = False   ; Turn off top tickmarks
res@tmYLLabelsOn         = False   ; Turn off left labels
res@tmYRLabelsOn         = True    ; Turn on right labels
res@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
res@tmYRLabelFontHeightF = 0.015   ; Increase font height
res@tmYRLabelDeltaF      = 2.0     ; Increase space b/w ticks and labels
res@tmYRLabelJust        = "CenterRight"   ; right-justify labels

res@xyLineThicknessF     = 2.0   ; Twice as thick

; Change y axis string and color for each plot.
res@tiYAxisString = "Temperatura"
res@xyLineColor   = "Purple"
xy1 = gsn_csm_xy(wks,temp&date,temp,res)    ; Create the four plots.

res@tiYAxisString = "Humedad Relativa"
res@xyLineColor   = "Brown"
xy2 = gsn_csm_y(wks,hr,res)    ; They won't be drawn yet.

res@tiYAxisString = "Velocidad del Viento"
res@xyLineColor   = "Orange"
xy3 = gsn_csm_y(wks,w_speed,res)

res@tiYAxisString = "Direccion del Viento"
res@xyLineColor   = "ForestGreen"
xy4 = gsn_csm_y(wks,w_direc,res)

res@tiYAxisString = "Radiacion Solar"
res@xyLineColor   = "ForestGreen"
xy5 = gsn_csm_y(wks,solar_r,res)

res1                     = True
res2                     = True
res1@gsnMaximize         = True
res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5/),res1,res2)

draw(xy1)    ; All four plots will be drawn.
frame(wks)

; Resize base plot and watch how other plots follow.
setvalues xy1
"vpWidthF"  : 0.4
"vpHeightF" : 0.15
end setvalues

draw(xy1)    ; All four plots will be smaller.
frame(wks)
end