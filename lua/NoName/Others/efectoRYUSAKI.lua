include("zheolib.lua")
include("karaskel.lua")

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
local y=line.margin_v + 25
if i ==1 then
tiempo=0
end
function sil()
silaba = ""..syl.text_stripped..""
		return silaba
		end	
		

randfrx=math.random(-1200,1200)

colores ={'&HACEE98&', '&HE49031&', '&HD1B382&'}
rand_color= colores[math.random(1,3)]
colores2 ={'&HE49031&', '&HD1B382&', '&HACEE98&'}
rand_color2= colores[math.random(1,3)]
colores3 ={'&HD1B382&', '&HACEE98&', '&HE49031&'}
rand_color3= colores[math.random(1,3)]
     

			
---- FX INICIAL
l = table.copy(line)
l.text ="{"..an(5)..move(0,0,x,y)..shad(0)..bord(2)..color(3,'&HDEA932&')..frx(randfrx)..t(frx(0)).."}"..sil()
l.start_time=line.start_time - 1500
l.end_time=line.start_time
l.layer = 0
subs.append(l)
		

--SILABAS ESTATICAS
l = table.copy(line)
		l.text = "{"..an(5)..pos(x,y)..shad(0)..frx(0)..color(3,'&HDEA932&').."}"..sil()
		l.start_time=line.start_time
        l.end_time=l.start_time+syl.start_time 
		subs.append(l)
		l.layer = 0


---FX
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..fscx(100)..color(1,rand_color)..fscy(100)..color(3,'&HFFFFFF&')..t(fscx(150)..fscy(150)..blur(5)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 3
subs.append(l)

---FX 2

l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..fax(0)..t(fax(-1))..color(1,rand_color2)..color(3,'&HFFFFFF&')..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)


---FX 2

l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..fax(0)..t(fax(1))..color(1,rand_color2)..color(3,'&HFFFFFF&')..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)



l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..fscx(80)..fscy(80)..frz(0)..color(1,rand_color3)..color(3,'&HFFFFFF&')..t(frz(360))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 1
subs.append(l)


end
end





	
aegisub.register_macro("FX", "", fx_lua)
aegisub.register_filter("FX", "", 2000, fx_lua)