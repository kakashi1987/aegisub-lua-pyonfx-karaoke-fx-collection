include("karaskel.lua")

script_name = "Betterflise"
script_description = "FX lua"
script_author = "KFDS"
script_version = "1"

function fx_KFDS(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect... (%d/%d)", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Default" or l.style == "Romaji" or l.style == "4") then
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Betterflise")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_KFDS")
end

function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 40
if i == 1 then
end


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d,0,500)\\fad(100,0)\\alpha&Haa&\\1c&H5887EF&\\3c&H0A379D&\\fry0\\frz0\\frz0\\fscx0\\fscy0\\alpha&Hbf&\\t(80,150,\\frx0\\fscy0\\frz0\\fry0\\fscx100)\\t(150,250,\\fscy100\\fscx100)\\t(250,400,)}%s",x+math.random(250,350),y,x,y,syl.text_stripped)
l.start_time = line.start_time-400+i*100
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d,0,500)\\fad(100,0)\\alpha&Haa&\\1c&H5887EF&\\3c&H0A379D&\\fry0\\frz0\\frz0\\fscx0\\fscy0\\alpha&Hbf&\\t(80,150,\\frx0\\fscy0\\frz0\\fry0\\fscx100)\\t(150,250,\\fscy100\\fscx100)\\t(250,400,)}%s",x+math.random(200,300),y,x,y,syl.text_stripped)
l.start_time = line.start_time-400+i*100
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d,0,500)\\fad(100,0)\\alpha&Haa&\\1c&H5887EF&\\3c&H0A379D&\\fry0\\frz0\\frz0\\fscx0\\fscy0\\alpha&Hbf&\\t(80,150,\\frx0\\fscy0\\frz0\\fry0\\fscx100)\\t(150,250,\\fscy100\\fscx100)\\t(250,400,)}%s",x+math.random(250,380),y,x,y,syl.text_stripped)
l.start_time = line.start_time-400+i*100
l.end_time = line.start_time+syl.start_time
l.layer=2
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d,0,500)\\fad(100,0)\\alpha&Haa&\\1c&H5887EF&\\3c&H0A379D&\\fry0\\frz0\\frz0\\fscx0\\fscy0\\alpha&Hbf&\\t(80,150,\\frx0\\fscy0\\frz0\\fry0\\fscx100)\\t(150,250,\\fscy100\\fscx100)\\t(250,400,)}%s",x+math.random(200,300),y,x,y,syl.text_stripped)
l.start_time = line.start_time-400+i*100
l.end_time = line.start_time+syl.start_time
l.layer=3
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d,0,500)\\fad(200,0)\\1c&H5887EF&\\3c&H0A379D&\\fry0\\frz0\\frz0\\fscx0\\fscy0\\alpha&Hbf&\\t(80,150,\\frx0\\fscy0\\frz0\\fry0\\fscx100)\\t(150,250,\\fscy100\\fscx100)\\t(250,400,\\alpha&H00&)}%s",x+math.random(200,300),y,x,y,syl.text_stripped)
l.start_time = line.start_time-400+i*100
l.end_time = line.start_time+syl.start_time
l.layer=4
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\be1}{\\an5\\move(%d,%d,%d,%d)\\fad(0,50)\\bord0\\fscy100\\fscx100\\1a&H00&\\t(\\bord1\\1c&HFADDAB&\\1a&H00&\\frz-45\\3c&HEAFFDF&)}%s",x,y,x-200,y-30,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.start_time
l.layer=5
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(200,50)\\bord1\\fscy100\\fscx100\\1a&Hff&\\3c&HFFFFFF&}%s",x,y,x,y,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.start_time
l.layer=6
subs.append(l)


