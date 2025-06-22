include("karaskel.lua")
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "LUA4 FX Base"
script_description = "Script Lua4 con Zheolib.lua"
script_author = "Zheo"
script_version = "1.9.0 Rev2"

-- ## FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_zheo(subs)
	aegisub.progress.task("ESPERA MIESTRAS SE HACE EL FX... (Sale a dar una vuelta D:)")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando tu FX D:")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Esto llevo trabajado (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Default") then --Acá se puede cambiar por el nombre del Estilo que quieras
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Por fin termine D:!")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_zheo")
end
-- ## TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------
-------------------------------ACÁ COMIENZA LA CONFIGURACIÓN BÁSICA-----------------------
-- ## CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25
if i == 1 then
tempo=0
end
-- ## AGREGAMOS TAMBIEN ESTA FUNCIÓN
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

-------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------
-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

-- ## FX INICIAL
l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..bord(0)..frx(100)..color(1,'ffffff')..t(frx(360)..estilo(1,line.styleref.color2)..bord(2)).."}"..sil()
l.start_time = line.start_time+tempo-800
l.end_time = line.start_time
l.layer=0
subs.append(l)

--## SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)
tempo=tempo+(1000/line.kara.n)

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..org(x,y)..pos(x,y)..estilo(1,line.styleref.color2)..t(fscxy(50,50)..frz(360)..bord(0)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

--## FX EXPLOSIÓN
l = table.copy(line)
if sil() == "" then -- si se karaokea un espacio (suele pasar, sino, no hubiese hecho esto xD)
l.text = " " -- el resultado será un espacio y no una explosión :D
else -- si no es un espacio, hará el FX =D
for r=1,40 do
    if r==1 then
        suma=0
    end
    if r <= 15 then -- a jugar un poco :D
        tiempo =l.start_time+syl.duration
        figura = p(1,'m 0 0 l 0 1 l 1 1 l 1 0') -- ocupo la funcion p()
        giraz= 180
        elseif r >=15 and r <= 30 then
            tiempo =l.start_time+syl.duration+syl.duration+300
            figura = p(5,'m 10 49 l 52 19 l 0 19 l 42 49 l 26 0') -- ocupo la funcion p()
            giraz = 360
                elseif r >= 30 then
                tiempo= l.start_time+syl.duration+700
                figura = p(4,'m 1 1 l 50 49 l 100 1 l 51 50 l 100 98 l 50 51 l 1 98 l 49 50 l 1 1') -- ocupo la funcion p()
                giraz = rand(180) -- ocupo la funcion rand() para el random :D
   end
angulo=math.rad(suma)
GenCirculo(0,x,y,suma,30)

l.text = "{"..fad(100,100)..an(5)..org(x,y)..move(posx,posy,posx1,posy1)..color(1,'10FFBF')..fscxy(200,200)..bord(0)..frz(0)..t(estilo(1,line.styleref.color2)..frz(giraz)).."}"..figura
l.start_time=line.start_time+syl.start_time
l.end_time= tiempo
l.layer = 0
subs.append(l)
suma=suma+9
end
end


end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("JR-F FX!", "Aplica tu FX! D:", fx_zheo)
aegisub.register_filter("JR-F FX!", "Aplica tu FX! D:", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---