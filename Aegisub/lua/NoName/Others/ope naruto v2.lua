include("zheolib.lua")
include("karaskel.lua")
include("formaslib.lua")

script_name = "LUA FX"
script_description = "Mi primer FX"
script_author = "Riuuzaki"
script_version = "1.0"

function fx_lua(subs)
	aegisub.progress.task("ESPERA MIENTRAS SE APLICA EL EFECTO")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Creando FX")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("(%d/%d)", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "efecto") then
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("PROCESO TERMINADO")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_lua")
	end
	
	
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 30
if i ==1 then
tiempo=0
end
function sil()
silaba = ""..syl.text_stripped..""
		return silaba
		end	
		

randfrx=math.random(-1200,1200)

colores ={'&HB1938A&', '&HE49031&', '&H77432C&'}
rand_color= colores[math.random(1,3)]
colores2 ={'&HE49031&', '&H77432C&', '&HB1938A&'}
rand_color2= colores[math.random(1,3)]
   
	 
	 		
---- FX INICIAL
if line.actor == 'diferente' then
l = table.copy(line)
l.text ="{"..an(5)..pos(x,y)..shad(0)..bord(2)..color(3,'&HDEA932&')..fad(100,0).."}"..sil()
l.start_time=line.start_time - 200
l.end_time=line.start_time
l.layer = 0
subs.append(l)

else		
		
---- FX INICIAL
l = table.copy(line)
l.text ="{"..an(5)..move(0,0,x,y)..shad(0)..bord(2)..color(3,'&HDEA932&')..frx(randfrx)..t(frx(0)).."}"..sil()
l.start_time=line.start_time - 1500
l.end_time=line.start_time
l.layer = 0
subs.append(l)
end

--SILABAS ESTATICAS
l = table.copy(line)
		l.text = "{"..an(5)..pos(x,y)..shad(0)..frx(0)..color(3,'&HDEA932&').."}"..sil()
		l.start_time=line.start_time
        l.end_time=l.start_time+syl.start_time 
		subs.append(l)
		l.layer = 0


---FX SILABAS arriba

l = table.copy(line)
l.text = "{"..an(5)..color(1,rand_color)..color(3,'&HFFFFFF&')..blur(5)..t(frz(140)..move(x,y,x,y+30)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)


---FX SILABAS abajo

l = table.copy(line)
l.text = "{"..an(5)..color(1,rand_color)..color(3,'&HFFFFFF&')..blur(5)..t(frz(-140)..move(x,y,x,y-30)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)



--- shuriken

l = table.copy(line)
l.text = "{"..an(5)..move(x-20,y,x,y)..frz(0)..fscxy(150)..color(1,'&H787878&')..t(frz(140))..blur(2).."}"..p(2,'m 20 0 b 20 10 30 20 40 20 b 30 20 20 30 20 40 b 20 30 10 20 0 20 b 10 20 20 10 20 0 m 25 20 b 24 17 23 16 20 15 b 17 16 16 17 15 20 b 16 23 17 24 20 25 b 23 24 24 23 25 20 ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 1
subs.append(l)

--Particulas
	
	l = table.copy(line)
	for f=0,30 do --serian 30 cuadritos !! xD
	l.text = "{"..an(5)..move(x,y, x-rand(30,80), y+rand(10,40))..blur(4)..bord(0.3)..be(2)..c(3, 'ffffff')..RangeColor(1, f/30, 'B1938A', '77432C').."}"..p(4,Formas(17)) -- USE FORMASLIB !
	l.start_time = line.start_time+syl.start_time
	l.end_time = l.start_time+syl.duration+rand(600)
	l.layer=0
	subs.append(l)
	end

end
end

aegisub.register_macro("FX", "", fx_lua)
aegisub.register_filter("FX", "", 2000, fx_lua)