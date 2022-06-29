include("karaskel.lua")
include("ezheolib.lua")
include("formaslib.lua")
-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Polyphonica OP"
script_description = "FX Polyphonica OP"
script_author = "nickle"
script_version = "0.5"

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
				not l.comment and 
				(l.style == "ED - ROMAJI" or l.style == "Default") then
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
		local x
		local y
		actor=line.actor
		if i ==1 then
			tiempo=0
			modi=0
			posix=0
		end
		if actor=="1" then
			temp=((480-line.width)/3)
			y= temp + syl.height+modi
			x=830
			modi=y-temp
			else
			y=line.margin_v + 30
			x=syl.center + line.left
		end
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end
		
			local inicio=syl.start_time
			local fin=syl.end_time
			local medio=syl.start_time + syl.duration / 2
			
			
		if actor~="2" then
		--particulas
			l = table.copy(line)
				for z=0,100 do
					moditam=rand(40,100)
					if syl.duration<410 then
						l.start_time=line.start_time+syl.start_time+math.random(syl.duration/2)
						l.end_time=l.start_time+syl.duration+rand(150)
					else
						l.start_time=line.start_time+syl.start_time+math.random(syl.duration/5)
						l.end_time=l.start_time+syl.duration+rand(110)
					end	
					l.text="{"..an(5)..move(x+rand(2),y+rand(2),x+rand(12),y+rand(12))..be(math.random(3,5))..color(1,line.styleref.color3)..bord(0)..fscxy(moditam,moditam).."}"..p(5,Formas(5,4))
					subs.append(l)
				end
		end
		
		inline=syl.inline_fx
		if inline=="part" then
			local modit
			local jate
			local control=0
			local control2=100
			for zz=0,10 do 
				
				pos2x=line.left
				
				if zz==0 then
					jate=0
				else
					jate=jate+math.random(100,200)
				end
				
				--arcolor={'8FF73D','CBC74A','EE2E97'}
				--colorin=arcolor[math.random(1,3)]
				modit=line.start_time+syl.start_time+jate
				alphax=ass_alpha(math.random(50,150))
				ars={0,10,20}	 
				s=ars[math.random(1,3)]
				if control==s then
					s=ars[math.random(1,3)]
				end	
				--colorin=arcolor[math.random(1,3)]
				moditam=math.random(60,110) --modificador de tamano circulos
				ary={'-8','-4','-2','0','2','4','8'}
				modiy=ary[math.random(1,7)]
				if control2==modiy then
					modiy=ary[math.random(1,7)]
				end	
				l=table.copy(line)
				bucle=math.floor(line.width)
					for z=0,bucle do
						pos2y=(y+modiy)+(s*math.sin(math.rad(pos2x)))
						l.start_time=modit
						l.end_time=l.start_time+(10)
						l.text="{"..an(5)..pos(pos2x,pos2y)..be(3)..alfa(1,alphax)..color(1,line.styleref.color1)..bord(0)..fscxy(moditam,moditam).."}"..p(2,Formas(2,1))
						pos2x=pos2x+1
						modit=l.end_time
						subs.append(l)
					end
				control=s
				control2=modiy
			end
		end
		
		if actor=="1" then	
			--Inicial
			l = table.copy(line)
			l.text = "{"..an(5)..fad(500,0)..pos(x,y)..estilo(1,line.styleref.color1).."}"..sil()
			l.start_time=line.start_time-500
			l.end_time=line.start_time
			l.layer=0
			subs.append(l)
					
			--FX DE SILABAS
			l = table.copy(line)
			l.text = "{"..an(5)..bord(0)..pos(x,y)..estilo(1,line.styleref.color1)..t(tt(inicio,fin)..bord(1)..blur(6))..t(tt(inicio,medio)..fscxy(140,140))..t(tt(medio,fin)..fscxy(100,100)).."}"..sil()
			l.layer=3
			subs.append(l)
			
			--salida
			l = table.copy(line)
			l.text = "{"..an(5)..fad(0,300)..pos(x,y)..estilo(1,line.styleref.color1).."}"..sil()
			l.start_time=line.end_time
			l.end_time=line.end_time+300
			l.layer=0
			subs.append(l)		
			
		elseif actor=='2' then
		--Silabas estaticas
			l.text = "{"..an(2)..bord(1)..fad(100,100)..blur(6).."}"..sil()
			l.start_time=line.start_time
			l.end_time=line.end_time
			l.layer=1
			subs.append(l)
		
		else
			
			--FX Inicial
			l = table.copy(line)
			l.text = "{"..an(5)..move(posix,y,x,y)..alpha('FF')..estilo(3,line.styleref.color3)..t(alpha('00')).."}"..sil()
			l.start_time=line.start_time-1000+tiempo
			l.end_time=line.start_time+tiempo
			l.layer=1
			subs.append(l)
			
			--Silabas estaticas
			l.text = "{"..an(5)..pos(x,y)..estilo(3,line.styleref.color3).."}"..sil()
			l.start_time=line.start_time+tiempo
			l.end_time=line.start_time+syl.start_time+syl.duration
			l.layer=1
			subs.append(l)
								
			--Fx silabas		
			l = table.copy(line)
			z=fin-inicio
			inicio=0
			fin=inicio+z
			medio=fin/2
			l.text = "{"..an(5)..bord(0)..pos(x,y)..estilo(1,line.styleref.color1)..t(tt(inicio,fin)..bord(1)..blur(6))..t(tt(inicio,medio)..fscxy(140,140))..t(tt(medio,fin)..fscxy(100,100)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer=1
			subs.append(l)
			
			--Estaticas 2
			l=table.copy(line)
			l.text = "{"..an(5)..bord(1)..pos(x,y)..blur(6)..estilo(3,line.styleref.color3).."}"..sil()
			l.start_time=line.start_time+syl.start_time+syl.duration
			l.end_time=line.end_time-500+tiempo
			l.layer=1
			subs.append(l)
			
			--Salida
			l = table.copy(line)
			l.text = "{"..an(5)..move(x,y,x,y+15)..bord(1)..blur(6)..alpha('00')..estilo(3,line.styleref.color3)..t(alpha('FF')..bord(0)..blur(0)).."}"..sil()
			l.start_time=line.end_time-500+tiempo
			l.end_time=line.end_time+tiempo
			l.layer=1
			subs.append(l)
				
		end
		
		posix=x-20		
		tiempo=tiempo+(1000/line.kara.n)
	end
	
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX Polyphonica OP", "", fx_poly)
aegisub.register_filter("FX Polyphonica OP", "", 2000, fx_poly)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------