include("karaskel.lua")

script_name = "BLEACH Opening 15"
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

function bleach(subs)
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

ll=5

function do_fx(subs, meta, line)
temp = {};

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
			l.text = string.format("{\\3c%s\\shad0\\an5\\fscx200\\fscy200\\fry%d\\frx%d\\be2\\fad(360,0)\\move(%d,%d,%d,%d,%d,%d)\\t(0,400,\\fscx100\\fscy100\\3c%s\\frx0\\fry0\\be1)}%s",line.styleref.color1,math.random(-360,360),math.random(-360,360),charx,chary-20,charx,chary,0,400,line.styleref.color3,char)
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

   for i = 1, line.kara.n do
   
		local syl = line.kara[i]
		if i == 1 then FF = 0 end
		local x = line.left + syl.center
		local y = line.middle
		local shape = "m 5 0 b 2 0 0 2 0 5 b 0 8 2 10 5 10 b 8 10 10 8 10 5 b 10 2 8 0 5 0"	
		local l=table.copy(line)
		
		colors = { "&H7343B2&" , "&H84495E&" , "&HBFA3D5&" , "&H6F3979&" , "&H874A64&" , "&H73BBD5&" , "&H5446BA&" , "&H68717E&" , "&H5162C8&"}
		color3 = { "&H9227D6&" , "&H26FFFC&" , "&HF9E650&"} 
		if (line.effect == "color") then set_temp("color",colors[math.random(1,9)]) elseif (line.effect == "3color") then set_temp("color",color3[math.random(1,3)]) elseif (line.effect == "pink") then set_temp("color","&H9129BE&") elseif (line.effect == "green") then set_temp("color","&H233C0D&") elseif (line.effect == "neutral") then set_temp("color","&H8EC0DC&") end
		
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
	end
	
	if (line.effect == "color" or line.effect == "pink" or line.effect == "green" or line.effect == "neutral" or line.effect == "3color") then
    for i=0,5 do
	l.text=string.format("{\\an5\\pos(%d,%d)\\be1\\t(0,%d,\\3c%s\\fscx%d\\fscy%d\\be%d\\blur%d\\bord6)\\t(%d,%d,\\fscx100\\fscy100\\be1\\blur1\\bord2)}%s",x,y,syl.kdur*3,temp.color,110+i*12,110+i*12,1+i*2,1+i*2,syl.kdur*3,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
	subs.append(l)
	end
	--# Syl 2 End
	l.start_time =  line.start_time + syl.start_time
	l.end_time =  line.end_time-200
	l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\3c&HFFFFFF&}%s",x,y,temp.color,syl.text_stripped)
	l.layer = 1   
	subs.append(l)
	--# Post Line 1
	l.start_time = line.end_time - 300
	l.end_time = line.end_time + FF/2
	l.text =string.format("{\\an5\\pos(%d,%d)\\fad(0,500)\\1c%s\\3c&HFFFFFF&}%s",x,y,temp.color,syl.text_stripped)
	l.layer = 0
	subs.append(l)
	
	elseif (line.effect == "blueyellow") then
	
	if (syl.inline_fx == "yellow") then	set_temp("color","&H1CDDF9&") else set_temp("color","&HECEA98&") end
	for i=0,5 do
	l.text=string.format("{\\an5\\pos(%d,%d)\\be1\\t(0,%d,\\3c%s\\fscx%d\\fscy%d\\be%d\\blur%d\\bord6)\\t(%d,%d,\\fscx100\\fscy100\\be1\\blur1\\bord2)}%s",x,y,syl.kdur*3,temp.color,110+i*12,110+i*12,1+i*2,1+i*2,syl.kdur*3,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
	subs.append(l)
	end
	--# Syl 2 End
	l.start_time =  line.start_time + syl.start_time
	l.end_time =  line.end_time-200
	l.text = string.format("{\\an5\\pos(%d,%d)\\3c%s}%s",x,y,temp.color,syl.text_stripped)
	l.layer = 1   
	subs.append(l)
	--# Post Line 1
	l.start_time = line.end_time - 300
	l.end_time = line.end_time + FF/2
	l.text =string.format("{\\an5\\pos(%d,%d)\\fad(0,500)\\3c%s}%s",x,y,temp.color,syl.text_stripped)
	l.layer = 0
	subs.append(l)
	
	
		if (syl.inline_fx == "yellow") then
		if (syl.text_stripped == "思っ" or syl.text_stripped == "o") then
		for g = 1, i do
   		sylz = line.kara[g]
		sx = line.left + sylz.center
		sy = line.middle
		l=table.copy(line)
		--# Syl 2 End
		l.start_time =  line.start_time + syl.start_time
		l.end_time =  line.end_time-200
		l.text = string.format("{\\an5\\pos(%d,%d)\\3c&H1CDDF9&\\fad(%d,%d)}%s",sx,sy,g*10,0,sylz.text_stripped)
		l.layer = 1   
		subs.append(l)
		--# Post Line 1
		l.start_time = line.end_time - 300
		l.end_time = line.end_time + FF/2
		l.text =string.format("{\\an5\\pos(%d,%d)\\fad(0,500)\\3c&H1CDDF9&}%s",sx,sy,sylz.text_stripped)
		l.layer = 0
		subs.append(l)
		end
		end
		end
	
	elseif (line.effect == "bluered") then
	
	if (syl.inline_fx == "red") then set_temp("color","&H0B0251&") else set_temp("color","&HE22A06&") end
	for i=0,5 do
	l.text=string.format("{\\an5\\pos(%d,%d)\\be1\\t(0,%d,\\3c%s\\fscx%d\\fscy%d\\be%d\\blur%d\\bord6)\\t(%d,%d,\\fscx100\\fscy100\\be1\\blur1\\bord2)}%s",x,y,syl.kdur*3,temp.color,110+i*12,110+i*12,1+i*2,1+i*2,syl.kdur*3,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
	subs.append(l)
	end
	--# Syl 2 End
	l.start_time =  line.start_time + syl.start_time
	l.end_time =  line.end_time-200
	l.text = string.format("{\\an5\\pos(%d,%d)\\3c%s}%s",x,y,temp.color,syl.text_stripped)
	l.layer = 1   
	subs.append(l)
	--# Post Line 1
	l.start_time = line.end_time - 300
	l.end_time = line.end_time + FF/2
	l.text =string.format("{\\an5\\pos(%d,%d)\\fad(0,500)\\3c%s}%s",x,y,temp.color,syl.text_stripped)
	l.layer = 0
	subs.append(l)
	
	
		if (syl.inline_fx == "red") then
		if (syl.text_stripped == "く" or syl.text_stripped == "ku ") then
		for g = 1, i do
   		sylz = line.kara[g]
		sx = line.left + sylz.center
		sy = line.middle
		l=table.copy(line)
		--# Syl 2 End
		l.start_time =  line.start_time + syl.start_time
		l.end_time =  line.end_time-200
		l.text = string.format("{\\an5\\pos(%d,%d)\\3c&H0B0251&\\fad(%d,%d)}%s",sx,sy,g*10,0,sylz.text_stripped)
		l.layer = 1   
		subs.append(l)
		--# Post Line 1
		l.start_time = line.end_time - 300
		l.end_time = line.end_time + FF/2
		l.text =string.format("{\\an5\\pos(%d,%d)\\fad(0,500)\\3c&H0B0251&}%s",sx,sy,sylz.text_stripped)
		l.layer = 0
		subs.append(l)
		end
		end
		end
	
	else
	bleachc = {"&H060045&", "&H08008E&", "&H05008A&"}
	for j=0, 20 do
	if(line.effect=="last") then mytime = line.end_time else mytime = line.end_time-i*150+syl.i*150+1000 end
	l.start_time = line.start_time + syl.end_time - syl.duration + math.random(syl.duration/2)+(math.floor((j-1)/15))*1000
	l.end_time = mytime
    l.text = string.format("{\\org(%d,%d)\\rnd15\\fad(%d,%d)\\blur%d\\alpha&H60&\\1c%s\\fscx%d\\fscy%d\\t(0,33,\\fscx%d\\fscy%d)\\t(33,500,\\fscx%d\\fscy%d)\\t(0,%d,\\1c%s)\\t(500,%d,\\alpha&HFF&\\fscx%d\\fscy%d)\\an5\\bord0\\shad0\\\move(%d,%d,%d,%d,%d,%d)\\3c&HFFFFFF&\\p1}%s",x,y-20*x_rat,200,800,2*x_rat,bleachc[math.random(1,3)],set_temp("scx1",math.random(60,150)*x_rat),temp.scx1,set_temp("scx2",math.random(120,240)),temp.scx2,temp.scx1,temp.scx1,math.random(200,1000),bleachc[math.random(1,3)],math.random(700,1000),set_temp("scx",math.random(40,240)*x_rat),temp.scx,x+math.random(-16,16)*x_rat,y+math.random(-10,10)*x_rat,x+math.random(-10,10)*x_rat,y-syl.height*2+math.random(-10,40)*x_rat,math.random(0,150),1000,shape)
    l.layer = 1
	subs.append(l)
	end
		
	 for highlightindex = 1, #syl.highlights do 
	 local hl = syl.highlights[highlightindex]

	--Syl
   	l.text=string.format("{\\3c&H342A83&\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx135\\fscy135)\\t(%d,%d,\\fscx100\\fscy100}%s",x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
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
	l.text = string.format("{\\1a&H%d&\\3c&H342A83&\\be1\\an5\\shad0\\bord0\\1c&HFFFFFF&\\pos(%d,%d)\\t(0.1\\fscx%d\\fscy%d\\alpha&HFF&)}%s",rr*9, x , y-2, 115+(g*15), 115+(g*15), syl.text_stripped)
	rr = rr + 1
	subs.append(l)
			end
		end
	ll=ll+1
	end


		--# Syl 2 End
		l.start_time =  line.start_time + syl.start_time
		l.end_time =  line.end_time-200
		l.text = string.format("{\\an5\\pos(%d,%d)\\3c&H342A83&}%s",x,y,syl.text_stripped)
		l.layer = 1   
		subs.append(l)
		
		--# Post Line 1
		l.start_time = line.end_time - 300
		l.end_time = line.end_time + FF/2
		l.text =string.format("{\\an5\\pos(%d,%d)\\fad(0,500)\\3c&H342A83&}%s",x,y,syl.text_stripped)
		l.layer = 0
		subs.append(l)
		end
		if (line.effect == "last") then FF = FF+(50/line.kara.n) else FF = FF + (1200/line.kara.n) end
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
	bleach(subs, {ismacro=true, sel=sel})
end

aegisub.register_macro("BLEACH Opening 15","", macro_MF)
aegisub.register_filter("BLEACH Opening 15","",2000,bleach)