--[[
	Este programa es software libre: usted puede redistribuirlo y/o modificarlo conforme a los t�rminos de la Licencia P�blica General de GNU publicada por
	la Fundaci�n para el Software Libre, ya sea la versi�n 3 de esta Licencia o (a su elecci�n) cualquier versi�n posterior.

	Este programa se distribuye con el deseo de que le resulte �til, pero SIN GARANT�AS DE NING�N TIPO; ni siquiera con las garant�as impl�citas de
	COMERCIABILIDAD o APTITUD PARA UN PROP�SITO DETERMINADO.  Para m�s informaci�n, consulte la Licencia P�blica General de GNU.

	Junto con este programa, se deber�a incluir una copia de la Licencia P�blica General de GNU.
	De no ser as�, ingrese en <http://www.gnu.org/licenses/>.
	
	Este programa es software libre y usted puede redistribuirlo conforme a ciertas condiciones (leer archivo adjunto).
]]

include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "border FX"
script_description = "Script Lua"
script_author = "alquimista"
script_version = "1"

--FUNCI�N GENERADOR FX
function fx_test(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Default") then
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

-------------------------------AC� COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE POSICION
function do_fx(subs, meta, line)
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x=syl.center + line.left
		local y=line.margin_v + 30
		if i ==1 then
			tiempo=0
		end
		
--FX INICIAL
		randfrz= math.random(-20,20)
		l = table.copy(line)
		l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\frz%d\\1c&HFFFFFF&\\t(\\frx1080\\1c%s\\3c%s\\bord2\\blur0\\be0\\frx0)}%s",x-100,50,x,y,randfrz,line.styleref.color2,line.styleref.color3,syl.text_stripped)
		l.start_time = line.start_time -1000+tiempo
		l.end_time = line.start_time+tiempo
		l.layer=0
		subs.append(l)
		
--SILABAS ESTATICAS (1)
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
		l.start_time = line.start_time+tiempo
		l.end_time = line.start_time+syl.start_time
		l.layer=2
		subs.append(l)
		
--SILABAS ESTATICAS (2)
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\alpha&H50&}%s",x,y,line.styleref.color1,syl.text_stripped)
		l.start_time = line.start_time+syl.start_time
		l.layer=3
		subs.append(l)

--FX LETRA CANTADA
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\1c%s))}%s", x, y,line.styleref.color2,line.styleref.color1, syl.text_stripped)
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration
		l.layer = 6
		subs.append(l)
			
--FX DE SILABAS
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\3c%s\\bord2\\1a&HFFFFFF&\\frx0\\fry0\\t(\\3a&H8200&\\fscx130\\fscy130)}%s", x,y, line.styleref.color2, syl.text_stripped)
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration+100
		l.layer = 4
		subs.append(l)	
		tiempo=tiempo+(1000/line.kara.n)
	end
	
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACI�N-------------------------------
aegisub.register_macro("border FX", "", fx_test)
aegisub.register_filter("border FX", "", 2000, fx_test)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACI�N--------------------