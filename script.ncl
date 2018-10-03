begin
;¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
;----- Extraendo archivos
dir     = "/mnt/j/Universidad/San Marcos/Mecanica de Medios Continuos/"
f_csv   = "practica1/Libro222.csv"
f_csv  := asciiread(dir+f_csv,-1,"string")  ;--> leendo ascii 
f_csv  := str_split_csv(f_csv,";",0)        ;--> convirtiendo en matriz
;¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
;----- Alistando dataframe
type        = "png"
;type        = "x11"
titulo1     = "precip-"+tostring(x)+"x"+tostring(y)
wks         = gsn_open_wks(type,titulo1+s+time_str)




end