
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--#  √ÀÌ— ÕÊ· ﬂÌ›Ì… Ã⁄· ÿ—Ìﬁ… «·œŒÊ· Ê«·Œ—ÊÃ »‘ﬂ· „ „ÊÃ √Ê »‘ﬂ· √›⁄Ê«‰Ì ⁄‰ ÿ—Ìﬁ ﬂÊœ " org " ‹  #--
-------------------------------------------------------------------------------------------------------------------------------------------------------------  
include "karaskel-auto4.lua"
script_name = "FX_LUA.4_05"
script_description = "Efftec Op and End"
script_author = "Alkoon"
script_version = "1.0"

function FX_LUA_ALKOON_UNIVERSO(subs)
	local meta, styles = karaskel.collect_head(subs)	
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
       	aegisub.progress.task(string.format("Applying FX.. (%d,%d)...", ai, maxai))		
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
local msoms = 500
local x=syl.center + line.left
local y=line.margin_v + 20
if i == 1 then  universe = 0
end
		local l = table.copy(line)
		l.text = string.format("{\\an5\\org(%d,%d)\\bord0.5\\move(%d,%d,%d,%d)\\fad(200,0)\\1c&HFFFFFF&\\3c&H000000&\frz300\\fscx100\\fscy100\\t(\\fscx150\\frz-60\\fscy150\\frx100\\fry150\\frz%d)\\t(\\fscx100\\fscy100\\frx0\\fry0\\frz0)}%s",160,y+80,x+52,y+100, x, y,syl.duration/500,syl.text_stripped)
		l.start_time=l.start_time - 500 + universe
		l.end_time = line.start_time+  universe
		subs.append(l)
		local l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\shad0\\bord0.7\\1c&HFFFFFF&\\3c&H000000&\\t(\\1c&HEFC39A&)}%s", x, y, syl.text_stripped)
		l.start_time=line.start_time+  universe
		l.end_time = l.end_time+  universe
		subs.append(l)
		local l = table.copy(line)
		l.text = string.format("{\\org(%d,%d)\\an5\\bord0.5\\move(%d,%d,%d,%d)\\fad(0,300)\\1c&HEFC39A&\\3c&H000000&\\t(\\frz150)\\fscx100\\fscy100\\t(\\frx50\\fry50\\fscx100\\fscy100\\frz100)\\t(\\frx0\\fry0\\fscx100\\fscy100\\frz170)\\t(\\bord0\\be3)\\t(\\be4)}%s" ,x,y+50, x,y,250,120,syl.text_stripped)
		l.start_time = l.end_time+  universe
		l.end_time = l.start_time+ universe + msoms
		subs.append(l)
           universe= universe+(500/line.kara.n)
    end
end

aegisub.register_filter("FX_LUA_ALKOON_UNIVERSO", "~ALKOON~", 2000, FX_LUA_ALKOON_UNIVERSO)