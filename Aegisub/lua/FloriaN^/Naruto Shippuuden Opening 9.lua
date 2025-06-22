include("karaskel.lua")

script_name = "Naruto Shippuuden Opening X"

script_description = "wakaranai"

script_author = "FloriaN"

script_version = "beta v2"

function naru(subs)
	local meta, styles = karaskel.collect_head(subs)
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

function do_fx(subs, meta, line, styles)
   for i = 1, line.kara.n do
   
		local syl = line.kara[i]
		local x = line.left + syl.center
		local xl=line.center
		local y = line.middle
		local time1=line.kara.n*50
		local l=table.copy(line)
		local lf=line.left
		local lr=line.right
		local lh=line.height
		local lw=line.width
   
for j=0,02 do
colors={'HB17738', 'HF9EDD1'}
rand_color= colors[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy160\\be10\\bord0\\3c&H86AEC1&)\\t(\\be60\\fscy240\\fscx240)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = line.start_time + syl.end_time + 300
l.end_time = line.start_time + syl.end_time + 600+math.random(200,300)+math.random(0,100)
l.layer=4
subs.append(l)
end
for j=0,02 do
colors={'HB17738', 'HF9EDD1'}
rand_color= colors[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy110\\be10\\bord0\\3c&H86AEC1&)\\t(\\be80\\fscy220\\fscx220)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = line.start_time + syl.end_time + 300
l.end_time = line.start_time + syl.end_time + 600+math.random(0,100)
l.layer=4
subs.append(l)
end
for j=0,02 do
colors={'HB17738', 'HF9EDD1'}
rand_color= colors[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy80\\be10\\bord0\\3c&H86AEC1&)\\t(\\be90\\fscy120\\fscx120)}%s",x,y,x+10,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = line.start_time + syl.end_time + 300
l.end_time = line.start_time + syl.end_time + 600+math.random(0,100)
l.layer=4
subs.append(l)
end
for j=0,02 do
colors={'HB17738', 'HF9EDD1'}
rand_color= colors[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy120\\be10\\bord0\\3c&H86AEC1&)\\t(\\frz100\\be100\\fscy200\\fscx200)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = line.start_time + syl.end_time + 300
l.end_time = line.start_time + syl.end_time + 600+math.random(0,100)
l.layer=4
subs.append(l)
end
for j=0,01 do
colors={'HB17738', 'HF9EDD1'}
rand_color= colors[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\alpha&HFF&\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\alpha&HAA&\\alpha&HCC&\\fscy160\\be10\\bord0\\3c&H86AEC1&)\\t(\\alpha&H99&\\be60\\fscy170\\fscx160)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = line.start_time + syl.end_time + 300
l.end_time = line.start_time + syl.end_time + 600 + math.random(0,100)+math.random(200,400)
l.layer=5
subs.append(l)
end
  
	--Syl
   	l.text=string.format("{\\3c&HB17738&\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx120\\fscy200)\\t(%d,%d,\\fscx100\\fscy100}%s",x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
	subs.append(l)
   
    --Syl2
	 l.text = string.format("{\\shad0\\an5\\pos(%d,%d)\\be5\\t($start,$mid,\\fscy150)\\t($mid,$end,\\fscx150\\fscy350)\\t(!$end-80!,$end,\\alpha&HFF&)\\1c&HFFFFFF&\\bord0)}%s",x,y,syl.text)
	 l.start_time = line.start_time + syl.start_time
	 l.end_time = l.start_time + 30 + syl.duration 
     l.layer = 2
	 subs.append(l)
   
   	--Template
	l.text=string.format("{\\an5\\be1\\org(%d,%d)\\pos(%d,%d)\\fry0}%s",x,y,x,y,syl.text_stripped)
	l.start_time=line.start_time + syl.start_time
	l.end_time=line.start_time + syl.end_time + 300
	l.layer=1
	subs.append(l)
   
	-- intro
	l.layer = 1 --layer 1
	l.text = string.format("{\\an5\\pos(%d,%d)\\bord1.0\\frx-90\\alpha&HFF&\\fscx120\\fscy120\\1c%s\\t(0,%d,\\fscx100\\fscy100\\frx0\\alpha&H00&)\\t(%d,%d,\\1c&HF6E9F5&)}%s",x,y, line.styleref.color2, syl.i*150, syl.start_time+400, syl.end_time+600, syl.text_stripped)
	l.start_time = line.start_time - 600 -- start time
	l.end_time = line.start_time + syl.start_time -- end time (syls dissapear)
	subs.append(l)
   end
end

aegisub.register_macro("Naruto Opening","", naru)

aegisub.register_filter("Naruto Opening","",2000,naru)