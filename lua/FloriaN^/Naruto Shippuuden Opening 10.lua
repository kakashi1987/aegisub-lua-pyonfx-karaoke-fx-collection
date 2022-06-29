include("karaskel.lua")

script_name = "Naruto Opening 10"
script_description = "BLEACH Fillers end 2013"
script_author = "FloriaN" --exit effect by palmje
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

chari = 0

   for i = 1, line.kara.n do
   
		local syl = line.kara[i]
		num_syls = line.kara.n
		local x = line.left + syl.center
		local y = line.middle
		local shape = "m 5 0 b 2 0 0 2 0 5 b 0 8 2 10 5 10 b 8 10 10 8 10 5 b 10 2 8 0 5 0"	
		local l=table.copy(line)
		
	pox = 0
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\3c%s\\shad0\\an5\\fscx200\\fscy200\\fry%d\\frx%d\\be2\\fad(360,0)\\move(%d,%d,%d,%d,%d,%d)\\t(0,400,\\fscx100\\fscy100\\3c%s\\frx0\\fry0\\be1)}%s",line.styleref.color1,math.random(-360,360),math.random(-360,360),charx,chary-20,charx,chary,0,400,line.styleref.color3,char)
		l.start_time = line.start_time - 400 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
		
		for j=0,3 do		
		l.text = string.format("{\\bord0\\blur0\\shad0\\move(%d,%d,%d,%d)\\fad(0,300)\\fscy80\\fscx80\\p1}%s",charx,chary+10,charx+math.random(-50,50),chary+math.random(-50,50),"m 0 0 b 0 -5 0 -10 0 -15 b 0 0 0 0 15 0 b 0 0 0 0 0 15 b 0 0 0 0 -15 0 b 0 0 0 0 0 -15")
		l.start_time = line.start_time + syl.start_time + 150
		l.end_time = line.start_time + syl.end_time + math.random(150,1000)
		subs.append(l)
		end
	end
	
	--Template
	l.text=string.format("{\\an5\\be1\\org(%d,%d)\\pos(%d,%d)}%s",x,y,x,y,syl.text_stripped)
	l.start_time=line.start_time + syl.end_time
	l.end_time=line.end_time - 2000 + 2000*i/num_syls
	l.layer=2
	subs.append(l)
	
	--Syl
   	l.text=string.format("{\\3c&H3E76F3&\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx120\\fscy200)\\t(%d,%d,\\fscx100\\fscy100}%s",x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=4
	subs.append(l)
	
    --Syl2
	 l.text = string.format("{\\shad0\\an5\\pos(%d,%d)\\be5\\t(\\fscy150)\\t(\\fscx150\\fscy350)\\t(\\alpha&HFF&)\\1c&HFFFFFF&\\bord0)}%s",x,y,syl.text)
	 l.start_time = line.start_time + syl.start_time
	 l.end_time = l.start_time + 30 + syl.duration 
     l.layer = 3
	 subs.append(l)
	
	
		--exit effect
		segs = 2
		fall_dur = 500
		
		--create fall
		for j=1,segs do
			for k=1,segs do
				x1 = line.left + syl.left + syl.width/segs*(k-1)
				x2 = line.left + syl.left + syl.width/segs*k
				y1 = line.bottom - syl.height + syl.height/segs*(j-1)
				y2 = line.bottom - syl.height + syl.height/segs*j
				l = table.copy(line)
				yrand = 15 + math.random(0, 30)
				xrand = math.random(0, 40) - 20
				start_offset = math.random(0, 600)
				end_offset = math.random(150, 700)
				l.start_time = line.end_time - 2000 + 2000*i/num_syls
				l.end_time   = line.end_time + fall_dur + end_offset - 1500 + 2000*i/num_syls
				l.layer      = 2
				l.effect     = 'karaoke-lua'
				l.text = string.format([[{\an5\blur0.3\clip(%d,%d,%d,%d)\move(%d,%d,%d,%d,%d,%d)\t(%d,%d,0.6,\alpha&HFF&\blur3.3)\t(%d,%d,\clip(%d,%d,%d,%d))}%s]], x1, y1, x2, y2, line.left + syl.center, line.middle, line.left + syl.center + xrand, line.middle + yrand, start_offset, l.end_time - l.start_time, start_offset, l.end_time - l.start_time, start_offset, l.end_time - l.start_time, x1 + xrand, y1 + yrand, x2 + xrand, y2 + yrand, syl.text_stripped)
				subs.append(l)
			end
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

function set_temp(ref,val) temp[ref] = val; return val; end

function macro_MF(subs, sel)
	aegisub.set_undo_point("before run macro")
	naru(subs, {ismacro=true, sel=sel})
end

aegisub.register_macro("Naruto Opening 10","", macro_MF)
aegisub.register_filter("Naruto Opening 10","",2000,naru)