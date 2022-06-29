include("zheolib.lua")
include("karaskel.lua")

script_name = "LUA FX"
script_description = "FX"
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
				(l.style == "op-romaji" or "este") then
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
local y=line.margin_v + 35
if i ==1 then
tiempo=0
end

function sil()
silaba = ""..syl.text_stripped..""
		return silaba
		end

-- fx 

l = table.copy(line)
l.text ="{"..an(5)..pos(x,y+10)..bord(3)..bord(3)..xbord(3)..ybord(3)..blur(5)..shad(2)..color(3,'&HFFFFFF&')..color(1,'&HFFFFFF&')..color(4,'&HFFFFFF&')..alfa(1,20)..alfa(3,50)..t(fscy(180)..fscx(120)).."}"..sil()
l.start_time=line.start_time + syl.start_time
l.end_time=l.start_time + syl.duration
l.layer = 1
subs.append(l)

--estatica

l = table.copy(line)
l.text ="{"..an(5)..pos(x,y+10)..bord(5)..xbord(5)..ybord(5)..be(1)..blur(2).."}"..sil()
l.start_time=line.start_time
l.end_time=line.start_time + syl.start_time
l.layer = 0
subs.append(l)



--- entrada

l = table.copy(line)
l.text ="{"..an(5)..move(x+800,y+10,x,y+10)..bord(5)..xbord(5)..ybord(5)..be(1)..blur(2).."}"..sil()
l.start_time=line.start_time - 400
l.end_time=line.start_time
l.layer = 0
subs.append(l)

-- move

l = table.copy(line)
l.text ="{"..an(5)..move(x,y+10,x-100,y+10)..bord(5)..xbord(5)..ybord(5)..be(1)..blur(2)..fad(0,500).."}"..sil()
l.start_time=line.start_time + syl.duration + syl.start_time
l.end_time=l.start_time+500
l.layer = 0
subs.append(l)

end	
end
		
		
		
		
aegisub.register_macro("FX", "", fx_lua)
aegisub.register_filter("FX", "", 2000, fx_lua)