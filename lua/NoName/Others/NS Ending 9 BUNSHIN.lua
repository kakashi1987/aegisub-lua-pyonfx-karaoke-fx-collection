include("karaskel.lua") -- ESTE SIEMPRE SE DEBE DE AGREGAR !!!
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D !!

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "ending9"
script_description = "ending9"
script_author = "bunshin"
script_version = "2.0"

-- ## FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_kXc(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment then
			karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
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

function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

-------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------
-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--FX INICIAL
l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..bord(2)..color(1,'ffffff')..estilo(1,line.styleref.color1)..bord(1).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)


--Silaba estatica 2 - borde negro
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(1)..color(3,"&H747482&")..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)

--FX DE SILABAS(ESTE SE AGRANDA LA SILABA)
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(1,"53F0FF")..bord(1)..t(fscxy(150)..blur(8)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

--FX DE SILABAS(ESTE SE AGRANDA LA HOJA)
l = table.copy(line)
for j= 0,3 do 
l.text = "{"..move(x,y,x-rand(10,50),y+rand(10,50))..an(5)..color(3,"&H000000&")..pos(x,y)..t(fscxy(300))..bord(1)..blur(10).."}"..p(5,"mm 71 205 b 71 205 69 204 69 204 b 74 197 78 189 81 181 b 91 176 108 169 111 164 b 112 162 112 158 112 156 b 118 152 124 145 129 138 b 131 133 126 104 124 92 b 120 87 120 78 118 71 b 115 62 110 54 103 47 b 105 64 108 77 105 98 b 96 115 83 128 82 133 b 79 135 79 138 79 141 b 80 144 82 149 83 152 b 79 164 74 177 70 189 b 70 194 69 200 69 205 b 69 205 70 205 70 205 b 86 167 103 128 120 89 b 117 91 112 93 109 95 b 105 105 99 116 95 126 ")
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 1
subs.append(l)

--FX DE SILABAS(ESTE SE AGRANDA LA HOJA)
l = table.copy(line)
for j= 0,3 do 
l.text = "{"..move(x+rand(10,50),y-rand(10,50),x,y)..an(5)..color(3,"&H000000&")..pos(x,y)..t(fscxy(300))..bord(1)..blur(10).."}"..p(5,"mm 71 205 b 71 205 69 204 69 204 b 74 197 78 189 81 181 b 91 176 108 169 111 164 b 112 162 112 158 112 156 b 118 152 124 145 129 138 b 131 133 126 104 124 92 b 120 87 120 78 118 71 b 115 62 110 54 103 47 b 105 64 108 77 105 98 b 96 115 83 128 82 133 b 79 135 79 138 79 141 b 80 144 82 149 83 152 b 79 164 74 177 70 189 b 70 194 69 200 69 205 b 69 205 70 205 70 205 b 86 167 103 128 120 89 b 117 91 112 93 109 95 b 105 105 99 116 95 126 ")
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 1
subs.append(l)

end
end
end
end

-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACION--------------
aegisub.register_macro("ending9", "Aplica tu FX! D:", fx_kXc)
aegisub.register_filter("ending9", "Aplica tu FX! D:", 2000, fx_kXc)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---