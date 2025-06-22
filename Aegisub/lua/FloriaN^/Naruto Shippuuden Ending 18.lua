include("karaskel.lua")

script_name = "NARUTO Ending 18"

script_description = ""

script_author = "FloriaN"

script_version = ""

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

ll=0

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
	
	if (line.style == "Default") then
	
	--if inline FX is not reap then~
	if (syl.inline_fx ~= "reap") then
	
	--template char loop for intro effect below
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left+ (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\be10\\pos(%d,%d)\\blur2\\fad(%d,%d)\\fscx100\\fscy100\\t(%d,%d,\\fscx100\\frz%d\\frx%d\\fry%d\\fscy100\fry0)\\t(%d,%d,\\fscx100\\fscy100\\frx0\\fry0\\frz0)}%s",charx,chary,300,0,0,150,math.random(-360,360),math.random(-360,360),math.random(-360,360),150,300,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	--here is the multi highlight loop with many thanks to jfs!
	 for highlightindex = 1, #syl.highlights do 
	 local hl = syl.highlights[highlightindex]

	--Syl
   	l.text=string.format("{\\3c&H2A6ED0&\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx120\\fscy200)\\t(%d,%d,\\fscx100\\fscy100}%s",x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
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
	l.text = string.format("{\\1a&H%d&\\be1\\an5\\shad0\\bord0\\1c&HFFFFFF&\\pos(%d,%d)\\t(0.1\\fscx%d\\fscy%d\\alpha&HFF&)}%s",rr*9, x , y-2, 150+(g*15), 150+(g*15), syl.text_stripped)
	rr = rr + 1
	subs.append(l)
			end
		end
	ll=ll+1
	
	end
	
	--Template
	l.text=string.format("{\\an5\\be10\\blur2\\pos(%d,%d)\\fad(%d,%d)}%s",x,y,0,300,syl.text_stripped)
	l.start_time=line.start_time + syl.start_time
	l.end_time=line.end_time
	l.layer=1
	subs.append(l)
	
	end
	
	if (syl.inline_fx == "reap") then
	
	--Syl
   	l.text=string.format("{\\3c&H2A6ED0&\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx120\\fscy200)\\t(%d,%d,\\fscx100\\fscy100}%s",x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=4
	subs.append(l)
	
	--Template
	l.text=string.format("{\\an5\\blur2\\be10\\pos(%d,%d)\\fad(%d,%d)}%s",x,y,0,300,syl.text_stripped)
	l.start_time=line.start_time
	l.end_time=line.end_time
	l.layer=1
	subs.append(l)
   
	if syl.duration > 0 then
	l = table.copy(line)
	rr=1
	l.start_time = line.start_time + syl.start_time
	l.end_time = line.start_time + syl.end_time
	l.layer = ll
	for g=0, 9 do
	l.text = string.format("{\\1a&H%d&\\be1\\an5\\shad0\\bord0\\1c&HFFFFFF&\\pos(%d,%d)\\t(0.1\\fscx%d\\fscy%d\\alpha&HFF&)}%s",rr*9, x , y-2, 150+(g*15), 150+(g*15), syl.text_stripped)
	rr = rr + 1
	subs.append(l)
			end
		end
	ll=ll+1
	end
	
		end
	end
end

function macro_MF(subs, sel)

	aegisub.set_undo_point("before run macro")

	naru(subs, {ismacro=true, sel=sel})

end	

aegisub.register_macro("Naruto Ending 18","", macro_MF)

aegisub.register_filter("Naruto Ending 18","",2000,naru)