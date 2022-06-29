include("karaskel.lua")                                                                                      
include("zheolib.lua")                 

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            
--X    Copyright (c) 2009, ASEDARK  (ASE_DARK_ANGEL@hotmail.com)
--X    All rights reserved®.                                                                   
--X        	                                                                                                                    
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


script_name = "EJEMPLO DE AUTOTIMER"
script_description = "PLANTILLA ASEDARK"
script_author = "ASEDARK"
script_modified = "Alkoon_ Monday, July 13, 2009"
	

function ALKOON_FX(subs)
	aegisub.progress.task("ESPERA MIENTRAS SE CREA EL EFECTO")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("APLICANDO EFECTO")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("PROGRESO (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
			not l.comment  then  karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
		i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("¡PROCESO FINALIZADO!")
	aegisub.progress.set(100)

end

function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25 
if i == 1 then  univers =0
end
       function sil()
               silaba = ""..syl.text_stripped..""
      return silaba
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


function AutoTimer(TipoDeLinea,Intervalo,Tag,ValorInicialTag,AumentoTag,MasYMenos) 
local RESULTADO_01 = 0
RESULTADO_01=""
local RESULTADO_02 = 0
RESULTADO_02=""
local DIRECCION =1

if TipoDeLinea == TE1 then
DURACION =(line.start_time-800)/Intervalo
end

if TipoDeLinea == TE2 then
DURACION =(line.start_time+syl.start_time)/Intervalo
end

if TipoDeLinea == TE4 then
DURACION =(l.duration)/Intervalo
end

local count = math.ceil(DURACION) 
if math.random(0,5) == 0 then 
DIRECCION = -DIRECCION
end 
	for i = 1, count do 
		ValorTagAumento=ValorInicialTag+(i*AumentoTag)
		RESULTADO_01 = RESULTADO_01 .."\\t(" ..(i-1)*Intervalo.. "," ..i*Intervalo.. ",\\" ..Tag..DIRECCION*ValorTagAumento..")"..""
		RESULTADO_02 = RESULTADO_02 .."\\t(" ..(i-1)*Intervalo.. "," ..i*Intervalo.. ",\\" ..Tag..ValorTagAumento..")"..""
		DIRECCION = -DIRECCION
	end
	if MasYMenos == 1 then
	return RESULTADO_01	
	elseif MasYMenos == 0 then
	return RESULTADO_02
	end
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	l = table.copy(line)
	l.text = "{"..fad(150,0)..an(5)..org(x,y)..move(x+rand(100),y-rand(50),x,y)..be(1.5)..bord(0)..frz(100)..color(1,'ffffff')..AutoTimer(TE1,400,'bord',0,0.4,0)..t(frz(300)..estilo(1,line.styleref.color2)..bord(1))..t(frz(0)).."}"..sil() 
	l.start_time = line.start_time -300 +univers
	l.end_time = line.start_time+univers
	l.layer=0 
	subs.append(l) 

		l = table.copy(line)
		l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2)..bord(1)..AutoTimer(TE3,300,'frx',30+syl.height/2,0.5,1).."}"..sil() --# OR #--{{~ AutoTimer(TE4,500,'frx',20+line.duration,0.5,1)
		l.start_time = line.start_time+univers
		l.end_time = line.start_time+syl.start_time
		subs.append(l)
		for i=0,2 do
		l = table.copy(line) 
		l.text = "{"..an(5)..fad(0,0)..move(x,y,x,y)..bord(1)..color(1,'H3A3D88')..AutoTimer(TE3,500,'frz',50,0,1)..t(fscxy(110,120)..color(1,'H000000')..color(3,'HFFFFFF')..AutoTimer(TE2,500,'fry',50,0,1)).."}"..sil()
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration
		subs.append(l)
                                   end

	l = table.copy(line)
	l.text = "{"..an(5)..shad(0)..fad(0,100)..bord(1)..pos(x,y)..color(1,'HFFFFFF')..color(3,'HFFFFFF')..estilo(1,line.styleref.color4)..AutoTimer(TE3,500,'frx',20+syl.height/2,0.5,1)..t(bord(0)..be(1))..t(be(1.5)..t(be(2.3))).."}"..sil()
	l.start_time=line.start_time+syl.start_time+syl.duration
	l.end_time=l.end_time+univers
	subs.append(l)
	univers=univers+(300/line.kara.n)

        end
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
aegisub.register_macro("EXAMPLE DE AUTOTIMER (Version 1.0) - ASEDARK", "APLICAR EFECTO", ALKOON_FX)      
aegisub.register_filter("-ASEDARK-", "APLICAR EFECTO", 2000, ALKOON_FX)                      
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
