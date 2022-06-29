include("karaskel.lua")

script_name = "Naruto Opening 11"
script_description = "BLEACH Fillers end 2013"
script_author = "FloriaN"
script_version = ""

xres, yres = aegisub.video_size()		--get video resolution 
if xres == nil  then 
	ratio = 1 
	x_rat = 1
	y_rat = 1
else 
	ratio = yres/576
	x_rat = xres/1024 
	y_rat = x_rat
end
msa = aegisub.ms_from_frame(1)		--get frame duration 
msb = aegisub.ms_from_frame(100) 
if msa == nil and msb == nil then 
	frame_dur = 33  
else 
	frame_dur = (msb-msa)/100 
end

function naru(subs)
	local meta, styles = karaskel.collect_head(subs)
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and l.style ~= "English" and
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

function do_fx(subs, meta, line)
temp = {};
math.randomseed(3500);
chari = 0

   for i = 1, line.kara.n do
   
		local syl = line.kara[i]
		local x = line.left + syl.center
		local y = line.middle
		local shape = { "m 0 0 l 0 5 l 5 5 l 5 0 l 0 0", "m 0 0 l 0 5 l 3 8 l 5 0 l 0 0", "m 0 0 l 1 4 l 4 6 l 7 4 l 0 0", "m 0 0 l 0 4 l 6 3 l 7 1 l 0 0", "m 0 0 l 5 2 l 0 5 l 0 0"}
		local l=table.copy(line)
		
	pox = 0
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		
		l.text = string.format("{\\an5\\be2\\blur2\\fad(255,128,0,0,90,90,360)\\pos(%d,%d)\\frx180\\t(0,360,\\frx0)}%s",charx,chary,char)
		l.start_time = line.start_time - 420 + (chari-1)*20
		l.end_time = line.start_time + syl.end_time
		subs.append(l)
	end
	
	local loops=5
	for i=0,loops do
	if i%2==0 then fr=-10-math.random(0,5) size1=130+math.random(0,10) size2=100 else fr=10+math.random(0,5) size1=100 size2=130+math.random(0,10) end
	
	l.text=string.format("{\\an5\\3c%s\\pos(%d,%d)\\blur2\\be2\\fscx%d\\fscy%d\\t(\\fscx%d\\fscy%d\\frz%d)}%s",_G.ass_color(_G.HSV_to_RGB(set_temp("H",math.random(30,56)),1,1)),x,y,size1,size1,size2,size2,fr,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time+syl.duration*(i-1)/loops
	l.end_time=line.start_time+syl.start_time+syl.duration*(i)/loops
	l.layer=2
	subs.append(l)
	
	end
	
	for j=0, 20 do
	l.start_time = line.start_time + syl.start_time
	l.end_time = line.start_time + syl.end_time + math.random(150,1000)
    l.text = string.format("{\\org(%d,%d)\\rnd15\\fad(%d,%d)\\blur%d\\alpha&H60&\\1c%s\\fscx%d\\fscy%d\\t(0,%d,\\fscx%d\\fscy%d)\\t(33,500,\\fscx%d\\fscy%d)\\t(0,%d,\\1c%s)\\t(500,%d,\\alpha&HFF&\\fscx%d\\fscy%d\\fr%d)\\an5\\bord0\\shad0\\move(%d,%d,%d,%d,%d,%d)\\3c&HFFFFFF&\\p1}%s",x,y-20*x_rat,200,800,2*x_rat,_G.ass_color(_G.HSV_to_RGB(set_temp("H",math.random(30,56)),1,1)),set_temp("scx1",math.random(60,150)*x_rat),temp.scx1,33,set_temp("scx2",math.random(120,240)),temp.scx2,temp.scx1,temp.scx1,math.random(200,1000),_G.ass_color(_G.HSV_to_RGB(temp.H,0.3,1)),math.random(700,1000),set_temp("scx",math.random(40,240)*x_rat),temp.scx,math.random(-20,20),x+math.random(-16,16)*x_rat,y+math.random(-10,10)*x_rat,x+math.random(-10,10)*x_rat,y-math.random(10,30),math.random(0,150),1000,shape[math.random(1,5)])
    l.layer = 0
	subs.append(l)
	end
	
	for j=0,18 do
	l.start_time = line.start_time + syl.start_time
	l.end_time = line.start_time + syl.end_time + math.random(40,60)*10
    l.text = string.format("{\\an5\\be1\\bord0\\move(%d,%d,%d,%d)\\1c%s\\fscx%d\\fscy%d\\t(\\frx%d\\fry%d\\frz%d)\\t(2,\\1a&HFF&)\\p1}%s",x+math.random(-5,5),y,x+math.random(-35,35),y-math.random(5,20),line.styleref.color2,math.random(80,100),math.random(80,100),math.random(-360,360),math.random(-360,360),math.random(-360,360),shape[math.random(1,5)])
    l.layer = 1
	subs.append(l)
	end
	
	l.text=string.format("{\\an5\\1a&88\\1c%s\\blur2\\move(%d,%d,%d,%d,%d,%d)\\t(500,1500,\\frz%s\\fscx80\\fscy80\\alpha&FF&)}%s",line.styleref.color1,x,y,x,y+math.random(5,10),500,1500,math.random(-30,30),syl.text_stripped)
	l.start_time=line.start_time+syl.start_time+syl.duration
	l.end_time=line.start_time+syl.end_time+1500
	l.layer=2
	subs.append(l)
	
		
	end
end

function glitter(dur) 
	local tag = "" 
	local time = 0 
	while  (dur > time) do 
		local time1 = time + math.random(dur / 2)
		local time2 = time1 + 1
		local time3 = time2 + frame_dur
		local time4 = time3 + 100
		local size1 = math.random(2,25)*ratio
		local size2 = math.random(1,13)*ratio
		tag = string.format("\\t(%d,%d,\\fscx%d\\fscy%d\\1c&HFFFFFF&\\3c&HFFFFFF&\\bord%f\\blur%f)\\t(%d,%d,\\fscx%d\\fscy%d\\1c&HFFFFFF&\\3c&H000000&\\bord%f\\blur%f)",time1, time2, size1, size1, 2*ratio, 3*ratio, time3, time4, size2, size2,1*ratio, 1*ratio) 
		time = time4
	end 
	return tag 
end

function set_temp(ref,val) temp[ref] = val; return val; end

function macro_MF(subs, sel)
	aegisub.set_undo_point("before run macro")
	naru(subs, {ismacro=true, sel=sel})
end

aegisub.register_macro("Naruto Opening 11","", macro_MF)
aegisub.register_filter("Naruto Opening 11","",2000,naru)