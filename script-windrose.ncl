load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/wind_rose.ncl"

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
w_speed     = tofloat(f_csv(1:,4))
w_direc     = tofloat(f_csv(1:,5))

w_speed@long_name = "Wind Speed"
w_speed@units     = "m/s"
w_direc@long_name = "Wind Direction"

;******************************
; specify plot arguments
;******************************
numPetals         =  8                    ; N, NE, E, SE, S, SW, W, NW
circFr            = 10. 
spdBounds         = (/ 3., 6., 9., 15./)

;******************************
; generate color plot
;******************************
type              = "png"
;type              = "x11"
wks               = gsn_open_wks(type,"Rosa de Vientos Isla Soto")  ; send graphics to PNG file
res               = True
res@gsnFrame      = False         ; do not advance the frame
res@tiMainString  = "Datos Meteorologicos ~C~~Z50~ Estacion Isla de Soto - Lago Titicaca"
colorBounds       = (/ "blue", "green", "yellow", "red"/)
wrColor           = WindRoseColor(wks,w_speed,w_direc,numPetals,circFr,spdBounds,colorBounds,res)


; Set up resources for the labelbar.
   
lbres                    = True          ; labelbar only resources
lbres@lbAutoManage       = False         ; Necessary to control sizes
lbres@vpWidthF           = 0.05          ; labelbar width
lbres@vpHeightF          = 0.15          ; labelbar height
lbres@vpXF               = 0.78          ; labelbar position in x direction 
lbres@vpYF               = 0.58          ; labelbar position in y direction
lbres@lbBoxMajorExtentF  = 0.80          ; puts space between color boxes
lbres@lbFillColors       = colorBounds   ; labelbar colors        
lbres@lbMonoFillPattern  = True          ; Solid fill pattern
lbres@lbLabelFontHeightF = 0.015         ; font height. default is small
lbres@lbPerimOn          = False
lbres@lbTitleString      ="Wind Speed(m/s)" 
lbres@lbTitleFontHeightF = 0.01

; Create labels

nbar   = dimsizes(spdBounds)
labels = new(nbar,string)
labels(0) = 0 + "-" + spdBounds(0)
do i=1,nbar-1
    labels(i) = spdBounds(i-1) + "-" +spdBounds(i)
end do

lbid = gsn_create_labelbar(wks,nbar,labels,lbres)

draw(lbid)
frame(wks)

end