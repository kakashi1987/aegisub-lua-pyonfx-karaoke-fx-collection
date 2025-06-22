include("karaskel.lua")

--# *syl.duration/340
--# Úä ØÑíŞ ÖÑÈ ÓÇíá ÏæÑíÔä + ÊŞÓíãåÇ ÈÚÏÏ ¡íÈÊÚÏ ÇáÍÑİ Ãæ ÇáÑÓãÉ Úä ãßÇäåÇ ÈÔÏÉ äØŞ ÇáãÛäí
--# ßáãÇ ÒÏäÇ ÊŞÓíã ÇáÏæÑíÔä ÈÚÏÏ ÃßÈÑ : Şá äÓÈÉ ÇÈÊÚÇÏ ÇáÍÑİ æÇáÚßÓ ÕÍíÍ

function FX_7(subs)
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
local y=line.margin_v + 20
if i ==1 then tiempo=0
end


		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\bord1.5\\3c&H7E7F7A&\\1c&HECEDEC&}%s",x,y,syl.text_stripped)
		l.start_time = line.start_time+tiempo-100
		l.end_time = line.start_time+syl.start_time
		l.layer=4
		subs.append(l)		
		l = table.copy(line)
		l.text = string.format("{\\fad(0,100)\\an5\\pos(%d,%d)\\bord1.5\\3c&H6F7C72&\\1c&HE8E8E8&}%s",x,y,syl.text_stripped)
		l.start_time = line.start_time+syl.start_time
		l.end_time = l.end_time+270
		l.layer=2
		subs.append(l)
		l = table.copy(line)
		l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\bord1.5\\shad0\\1c&FFFFFF&\\3c&HFFFFFF&\\t(\\bord2\\xbord10\\blur20)}%s", x, y,x,y,syl.text_stripped)
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration+400
		l.layer = 3
		subs.append(l)
 		 random_pos = math.random(100,200)	
 		 l = table.copy(line)
 		 for i=0,40 do
 		 l.layer=4
 		 l.text = string.format("{\\fad(0,200)\\move(%d,%d,%d,%d)\\an5\\shad0\\bord1\\blur2\\3c&HFFFFFF&\\1c&HFFFFFF&\\t(\\fscx%d\\fscy%d)}{\\p%d}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 {\\p0}",x-math.random(-20,20)*syl.duration/340,y-math.random(-6,6)*syl.duration/340,x+math.random(-35,25)*syl.duration/230,y+math.random(-25,35)*syl.duration/230,random_pos,random_pos,math.random(4,6))
 		 l.start_time=line.start_time+syl.start_time
  		 l.end_time=l.start_time+syl.duration+math.random(200,400)+600
  		 l.start_time=l.start_time+i
  		 subs.append(l)
   		 end
                 end
end

aegisub.register_filter("FX_7", "~ALKOON~", 2009, FX_7)