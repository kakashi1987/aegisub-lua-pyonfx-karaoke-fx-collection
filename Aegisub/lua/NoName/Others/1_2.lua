----<><><><><><><><><><><><>---<><><><><><><><><><>---<><><><><><><><><><>---
--# Esmaeel almansoori_(~alkoon_Universo~)_ al-koon-11@hotmail.com
----<><><><><><><><><><><><>---<><><><><><><><><><>---<><><><><><><><><><>---

include("karaskel.lua")

script_name = "Future Windy Blur"
script_description = "Highlights blown away by the winds of change."
script_author = "jfs.(FX'ALKOON')" 
script_modified = "alkoon_9:33_Thursday_ PM 8/6/2009" 


function new_windy_blur(subs) 
	local meta, styles = karaskel.collect_head(subs)	
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
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
	local y=line.margin_v + 25 
	if i == 1 then alkoon = 0
	end
	local l = table.copy(line)
	l.text = string.format("{\\pos(%d,%d)\\an5}%s",x,y,syl.text_stripped)
	l.start_time=line.start_time
	l.end_time=line.start_time+syl.start_time
	l.layer = 1
	subs.append(l)
	local l = table.copy(line)
		 l.start_time = line.start_time + syl.start_time
		 if syl.duration < 750 then
			l.end_time = l.start_time + 1500
			else
			l.end_time = l.start_time + syl.duration * 2+alkoon
			end
			l.layer = 2
			local temp = string.format("{\\p1\\be1\\move(%d,%d,%%d,%%d)\\fad(0,70)\\an5\\shad0\\bord0\\3a&H44&\\1cHFFFFFF&\\3cHFFFFFF&\\fscx20\\fscy20\\shad0}m 50 49 l 100 0 l 51 50 l 100 100 l 50 51 l 0 100 l 49 50 l 0 0 m 45 45 {\\p0\\t(\\bord0.5\\3a&H55&\\blur1.6)}", line.left+syl.center, line.middle)
			for j = -10,30 do
			l.text = string.format(temp, line.left+syl.center+math.cos(math.rad(j*70))*40, line.middle+math.sin(math.rad(j*30))*20) --#math.sin(math.rad(j*50))*20)
			subs.append(l)
			end	
		l = table.copy(line)
		l.start_time=line.start_time+syl.start_time
		l.end_time = l.start_time + syl.duration+alkoon
		l.text =string.format("{\\move(%d,%d,%d,%d)\\an5\\fad(0,50)\\shad0\\be0.7\\bord0\\1c&HFFFFFF&\\t(\\be2\\frx60\\1a&HAA)}%s",x,y,x-50,y,syl.text_stripped)
		l.layer=3
		subs.append(l)                   
          end
end

aegisub.register_filter("Future Windy Blur", "~ALKOON~", 2000, new_windy_blur)
