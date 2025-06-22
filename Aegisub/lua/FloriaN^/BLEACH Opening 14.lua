include("karaskel.lua")

script_name = "BLEACH Opening X"

script_description = "Fillers end 2013"

script_author = "FloriaN"

script_version = "beta v2"

function bleach(subs)
	local meta, styles = karaskel.collect_head(subs)
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and l.style ~= "OP English" and
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
	
	-- do not fx empty shit
	if syl.text_stripped ~= "" then
	
	if (line.style == "OP Romaji") then
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\alpha&80&\\be10\\pos(%d,%d)\\blur2\\fad(%d,%d)\\fscx100\\fscy100\\t(%d,%d,\\fscx100\\frz%d\\frx%d\\fry%d\\fscy100\fry0)\\t(%d,%d,\\fscx100\\fscy100\\frx0\\fry0\\frz0)}%s",charx,chary,300,0,0,150,math.random(-360,360),math.random(-360,360),math.random(-360,360),150,300,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
   
   time1 = 0
   time2 = 50
   for i=1, 60 do
   transform = transform .. string.format("{\\t(%d,%d,\\frz%d\\fscy%d\\fscx%d)}",time1,time2,math.random(-1,1),math.random(75,200),math.random(75,200))
   time1 = time1 + 100
   time2 = time2 + 100
   end
   
	--Syl
   	l.text=string.format("{\\an5\\bord3\\blur5\\pos(%d,%d)\\org(%d,%d)}%s%s",x,y,math.random(-400,400),math.random(-400,500),transform,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=5
	subs.append(l)
	
	-- Syl2
	l.text=string.format("{{\\an5\\1c&HFFFFFF&\\be10\\fs70\\bord0\\pos(%d,%d)\\org(%d,%d)}%s%s",x,y,400,400,transform,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=1
	subs.append(l)
	
	--Template
	l.text=string.format("{\\an5\\alpha&80&\\be10\\pos(%d,%d)\\fad(%d,%d)}%s",x,y,0,300,syl.text_stripped)
	l.start_time=line.start_time + syl.start_time
	l.end_time=line.end_time
	l.layer=1
	subs.append(l)
	
	else
		
	if (line.style == "OP Kanji") then
	
		for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\alpha&80&\\be10\\pos(%d,%d)\\blur2\\fad(%d,%d)\\fscx100\\fscy100\\t(%d,%d,\\fscx100\\frz%d\\frx%d\\fry%d\\fscy100\fry0)\\t(%d,%d,\\fscx100\\fscy100\\frx0\\fry0\\frz0)}%s",charx,chary,300,0,0,150,math.random(-360,360),math.random(-360,360),math.random(-360,360),150,300,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
		end
   
   time1 = 0
   time2 = 50
   for i=1, 60 do
   transform = transform .. string.format("{\\t(%d,%d,\\frz%d\\fscy%d\\fscx%d)}",time1,time2,math.random(-1,1),math.random(75,200),math.random(75,200))
   time1 = time1 + 100
   time2 = time2 + 100
   end
   
	--Syl
   	l.text=string.format("{\\an5\\bord3\\blur5\\pos(%d,%d)\\org(%d,%d)}%s%s",x,y,math.random(-400,400),math.random(-400,500),transform,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=5
	subs.append(l)
	
	-- Syl2
	l.text=string.format("{{\\an5\\1c&HFFFFFF&\\be10\\fs50\\bord0\\pos(%d,%d)\\org(%d,%d)}%s%s",x,y,400,400,transform,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=1
	subs.append(l)
	
	--Template
	l.text=string.format("{\\an5\\alpha&80&\\be10\\pos(%d,%d)\\fad(%d,%d)}%s",x,y,0,300,syl.text_stripped)
	l.start_time=line.start_time + syl.start_time
	l.end_time=line.end_time
	l.layer=1
	subs.append(l)
				end
			end
		end
	end
end

function macro_MF(subs, sel)

	aegisub.set_undo_point("before run macro")

	bleach(subs, {ismacro=true, sel=sel})

end	

aegisub.register_macro("Bleach Opening","", macro_MF)

aegisub.register_filter("Bleach Opening","",2000,bleach)