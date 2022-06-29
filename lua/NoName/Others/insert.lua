include("karaskel.lua")
include("zheolib.lua")
-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Polyphonica insert"
script_description = "FX Polyphonica insert"
script_author = "nickle"
script_version = "1"

--FUNCIÓN GENERADOR FX
function fx_poly(subs)
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
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x=syl.center + line.left
		local y
		actor=line.actor
		if i ==1 then
			tiempo=0
		end
		if actor=="1" then --Posy Romanji
			y= line.margin_v + 30
		elseif actor=="3" then --posy traduccion
			y=line.margin_v + 55
		end
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end
		
		
	
			l = table.copy(line)
			l.start_time=line.start_time-700
			l.end_time=line.start_time
			l.text = "{"..an(5)..pos(x,y)..bord(0)..be(2)..alfa(3,'FF')..alfa(1,'FF')..color(1,line.styleref.color1)..t(be(0)..alfa(1,'00')).."}"..sil()
			l.layer=0
			subs.append(l)
			l.text = "{"..an(5)..pos(x,y)..bord(2)..blur(4)..alfa(1,'FF')..alfa(3,'FF')..color(3,line.styleref.color1)..t(bord(1)..blur(0)..color(3,line.styleref.color3..alfa(3,'00'))).."}"..sil()
			l.layer=1
			subs.append(l)
			
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y).."}"..sil()
			l.layer=0
			subs.append(l)
			
			l = table.copy(line)
			l.start_time=line.end_time
			l.end_time=l.start_time+700
			l.text = "{"..an(5)..pos(x,y)..bord(0)..be(0)..alfa(3,'FF')..alfa(1,'00')..color(1,line.styleref.color1)..t(be(2)..alfa(1,'FF')).."}"..sil()
			l.layer=0
			subs.append(l)
			l.text = "{"..an(5)..pos(x,y)..bord(1)..blur(0)..alfa(1,'FF')..alfa(3,'00')..color(3,line.styleref.color3)..t(bord(2)..blur(4)..color(3,line.styleref.color1..alfa(3,'FF'))).."}"..sil()
			l.layer=1
			subs.append(l)
			
			if actor=="1" then
			l = table.copy(line)
			l.start_time=line.start_time+syl.start_time-70
			l.end_time=l.start_time+syl.duration
			inicio=0
			fin=syl.duration+70
			medio=inicio+fin/2
			l.text = "{"..an(5)..pos(x,y)..bord(0)..be(0)..color(1,'&H625551&')..t(tt(inicio,medio)..be(2)..color(1,'&H554C49&')..fscx(120)..fscy(120))..t(tt(medio,fin)..be(0)..color(1,'&H625551&')..fscx(100)..fscy(100)).."}"..sil()
			l.layer=2
			subs.append(l)	
			
			for z=0,13 do
			
			end
			end
			
			
			tiempo=tiempo+(1000/line.kara.n)
	end
	
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX Polyphonica insert", "", fx_poly)
aegisub.register_filter("FX Polyphonica insert", "", 2000, fx_poly)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------