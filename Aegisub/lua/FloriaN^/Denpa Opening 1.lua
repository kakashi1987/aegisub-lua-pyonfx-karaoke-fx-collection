include("karaskel.lua")
script_name = "Denpa Opening 1"
script_description = "nothing"
script_author = "FloriaN"
script_version = "beta v2"

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

function denpa(subs)
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

	chari = 0
 	
   for i = 1, line.kara.n do
   
		local syl = line.kara[i]
		local x = line.left + syl.center
		local y = line.middle
		local l=table.copy(line)
		
   if (line.style == "Default") then
   
  	pox = 0
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\bord0.2\\be10\\3c%s\\1c%s\\fad(%d,%d)\\move(%d,%d,%d,%d,%d,%d)\\fscy100\\fry360\\fscx100\\t(%d,%d,\\fscx120\\frz0\\fry0\\frx0\\fscy170)\\t(%d,%d,\\fscx100\\fscy100\\be0\\bord1.5\\3c&H000000&)}%s",line.styleref.color3,line.styleref.color1,200,0,charx+math.random(-40,40),chary+math.random(-20,20),charx,chary,0,400,0,400,400,800,char)
		l.start_time = line.start_time - 400 + (chari-1)*10
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	--Syl
   	l.text=string.format("{\\3c&HFFFFFF&\\1c&HFFFFFF&\\an5\\bord1\\blur3\\be10\\pos(%d,%d)}%s",x,y,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
	subs.append(l)
   
   
   	--Template
	l.text=string.format("{\\an5\\be1\\org(%d,%d)\\pos(%d,%d)\\fry0}%s",x,y,x,y,syl.text_stripped)
	l.start_time=line.start_time + syl.start_time
	l.end_time=line.end_time-10
	l.layer=1
	subs.append(l)
	
	 for i=0,5 do
	 colors={'H6E0DC1', 'HD7A518' , 'H41E5D5'}
	 rand_color= colors[math.random(1,3)]
	 l.start_time = line.end_time-11
	 l.end_time = line.end_time + math.random(1000,2000)
	 l_duration = l.end_time - l.start_time
	 l.text = string.format("{\\an5\\1c%s\\bord0\\shad0\\move(%d,%d,%d,%d)\\t(0.2,\\frx%d\\fry%d\\frz%d)\\fad(%d,%d)\\p1}m -9 -5 l 9 -5 l 4 0 l 17 0 l 17 2 l -1 2 l 4 -3 l -9 -3)}",rand_color,x,y,x+math.random(200*0.07,200*0.6),y+math.random(-200*0.13,200*0.04),math.random(-360,360),math.random(-360,360),math.random(-360,360),0,100)
     l.layer = 0
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

	denpa(subs, {ismacro=true, sel=sel})

end	

aegisub.register_macro("Denpa Opening 1","", macro_MF)

aegisub.register_filter("Denpa Opening 1","",2000,denpa)