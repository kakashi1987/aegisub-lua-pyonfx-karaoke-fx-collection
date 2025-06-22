------------------------------------------------------------
--# ﬂÌ› ‰€Ì— ·Ê‰ «·≈” «Ì· ›Ì Õ«·  €Ì— Œ·›Ì… «·›ÌœÌÊ« #--
--# Simple Efecto, and Just for experimento
-----------------------------------------------------------
include "karaskel-auto4.lua"
script_name = "FX_10"
script_description = "FX_LUA.4"
script_author = "ALKOON"

function FX_LUA_Colors_Change(subs)
	local meta, styles = karaskel.collect_head(subs)	
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
       	aegisub.progress.task(string.format("Applying effect (%d,%d)...", ai, maxai))		
       	aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" then karaskel.preproc_line(subs, meta, styles, l)
		do_fx(subs, meta, l)
		maxi = maxi - 1
		subs.delete(i)
		else 
		i = i + 1
		end
		ai = ai + 1
	end
end


function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 26
if i == 1 then  universe = 0
end
		local l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(100,0)\\shad0\\bord1\\be1.5\\be2.5\\3c&H000000&\\1c&HE8F1F4&\\t(200,350,\\bord1.5\\be3\\3c&H708B96&\\1c&H81CDE4&)\\t(360,0,\\bord1.5\\be3\\3c&H000000&\\1c&H31819C&)}%s", x, y, syl.text_stripped)
		l.start_time=line.start_time-160+  universe
		l.end_time=line.start_time+syl.start_time
		l.layer = 1
		subs.append(l)
		local l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(0,50)\\shad0\\bord1\\be2.5\\3c&H000000&\\1c&H89A0A8&\\t(400,0,\\1c&HFFFFFF&)}%s", x, y, syl.text_stripped)
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.end_time+50+  universe
		l.layer =2
		subs.append(l)


 if syl.duration < 270 then 
      l = table.copy(line)
      l.start_time=line.start_time+syl.start_time
      l.end_time=l.start_time+syl.duration
      l.text = string.format("{\\be2\\blur2\\bord1\\an5\\move(%d,%d,%d,%d)\\1c&HADC2C9&\\t(\\blur5.7\\bord3)}%s",x,y,x,y,syl.text_stripped)
      l.layer=3
     subs.append(l)
else if syl. duration >400 then
      l = table.copy(line)
      l.start_time=line.start_time+syl.start_time
      l.end_time=l.start_time+syl.duration
      l.text = string.format("{\\be2\\blur2\\bord1\\an5\\move(%d,%d,%d,%d)\\1c&H7298A6&\\3c&FFFFFF&\\t(\\blur5.7\\bord3)}%s",x,y,x,y,syl.text_stripped)
      l.layer=3
     subs.append(l)
else
      l = table.copy(line)
      l.start_time=line.start_time+syl.start_time
      l.end_time=l.start_time+syl.duration
      l.text = string.format("{\\be2\\blur2\\bord1\\an5\\move(%d,%d,%d,%d)\\1c&FFFFFF&\\3c&H7298A6&\\t(\\blur5.7\\bord3)}%s",x,y,x,y,syl.text_stripped)
      l.layer=3
     subs.append(l)
 end
     end
end
     end

aegisub.register_filter("FX_10", "ALKOON_UNIVERSO", 2009, FX_LUA_Colors_Change)