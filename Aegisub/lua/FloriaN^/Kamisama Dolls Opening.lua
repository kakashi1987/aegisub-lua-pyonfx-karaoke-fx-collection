include("karaskel.lua")
script_name = "Kamisama Dolls OP"
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

function kami(subs)
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

ll=0

function do_fx(subs, meta, line, styles)

chari = 0

if (line.style == "English") then

 	pox = 0
	chari = 0
 
local l = table.copy(line)
	local char = {} 
	if line.duration > 0 then
		for char in unicode.chars(line.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + (cx/2) + pox
		local chary = line.middle
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(%d,%d)\\1c&H707070&\\clip(%d,%d,%d,%d)\\fscx100\\fscy100\\t(%d,%d,\\fscx100\\frz%d\\frx%d\\fry%d\\fscy100\fry0)\\t(%d,%d,\\fscx100\\fscy100\\frx0\\fry0\\frz0)}%s",charx,chary,300,0,0,0,xres,line.middle+5,0,150,math.random(-360,360),math.random(-360,360),math.random(-360,360),150,300,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + (chari-1)*20
		subs.append(l)
		
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(%d,%d)\\1c&H3A3A3A&\\clip(%d,%d,%d,%d)\\fscx100\\fscy100\\t(%d,%d,\\fscx100\\frz%d\\frx%d\\fry%d\\fscy100\fry0)\\t(%d,%d,\\fscx100\\fscy100\\frx0\\fry0\\frz0)}%s",charx,chary,300,0,0,line.middle,xres,line.bottom+30,0,150,math.random(-360,360),math.random(-360,360),math.random(-360,360),150,300,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + (chari-1)*20
		subs.append(l)
			
		--Template
		l.text=string.format("{\\an5\\clip(%d,%d,%d,%d)\\pos(%d,%d)\\1c&H707070&\\fad(%d,%d)}%s",0,0,xres,line.middle+5,charx,chary,0,300,char)
		l.start_time=line.start_time + (chari-1)*20
		l.end_time=line.end_time
		l.layer=1
		subs.append(l)

		--Template
		l.text=string.format("{\\an5\\clip(%d,%d,%d,%d)\\pos(%d,%d)\\1c&H3A3A3A&\\fad(%d,%d)}%s",0,line.middle,xres,line.bottom+30,charx,chary,0,300,char)
		l.start_time=line.start_time + (chari-1)*20
		l.end_time=line.end_time
		l.layer=1
		subs.append(l)
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
	
	--template char loop for intro effect below
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left+ (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(%d,%d)\\1c&H707070&\\clip(%d,%d,%d,%d)\\fscx100\\fscy100\\t(%d,%d,\\fscx100\\frz%d\\frx%d\\fry%d\\fscy100\fry0)\\t(%d,%d,\\fscx100\\fscy100\\frx0\\fry0\\frz0)}%s",charx,chary,300,0,0,0,xres,line.middle+5,0,150,math.random(-360,360),math.random(-360,360),math.random(-360,360),150,300,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
		
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(%d,%d)\\1c&H3A3A3A&\\clip(%d,%d,%d,%d)\\fscx100\\fscy100\\t(%d,%d,\\fscx100\\frz%d\\frx%d\\fry%d\\fscy100\fry0)\\t(%d,%d,\\fscx100\\fscy100\\frx0\\fry0\\frz0)}%s",charx,chary,300,0,0,line.middle,xres,line.bottom+30,0,150,math.random(-360,360),math.random(-360,360),math.random(-360,360),150,300,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	 for highlightindex = 1, #syl.highlights do 
	 local hl = syl.highlights[highlightindex]

	--Syl
   	-- l.text=string.format("{\\3c&HAC8D29&\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx110\\fscy110)\\t(%d,%d,\\fscx100\\fscy100}%s",x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
	-- l.start_time=line.start_time+hl.start_time
	-- l.end_time=line.start_time+hl.end_time
	-- l.layer=4
	-- subs.append(l)
	
	if syl.duration > 0 then
	l = table.copy(line)
	rr=1
	l.start_time = line.start_time + hl.start_time
	l.end_time = line.start_time + hl.end_time
	l.layer = ll
	for g=0, 9 do
	l.text = string.format("{\\1a&H%d&\\be1\\an5\\shad0\\bord0\\1c&HFFFFFF&\\pos(%d,%d)\\t(0.1\\fscx%d\\fscy%d\\alpha&HFF&)}%s",rr*6, x , y-2, 110+(g*6), 110+(g*6), syl.text_stripped)
	rr = rr + 1
	subs.append(l)
			end
		end
	ll=ll+1
	
	end

	--Template
	l.text=string.format("{\\an5\\clip(%d,%d,%d,%d)\\pos(%d,%d)\\1c&H707070&\\fad(%d,%d)}%s",0,0,xres,line.middle+5,x,y,0,300,syl.text_stripped)
	l.start_time=line.start_time + syl.start_time
	l.end_time=line.end_time
	l.layer=1
	subs.append(l)

	--Template
	l.text=string.format("{\\an5\\clip(%d,%d,%d,%d)\\pos(%d,%d)\\1c&H3A3A3A&\\fad(%d,%d)}%s",0,line.middle,xres,line.bottom+30,x,y,0,300,syl.text_stripped)
	l.start_time=line.start_time + syl.start_time
	l.end_time=line.end_time
	l.layer=1
	subs.append(l)

	end
	
end

function macro_MF(subs, sel)

	aegisub.set_undo_point("before run macro")

	kami(subs, {ismacro=true, sel=sel})

end	

aegisub.register_macro("Kamisama Dolls Opening","", macro_MF)

aegisub.register_filter("Kamisama Dolls Opening","",2000,kami)