l = table.copy(line)
random_frz = math.random(-8,8)
random_frz1 = math.random(-10,10)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c&HF67BE8&\\bord0.3\\fad(0,1000)\\frz%d\\fry0\\frx0\1a&H0a&\t(100,600,\frz0\bord1\fscy100\fscx100)\3c&H61008B&\frz%d}%s",x,y,random_frz,random_frz1,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.start_time
l.layer=7
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\move(%d,%d,%d,%d)}{\\an5\\1c&HB300FF&\\alpha&H00&\\shad0\\bord0.5\\fnMariposa\\fs30\\pos(495,272)}{\\t(0,100,\\fscx40)\\t(100,200,\\fscx100)\\t(200,300,\\fscx40)\\t(300,400,\\fscx100)\\t(400,500,\\fscx40)\\t(500,600,\\fscx100)\\t(600,700,\\fscx40)\\t(700,800,\\fscx40)\\t(800,900,\\fscx100)\\t(900,1000,\\fscx40)\\t(1000,1100,\\fscx100)\\t(1100,1200,\\fscx40)\\t(1200,1300,\\fscx100)\\t(1300,1400,\\fscx40)\\t(1400,1500,\\fscx40)\\t(1500,1600,\\fscx100)\\t(1600,1700,\\fscx40)\\t(1700,1800,\\fscx100)\\t(1800,1900,\\fscx40)\\t(1900,2000,\\fscx40)\\t(2000,2100,\\fscx100)\\t(2100,2200,\\fscx40)}{\\frz65}{\\fad(0,300)}L",x-10,y,x-200,y-30,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.start_time
l.layer=8
subs.append(l)



l = table.copy(line)
l.text = string.format("{\\move(%d,%d,%d,%d)}{\\an5\\1c&HB300FF&\\alpha&H00&\\shad0\\bord0\\fnMariposa\\fs30\\pos(495,272)\\c&H00FFF1&}{\\t(0,100,\\fscx40)\\t(100,200,\\fscx100)\\t(200,300,\\fscx40)\\t(300,400,\\fscx100)\\t(400,500,\\fscx40)\\t(500,600,\fscx100)\\t(600,700,\\fscx40)\\t(700,800,\\fscx40)\\t(800,900,\\fscx100)\\t(900,1000,\\fscx40)\\t(1000,1100,\\fscx100)\\t(1100,1200,\\fscx40)\\t(1200,1300,\\fscx100)\\t(1300,1400,\\fscx40)\\t(1400,1500,\\fscx40)\\t(1500,1600,\\fscx100)\\t(1600,1700,\\fscx40)\\t(1700,1800,\\fscx100)\\t(1800,1900,\\fscx40)\\t(1900,2000,\\fscx40)\\t(2000,2100,\\fscx100)\\t(2100,2200,\\fscx40)}{\\frz65}{\\fad(0,300)}L",x-10,y,x-200,y-30,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.start_time
l.layer=9
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\move(%d,%d,%d,%d)}{\\an5\\alpha&H00&\\shad0\\bord0\\fnMariposa\\fs30\\pos(495,272)\\1c&HFFC300&\\be25}{\\t(0,100,\\fscx40)\\t(100,200,\\fscx100)\t(200,300,\\fscx40)\\t(300,400,\fscx100)\\t(400,500,\\fscx40)\\t(500,600,\\fscx100)\\t(600,700,\\fscx40)\\t(700,800,\\fscx40)\\t(800,900,\\fscx100)\\t(900,1000,\\fscx40)\\t(1000,1100,\\fscx100)\\t(1100,1200,\\fscx40)\\t(1200,1300,\\fscx100)\\t(1300,1400,\\fscx40)\\t(1400,1500,\\fscx40)\\t(1500,1600,\\fscx100)\\t(1600,1700,\\fscx40)\\t(1700,1800,\\fscx100)\\t(1800,1900,\\fscx40)\\t(1900,2000,\\fscx40)\\t(2000,2100,\\fscx100)\\t(2100,2200,\\fscx40)}{\\frz65}{\\fad(0,300)}{\\be22}L",x-10,y,x-200,y-30,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.start_time
l.layer=10
subs.append(l)


l = table.copy(line)
random_frz = math.random(-4,4)
l.text = string.format("{\\an5\\be0\\pos(%d,%d)\\1c&H0A2893&\\bord0\\fad(0,1000)\\frz%d\\fry0\\frx0\\t(100,600,\\frx5\\bord0\\fscy100\\fscx100\\1a&haf&)}%s",x,y,random_frz,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.start_time
l.layer=11
subs.append(l)


end
end

aegisub.register_macro("Betterflise", "", fx_KFDS)
aegisub.register_filter("Betterflise", "", 2000, fx_KFDS)