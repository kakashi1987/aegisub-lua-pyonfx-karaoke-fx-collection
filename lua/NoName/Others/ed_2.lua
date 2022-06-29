include("karaskel.lua")
include("zheolib.lua")
include("formaslib.lua")
-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Polyphonica ED"
script_description = "FX Polyphonica ED"
script_author = "nickle"
script_version = "0.9"

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
		local x
		local y
		actor=line.actor
		if i ==1 then
			tiempo=0
			modi=0
			posix=0
		end
		if actor=="1" then --kanji
			temp=((480-line.width)/2.7)
			y= temp + syl.height+modi
			x=17
			modi=y-temp
			else--resto
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
		--efecto largo
		inline=syl.inline_fx
		if inline=="part" then
		 --particulas
			l=table.copy(line)
			tstart=0
			tend=0
			pos2x=line.left
			modiy=rand(5)
			bucle=math.floor(line.width)
			s=math.random(7,13)
			for u=0,2 do
				for z=0,bucle do
				 pos2y=(y+modiy)+(s*math.sin(math.rad(pos2x)))
				 l.start_time=line.start_time+syl.start_time+tstart
				 l.end_time=line.start_time+line.duration/3+tend
				 --borde
				 l.text="{"..an(5)..pos(pos2x,pos2y)..blur(4)..alfa(1,'FF')..color(3,'FFDE15')..alpha('80')..fscx(150)..fscy(150)..bord(1)..t(alpha('FF')).."}"..p(1,'m 0 0 l 1 0 1 1 0 1')
				 subs.append(l)
				 --relleno
				 l.text="{"..an(5)..pos(pos2x,pos2y)..be(1)..color(1,line.styleref.color3)..fscx(200)..fscy(200)..bord(0)..t(alpha('FF')).."}"..p(1,'m 0 0 l 1 0 1 1 0 1')
				 subs.append(l)
				 tstart=tstart+10
				 tend=tend+10
				 pos2x=pos2x+1
				 subs.append(l)
				end
			end	
		end
		
		if actor=="1" then	--Kanji
			--Inicial
			l = table.copy(line)
			l.text = "{"..an(5)..alpha('FF')..move(-5,y,x,y)..t(alpha('00'))..estilo(1,line.styleref.color3)..estilo(3,line.styleref.color1).."}"..sil()
			l.start_time=line.start_time-800+tiempo
			l.end_time=line.start_time+tiempo
			l.layer=0
			subs.append(l)
					
			--Estatico DE SILABAS
			l.text = "{"..an(5)..pos(x,y)..alpha('00').."}"..sil()
			l.start_time=line.start_time+syl.start_time+syl.duration/2
			l.end_time=line.end_time-500+tiempo
			l.layer=1
			subs.append(l)
			
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color3)..estilo(3,line.styleref.color1).."}"..sil()
			l.start_time=line.start_time+tiempo
			l.end_time=line.start_time+syl.start_time
			l.layer=1
			subs.append(l)
			
			l=table.copy(line)
			ttt2=fin-inicio
			inicio2=0
			fin2=inicio2+ttt2
			medio2=fin2/2				
			l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color3)..alpha('00')..estilo(3,line.styleref.color1)..t(tt(inicio2,medio2)..bord(4)..blur(4)..fscx(110)..fscy(110))..t(tt(medio2,fin2)..bord(0)..blur(0)..alpha('FF')..fscx(100)..fscy(100)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.start_time+syl.duration
			l.layer=3
			subs.append(l)
							
			--salida
			l = table.copy(line)
			l.text = "{"..an(5)..move(x,y,-5,y)..t(alpha('FF')).."}"..sil()
			l.start_time=line.end_time-500+tiempo
			l.end_time=line.end_time+tiempo
			l.layer=0
			subs.append(l)		
			
		elseif actor=='2' then --traduccion
		--Silabas estaticas
			l.text = "{"..an(2)..bord(1)..fad(100,100).."}"..sil()
			l.start_time=line.start_time
			l.end_time=line.end_time
			l.layer=1
			subs.append(l)
		
		else
			 			
			--FX Inicial
			l = table.copy(line)
			l.text = "{"..an(5)..move(x,0,x,y)..fry(35)..frx(90)..alpha('FF')..estilo(1,line.styleref.color3)..estilo(3,line.styleref.color1)..t(alpha('00')..fry(0)..frx(0)).."}"..sil()
			l.start_time=line.start_time-1000+tiempo
			l.end_time=line.start_time+tiempo
			l.layer=1
			subs.append(l)
			
			--Silabas estaticas
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..alpha('00').."}"..sil()
			l.start_time=line.start_time+syl.start_time+syl.duration/2
			l.end_time=line.end_time-500+tiempo
			l.layer=1
			subs.append(l)
			
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color3)..estilo(3,line.styleref.color1).."}"..sil()
			l.start_time=line.start_time+tiempo
			l.end_time=line.start_time+syl.start_time
			l.layer=1
			subs.append(l)
			--particulas slilabas
			longitud=syl.width
			if longitud >0 then
				point=0
				--modificador de la aplitud
				modamp=rand(15,25)
				modamp2=rand(15,25)
				--mod tiempo
				otrot=syl.duration/10
				mod1x=rand(5)
				mod2x=rand(5)
				--modificadores angulo
				modang1=math.random(120)
				modang2=rand(30,200)
				--random para el tiempo
				randt=math.random(300,700)
				for r=0,2 do
					for tt=0,60 do				
						l=table.copy(line)
						l.start_time=line.start_time+syl.start_time+otrot
						l.end_time=l.start_time+randt+point
						pos3x=(x+mod1x)+(modamp*math.cos(math.rad(3*(tt+modang1))))
						pos3y=(y+mod1x)+(modamp*math.cos(math.rad(4*(tt+modang1))))
						 --borde
						 l.text="{"..an(5)..pos(pos3x,pos3y)..blur(4)..alfa(1,'FF')..color(3,'FFDE15')..alpha('80')..fscx(150)..fscy(150)..bord(1)..t(alpha('FF')).."}"..p(1,'m 0 0 l 1 0 1 1 0 1')
						 subs.append(l)
						 --relleno
						 l.text="{"..an(5)..pos(pos3x,pos3y)..be(1)..color(1,line.styleref.color3)..fscx(200)..fscy(200)..bord(0)..t(alpha('FF')).."}"..p(1,'m 0 0 l 1 0 1 1 0 1')
						 subs.append(l)
						subs.append(l)
						
						l=table.copy(line)
						l.start_time=line.start_time+syl.start_time+otrot+200
						l.end_time=l.start_time+randt+point
						pos3x=(x+mod2x)+(modamp2*math.cos(math.rad(3*((tt+modang2)+60))))
						pos3y=(y+mod2x)+(modamp2*math.cos(math.rad(4*((tt+modang2)+60))))
						 --borde
						 l.text="{"..an(5)..pos(pos3x,pos3y)..blur(4)..alfa(1,'FF')..color(3,'FFDE15')..alpha('80')..fscx(150)..fscy(150)..bord(1)..t(alpha('FF')).."}"..p(1,'m 0 0 l 1 0 1 1 0 1')
						 subs.append(l)
						 --relleno
						 l.text="{"..an(5)..pos(pos3x,pos3y)..be(1)..color(1,line.styleref.color3)..fscx(200)..fscy(200)..bord(0)..t(alpha('FF')).."}"..p(1,'m 0 0 l 1 0 1 1 0 1')
						 subs.append(l)
						subs.append(l)
						otrot=otrot+5
						point=point+10
					end
				end
				--Boom!			
				l=table.copy(line)
				for g=0,200 do	
					pospx=x+rand(3)
					pospy=y+rand(3)
					GenCirculo(1,pospx,pospx,math.rad(g+2),rand(10,25))
					l.text = "{"..an(5)..fad(0,70)..bord(0.1)..move(pospx,pospy,pospx+rand(20),pospy+rand(20))..estilo(1,line.styleref.color3)..estilo(3,line.styleref.color1).."}"..p(1,Formas(1))
					l.start_time=line.start_time+syl.start_time+syl.duration/2
						if syl.duration>4000 then
						l.end_time=l.start_time+(syl.duration/2.5)
						elseif syl.duration<120 then
						l.end_time=l.start_time+syl.duration+rand(syl.duration)+50
						else
						l.end_time=l.start_time+syl.duration+rand(syl.duration/2)
						end
					l.layer=2
					subs.append(l)
				end
			end
						
			l=table.copy(line)
			ttt=fin-inicio
			inicio=0
			fin=inicio+ttt
			medio=fin/2				
			l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color3)..alpha('00')..estilo(3,line.styleref.color1)..t(tt(inicio,medio)..bord(4)..blur(4)..fscx(110)..fscy(110))..t(tt(medio,fin)..bord(0)..blur(0)..alpha('FF')..fscx(100)..fscy(100)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.start_time+syl.duration
			l.layer=3
			subs.append(l)
					
			--Salida
			l = table.copy(line)
			l.text = "{"..an(5)..move(x,y,x,y+15)..alpha('00')..t(alpha('FF')).."}"..sil()
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
aegisub.register_macro("FX Polyphonica ED", "", fx_poly)
aegisub.register_filter("FX Polyphonica ED", "", 2000, fx_poly)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------