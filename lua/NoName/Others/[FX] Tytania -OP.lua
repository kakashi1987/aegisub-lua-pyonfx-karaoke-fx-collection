include("karaskel.lua")
include("zheolib1.lua")
include("formaslib.lua")
-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Tytania OP"
script_description = "FX Tytania OP"
script_author = "nickle"
script_version = "0.5"

--FUNCIÓN GENERADOR FX
function fx_tytania(subs)
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

--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE POSICION
function do_fx(subs, meta, line)
local l = table.copy(line)


	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x=syl.center + line.left
		local y=line.margin_v + 25
		local inicio=syl.start_time
		local fin=syl.end_time
		local medio=syl.start_time + syl.duration / 2
		local actor=line.actor
		
		
			function sil()
				silaba = ""..syl.text_stripped..""
				return silaba
			end
			if i ==1 then
				tiempo=0
			end
		if actor=='1' then
			l = table.copy(line) 	
			l.text = "{"..an(5)..pos(x,696)..fad(300,300)..bord(2)..be(2)..color(1,line.styleref.color1)..color(3,line.styleref.color3).."}"..sil()
			l.start_time=line.start_time-200
			l.end_time=line.end_time+200
			l.layer=4
			subs.append(l)
			
		else
			--entrada
			l = table.copy(line) 	
			l.text = "{"..an(5)..pos(x,y)..bord(2)..blur(3)..alpha('FF')..fscxy(80)..color(1,line.styleref.color1)..color(3,line.styleref.color1)..t(fscxy(300)..alpha('00'))..t(fscxy(100)).."}"..sil()
			l.start_time=line.start_time-1000+tiempo
			l.end_time=line.start_time+tiempo
			l.layer=4
			subs.append(l)
			
			--back
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..bord(2)..be(3)..fscxy(60)..color(1,line.styleref.color1)..color(3,line.styleref.color1)..alpha('46')..fscxy(100)..t(fscxy(150)..alpha('ff')).."}"..sil()
			l.start_time=line.start_time+syl.start_time-100
			l.end_time=line.start_time+syl.end_time
			l.layer=1
			subs.append(l)
			
			--estatico	
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..bord(2)..blur(3)..fscxy(100)..color(1,line.styleref.color1)..color(3,line.styleref.color1).."}"..sil()
			l.start_time=line.start_time+tiempo
			l.end_time=line.start_time+syl.start_time
			l.layer=3
			subs.append(l)
			
			--Enfasis
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..bord(2)..blur(3)..fscxy(100)..color(1,line.styleref.color1)..color(3,line.styleref.color1)..t(tt(0,syl.duration)..color(1,line.styleref.color3)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.end_time-1000+tiempo
			l.layer=4
			subs.append(l)
			
			--encima
			movimiento=rand(3)
			l = table.copy(line)
			l.text = "{"..an(5)..move(x,y,x+movimiento,y+movimiento)..alpha('ff')..bord(2)..be(3)..fscxy(100)..color(1,line.styleref.color3)..color(3,line.styleref.color3)..t(alpha('46')).."}"..sil()
			l.start_time=line.start_time+syl.start_time-100
			l.end_time=line.start_time+syl.start_time+syl.duration/2
			l.layer=5
			subs.append(l)
			
			l = table.copy(line)
			l.text = "{"..an(5)..move(x+movimiento,y+movimiento,x,y)..bord(2)..be(3)..fscxy(100)..color(1,line.styleref.color3)..color(3,line.styleref.color3)..alpha('46')..t(alpha('ff')).."}"..sil()
			l.start_time=line.start_time+syl.start_time+syl.duration/2
			l.end_time=line.start_time+syl.start_time+syl.duration+100
			l.layer=5
			subs.append(l)
			
			--salida
			
			l = table.copy(line) 	
			l.text = "{"..an(5)..pos(x,y)..bord(2)..blur(3)..alpha('00')..fscxy(100)..color(1,line.styleref.color3)..color(3,line.styleref.color1)..t(fscxy(300))..t(fscxy(80)..alpha('FF')).."}"..sil()
			l.start_time=line.end_time-1000+tiempo
			l.end_time=line.end_time+tiempo
			l.layer=4
			subs.append(l)
		end			
			tiempo=tiempo+(1000/line.kara.n)
			
	end
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX Tytania OP", "", fx_tytania)
aegisub.register_filter("FX Tytania OP", "", 2000, fx_tytania)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------