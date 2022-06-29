include("karaskel.lua")
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D
include("formaslib.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Fx Chingon ! xD"
script_description = "Fx del ending de Naruto Shippuuden llamado Shinkokyuu"
script_author = "kichanXcrazy"
script_version = "v0.5"

-- ## FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_kc(subs)
	aegisub.progress.task("QUE QUIERES QUE TE DIGA ??   NO ME METAS TU PUTO FX !!! xD")
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
	aegisub.progress.task("Ya te puedes ir !")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_kc")
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

--FX INICIAL
l = table.copy(line)
l.text = "{"..fad(800,0)..an(5)..move(-10+rand(10),y,x,y)..org(x,y)..alfa(1,'ff')..bord(1)..frx(rand(15))..color(3,'HFFFFFF')..be(1)..t(frx(0)).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..alfa(1,'ff')..color(3,'HFFFFFF').."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..move(x,y+3,x,y)..color(1,'H726FDE')..blur(5)..t(blur(0)..bord(1)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =3
subs.append(l)



--PARTICULAS
l = table.copy(line)
for f=0,35 do
l.text = "{"..an(5)..move(x,y, x-rand(30,80), y+rand(30,60))..blur(4)..bord(0.3)..be(2)..c(3, 'ffffff')..RangeColor(1, f/35, 'AFCFF0', 'EBBE87').."}"..p(5,Formas(17))
l.start_time = line.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+rand(800)
l.layer=0
subs.append(l)
end


end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("Prueba!", "FX Ending Naruto Shippuuden Shinkokyuu", fx_kc)
aegisub.register_filter("Prueba!", "FX Ending Naruto Shippuuden Shinkokyuu", 2000, fx_kc)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---