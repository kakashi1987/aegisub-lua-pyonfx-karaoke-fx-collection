include("karaskel.lua")


function FX_4(subs)
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
local y=line.margin_v + 20
if i ==1 then tiempo=0
end

                                        l = table.copy(line)
                                        l.text = string.format("{\\bord1.5\\fad(150,0)\\an5\\1c&HDAD5A3&\\3c&H5B623F&\\move(%d,%d,%d,%d)}%s",x,y,x,y,syl.text_stripped)
                                        l.start_time = line.start_time -300+tiempo
                                        l.end_time=line.start_time+syl.start_time
                                        l.layer=1
                                        subs.append(l)

                   l = table.copy(line)
                   l.text = string.format("{\\an5\\pos(%d,%d)\\fad(0,200)\\bord1.5\\1c&HF4F1DC&\\3c&H5B623F&}%s",x,y,syl.text_stripped)
                   l.start_time=line.start_time+syl.start_time+80
                   l.end_time = l.end_time+50+tiempo+120
                   l.layer=1
                   subs.append(l)
                   l = table.copy(line)
                   l.text = string.format("{\\an5\\pos(%d,%d)\\fad(0,200)\\1a&HFF&\\bord2\\blur1.5\\1c&HF4F1DC&\\3c&H5B623F&}%s",x,y,syl.text_stripped)
                   l.start_time=line.start_time+syl.start_time+80
                   l.end_time = l.end_time+50+tiempo+120
                   l.layer=0
                   subs.append(l)

                                        l = table.copy(line)
                                        l.text = string.format("{\\be1\\an5\\move(%d,%d,%d,%d)\\1c&HB7B16A&\\3c&H5B623F&\\bord1.5\\shad0\\t(\\bord2\\blur1.5\\1c&HF4F1DC&\\3c&H5B623F&\\fscx120\\fscy155)\\t(\\bord2\\blur1.5\\1c&HF4F1DC&\\3c&H5B623F&\\fscx90\\fscy120)}%s", x,y,x,y+2, syl.text_stripped)
                                        l.start_time=line.start_time+syl.start_time
                                        l.end_time=l.start_time+syl.duration
                                        l.layer = 1
                                        subs.append(l)


                   l = table.copy(line)
                   l.text = string.format("{\\fad(10,150)\\pos(%d,%d)\\an5\\bord0\\be1\\1c&H5B623F&\\frx60\\move\\fscx140\\fscy100\\t(\\be1\\1a&H55&\\fscx180\\fscy140)}{\\p1}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 m 10 1 b 15 1 19 6 19 10 b 18 17 14 19 10 19 b 7 19 2 18 1 10 b 1 6 4 1 10 1 {\\p0}",x,y+12+syl.duration/300,syl.text_stripped)
                   l.start_time=line.start_time+syl.start_time
                   l.end_time=l.start_time+syl.duration+tiempo+130
                   l.layer=0
                   subs.append(l)
                   l = table.copy(line)
                   l.text = string.format("{\\fad(10,150)\\pos(%d,%d)\\an5\\1a&H55&\\bord0\\be0.5\\1c&H5B623F&\\frx60\\move\\fscx140\\fscy100\\t(\\be1\\1a&H55&\\fscx180\\fscy140)}{\\p1}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 m 10 1 b 15 1 19 6 19 10 b 18 17 14 19 10 19 b 7 19 2 18 1 10 b 1 6 4 1 10 1 {\\p0}",x,y+12+syl.duration/300,syl.text_stripped)
                   l.start_time=line.start_time+syl.start_time
                   l.end_time=l.start_time+syl.duration+tiempo+130
                   l.layer=0
                   subs.append(l)		

    end
end


aegisub.register_filter("FX_4", "~ALKOON~", 2009, FX_4)