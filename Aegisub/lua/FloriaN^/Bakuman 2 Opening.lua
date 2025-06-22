include("karaskel.lua")
script_name = "Bakuman 2 OP"
script_description = ""
script_author = "FloriaN"
script_version = ""

xres, yres = aegisub.video_size()		--get video resolution 
if xres == nil  then 
	ratio = 1 
else 
	ratio = yres/576
end
msa = aegisub.ms_from_frame(1)		--get frame duration 
msb = aegisub.ms_from_frame(100) 
if msa == nil and msb == nil then 
	frame_dur = 33  
else 
	frame_dur = (msb-msa)/100 
end

function baku(subs)
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

	if (line.effect == "main") then
		color = "&HFFFFFF&"
		border = "&H3320A9&"
	elseif (line.effect=="start") then
		border = "&H2A6ED0&"
	end

ll = 5
chari = 0

if (line.style == "Bakuman-op-eng") then

 	pox = 0
	chari = 0
	
	local l = table.copy(line)
	local char = {} 
	
	if (line.effect == "start") then
		if line.duration > 0 then
		for char in unicode.chars(line.text_stripped) do
			cx,cy = aegisub.text_extents(line.styleref,char)
			local charx = line.left + (cx/2) + pox
			local chary = line.middle
			pox = pox + cx
			chari = 1+chari
			l.text = string.format("{\\an5\\pos(%d,%d)\\fad(%d,%d)\\fscx100\\fscy100\\t(%d,%d,\\fscx100\\frz%d\\frx%d\\fry%d\\fscy100\fry0)\\t(%d,%d,\\fscx100\\fscy100\\frx0\\fry0\\frz0)}%s",charx,chary,300,0,0,150,math.random(-360,360),math.random(-360,360),math.random(-360,360),150,300,char)			l.start_time = line.start_time - 400 + (chari-1)*20
			l.start_time = line.start_time - 400 + (chari-1)*20
			l.end_time = line.start_time + (chari-1)*20
			l.layer = 1
			subs.append(l)
		--Template
		l.text=string.format("{\\an5\\pos(%d,%d)}%s",charx,chary,char)
		l.start_time=line.start_time + (chari-1)*20
		l.end_time=line.end_time
		l.layer=1
		subs.append(l)
		end
	end
	end
	
	if (line.effect == "whatever") then
			if line.duration > 0 then
		for char in unicode.chars(line.text_stripped) do
			cx,cy = aegisub.text_extents(line.styleref,char)
			local charx = line.left + (cx/2) + pox
			local chary = line.middle
			pox = pox + cx
			chari = 1+chari
			l.text = string.format("{\\an5\\pos(%d,%d)\\fscy0\\frz90\\t(0,150,\\fscy100\\blur1\\be1\\frz0)}%s",charx,chary,char)
			l.start_time = line.start_time - 400 + (chari-1)*20
			l.end_time = line.start_time + (chari-1)*20
			l.layer = 1
			subs.append(l)
			
		l.text = string.format("{\\an5\\blur1\\be1\\pos(%d,%d)\\fscy100\\frz0\\t(0,150,\\fscy0\\frz90)}%s",charx,chary,char)
		l.start_time = line.end_time - 350 + (chari-1)*10
		l.end_time = line.end_time
		subs.append(l)
		--Template
		l.text=string.format("{\\an5\\pos(%d,%d)}%s",charx,chary,char)
		l.start_time=line.start_time + (chari-1)*20
		l.end_time=line.end_time - 350 + (chari-1)*10
		l.layer=1
		subs.append(l)
		end
	end
	end
	
	if (line.effect == "main") then
			if line.duration > 0 then
		for char in unicode.chars(line.text_stripped) do
			cx,cy = aegisub.text_extents(line.styleref,char)
			local charx = line.left + (cx/2) + pox
			local chary = line.middle
			pox = pox + cx
			chari = 1+chari
			l.text = string.format("{\\an5\\pos(%d,%d)\\bord2\\fad(%d,%d)\\move(%d,%d,%d,%d,%d,%d)\\fscy100\\frx360\\fscx100\\t(0,%d,\\fscx120\\frz0\\fry0\\frx0\\fscy170)\\t(%d,%d,\\fscx100\\fscy100\\bord2\\blur2\\be2)}%s",charx,chary,200,0,charx+math.random(-50,20),chary+math.random(-20,50),charx,chary,0,400,400,400,800,char)
			l.start_time = line.start_time - 400 + (chari-1)*20
			l.end_time = line.start_time + (chari-1)*20
			l.layer = 1
			subs.append(l)
		--Template
		l.text=string.format("{\\an5\\pos(%d,%d)}%s",charx,chary,char)
		l.start_time=line.start_time + (chari-1)*20
		l.end_time=line.end_time
		l.layer=1
		subs.append(l)
		end
	end
	end
end

