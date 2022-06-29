include("karaskel.lua")

script_name = "Naruto Ending 19"
script_description = "BLEACH Fillers end 2013"
script_author = "FloriaN" --Pulse Effect originally by Ai-chan
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
p_si = -1


   for i = 1, line.kara.n do
   
		local syl = line.kara[i]
		local x = line.left + syl.center
		local y = line.middle
		local l=table.copy(line)
		p_leadin = 500
		shape = "m 5 0 b 2 0 0 2 0 5 b 0 8 2 10 5 10 b 8 10 10 8 10 5 b 10 2 8 0 5 0"
		color1 = _G.color_from_style(line.styleref.color2)
		color2 = _G.color_from_style(line.styleref.color1)
		p_si = p_si+1
		p_strip_count = 0
		p_leadin_syl = 0
		p_delayer = 0
		p_start_syl = 0
		p_strip_width = 0
		
		for j=0,10 do
		l.text = string.format("%s{\\an5\\org(%d,%d)\\fad(%d,%d)\\pos(%d,%d)\\clip(%d,%d,%d,%d)\\1c%s\\fscy200\\t(0,%d,\\fscy100\\frz0)\\t(%d,%d,\\1c%s\\fscy140)\\t(%d,%d,\\1c%s\\fscy100)}%s",p_leadin_fn(j,10,line,syl),-5000,y,p_leadin,p_leadin,x,y,math.floor(line.left+syl.left-line.styleref.outline+(j-1)*p_strip_width),0,math.floor(line.left+syl.left-line.styleref.outline+j*p_strip_width),meta.res_y,color2,p_leadin,p_start_syl,p_start_syl+hsdur,color1,p_start_syl+hsdur,p_start_syl+syl.duration,color2,syl.text_stripped)
		l.start_time = line.start_time - p_leadin_syl
		l.end_time = line.start_time + line.duration*(0.75+0.3*p_delayer)+p_leadin
		l.layer = 1+j
		subs.append(l)
		end
		
	for j=0, 20 do
	l.start_time = line.start_time + syl.start_time
	l.end_time = line.start_time + syl.end_time + math.random(150,1000)
    l.text = string.format("{\\org(%d,%d)\\rnd15\\fad(%d,%d)\\blur%d\\alpha&H60&\\1c%s\\fscx%d\\fscy%d\\t(0,%d,\\fscx%d\\fscy%d)\\t(33,500,\\fscx%d\\fscy%d)\\t(0,%d,\\1c%s)\\t(500,%d,\\alpha&HFF&\\fscx%d\\fscy%d\\fr%d)\\an5\\bord0\\shad0\\move(%d,%d,%d,%d,%d,%d)\\3c&HFFFFFF&\\p1}%s",x,y-20*x_rat,200,800,2*x_rat,_G.ass_color(_G.HSV_to_RGB(set_temp("H",math.random(30,56)),1,1)),set_temp("scx1",math.random(60,150)*x_rat),temp.scx1,33,set_temp("scx2",math.random(120,240)),temp.scx2,temp.scx1,temp.scx1,math.random(200,1000),_G.ass_color(_G.HSV_to_RGB(temp.H,0.3,1)),math.random(700,1000),set_temp("scx",math.random(40,240)*x_rat),temp.scx,math.random(-20,20),x+math.random(-16,16)*x_rat,y+math.random(-10,10)*x_rat,x+math.random(-10,10)*x_rat,y+math.random(-30,30),math.random(0,150),1000,shape)
    l.layer = 0
	subs.append(l)
	end
	
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

function p_leadin_fn(j,maxj,line,syl) 
p_strip_count = p_si*maxj+j; 
p_delayer = (p_strip_count/(line.kara.n*maxj)); 
p_leadin_syl = p_leadin-line.duration*0.3*p_delayer; 
p_start_syl = math.floor(p_leadin_syl+syl.start_time+(j-maxj)*(syl.duration/maxj)); 
hsdur = math.floor(syl.duration/2); 
p_strip_width = (syl.width+line.styleref.outline*2)/maxj; 
return "" end

function set_temp(ref,val) temp[ref] = val; return val; end

function macro_MF(subs, sel)
	aegisub.set_undo_point("before run macro")
	naru(subs, {ismacro=true, sel=sel})
end

aegisub.register_macro("Naruto Ending 19","", macro_MF)
aegisub.register_filter("Naruto Ending 19","",2000,naru)