chari = 0
transform = ""

   for i = 1, line.kara.n do
   
		local syl = line.kara[i]
		local x = line.left + syl.center
		local xl=line.center
		local y = line.middle
		local l=table.copy(line)
		local lf=line.left
		local lr=line.right
		local lh=line.height
		local lw=line.width
		
	pox = 0
	
	if (line.effect == "start") then
		for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left+ (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(%d,%d)\\fscx100\\fscy100\\t(%d,%d,\\fscx100\\frz%d\\frx%d\\fry%d\\fscy100\fry0)\\t(%d,%d,\\fscx100\\fscy100\\frx0\\fry0\\frz0)}%s",charx,chary,300,0,0,150,math.random(-360,360),math.random(-360,360),math.random(-360,360),150,300,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	 for highlightindex = 1, #syl.highlights do 
	 local hl = syl.highlights[highlightindex]

	--Syl
   	l.text=string.format("{\\3c%s\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx110\\fscy110)\\t(%d,%d,\\fscx100\\fscy100}%s",border,x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+hl.start_time
	l.end_time=line.start_time+hl.end_time
	l.layer=4
	subs.append(l)
	
	if syl.duration > 0 then
	l = table.copy(line)
	rr=1
	l.start_time = line.start_time + hl.start_time
	l.end_time = line.start_time + hl.end_time
	l.layer = ll
	for g=0, 9 do
	l.text = string.format("{\\1a&H%d&\\be1\\an5\\shad0\\bord0\\1c&HFFFFFF&\\pos(%d,%d)\\t(0.1\\fscx%d\\fscy%d\\alpha&HFF&)}%s",rr*9, x , y-2, 110+(g*9), 110+(g*9), syl.text_stripped)
	rr = rr + 1
	subs.append(l)
			end
		end
	ll=ll+1
	
	end

	--Template
	l.text=string.format("{\\an5\\pos(%d,%d)\\fad(%d,%d)}%s",x,y,0,300,syl.text_stripped)
	l.start_time=line.start_time + syl.start_time
	l.end_time=line.end_time
	l.layer=1
	subs.append(l)
	end
	
	if (line.effect == "whatever") then
		for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\pos(%d,%d)\\fscy0\\frz90\\t(0,150,\\fscy100\\blur1\\be1\\frz0)}%s",charx,chary,char)
		l.start_time = line.start_time - 350 + (chari-1)*10
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
		
		l.text = string.format("{\\an5\\blur1\\be1\\pos(%d,%d)\\fscy100\\frz0\\t(0,150,\\fscy0\\frz90)}%s",charx,chary,char)
		l.start_time = line.end_time - 350 + (chari-1)*10
		l.end_time = line.end_time
		subs.append(l)
		
		l.start_time=line.start_time + syl.end_time
		l.end_time=line.end_time- 350 + (chari-1)*10
		l.text=string.format("{\\an5\\blur1\\be1\\pos(%d,%d)}%s",charx,chary,char)
		l.layer=1
		subs.append(l)
	end
	for j=0,10 do
	l.text=string.format("{\\an5\\pos(%d,%d)\\bord2\\blur2\\be2\\fscx%d\\fscy%d\\alpha&HCC&}%s",x,y,100+(j-1)*4,100+(j-1)*4,syl.text_stripped)
   	l.start_time=line.start_time+syl.start_time+(syl.duration/2/10)*j
	l.end_time=line.start_time+syl.end_time+syl.duration/2-(syl.duration/2/10)*j
	l.layer=3
	subs.append(l)
	end
	l.text=string.format("{\\an5\\pos(%d,%d)\\bord2\\blur2\\be2}%s",x,y,syl.text_stripped)
   	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
	subs.append(l)
end
	
	if (line.effect == "main") then

	--template char loop for intro effect below
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left+ (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\pos(%d,%d)\\bord2\\fad(%d,%d)\\move(%d,%d,%d,%d,%d,%d)\\fscy100\\frx360\\fscx100\\t(0,%d,\\fscx120\\frz0\\fry0\\frx0\\fscy170)\\t(%d,%d,\\fscx100\\fscy100\\bord2\\blur2\\be2)}%s",charx,chary,200,0,charx+math.random(-50,20),chary+math.random(-20,50),charx,chary,0,400,400,400,800,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
		l.text = string.format("{\\an5\\1c%s\\3c%s\\bord1.5\\blur1\\be1\\move(%d,%d,%d,%d,%d,%d)\\fscy100\\fscx100\\t(0,%d,\\fscx120\\frz0\\fry0\\frx0\\fscy170)\\t(%d,%d,\\frx90\\fscy100\\fscx100)\\t(0,%d,\\alpha&HFF&)}%s",color,border,charx,chary,charx-math.random(10,20),chary-math.random(-20,20),0,400,400,400,800,600,char)
		l.start_time = line.start_time + syl.end_time
		l.end_time = line.end_time
		subs.append(l)
	end
	for j=0,5 do
		--Syl
		l.text=string.format("{\\an5\\1c%s\\3c%s\\pos(%d,%d)\\be1\\t(0,%d,\\fscx%d\\fscy%d\\be%d\\blur%d\\bord%d)\\t(%d,%d,\\fscx100\\fscy100\\be3\\blur2\\bord2)}%s",color,border,x,y,syl.kdur*3,110+j*12,110+j*12,1+j*2,1+j*2,4,syl.kdur*3,syl.duration,syl.text_stripped)
		l.start_time=line.start_time + syl.start_time
		l.end_time=line.start_time + syl.end_time
		l.layer=5+j
		subs.append(l)
	end
	for j=0,50 do
		--Particle
		l.text=string.format("{\\an5\\1c%s\\3c%s\\be10\\bord1.5\\move(%d,%d,%d,%d)\\fad(%d,%d)\\p5}m 20 0 b 20 10 30 20 40 20 b 30 20 20 30 20 40 b 20 30 10 20 0 20 b 10 20 20 10 20 0",color,border,x+math.random(-20,20),y+math.random(-20,20),x+math.random(-30,-10),y+math.random(-50,50),100,200)
		l.start_time=line.start_time + syl.start_time
		l.end_time=line.start_time + syl.end_time + math.random(-500,1000)
		l.layer=0
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

function macro_MF(subs, sel)

	aegisub.set_undo_point("before run macro")

	baku(subs, {ismacro=true, sel=sel})

end	

aegisub.register_macro("Bakuman 2 OP","", macro_MF)

aegisub.register_filter("Bakuman 2 OP","",2000,baku)