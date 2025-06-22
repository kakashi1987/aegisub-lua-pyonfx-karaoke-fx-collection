include("karaskel.lua")

script_name = "BLEACH Ending X"

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
		if l.class == "dialogue" and l.style ~= "ED English" and
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
	
	if (line.style == "ED Romaji") then
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(%d,%d)\\t(%d,%d,\\blur2\\be2)\\t(%d,%d,\\fscx100\\fscy100\\blur0\\be0)}%s",charx,chary,400,0,0,400,400,800,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	count = 0
	
	for syl in unicode.chars(syl.text) do
	count = count+1
	end
   
	--Syl
   	l.text=string.format("{\\an5\\pos(%d,%d)\\t(0,%d,\\be10\\fscy200\\bord0.2\\3c%s\\fscx120)\\t(%d,%d,\\fscx100\\fscy100\\3c%s\\bord2}%s",x,y,syl.duration/2,line.styleref.color1,syl.duration/2,syl.duration,line.styleref.color1,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
	subs.append(l)
   
    --Syl2
	 l.text = string.format("{\\shad0\\an5\\pos(%d,%d)\\be5\\t($start,$mid,\\fscy150)\\t($mid,$end,\\fscx150\\fscy250)\\t(!$end-80!,$end,\\alpha&HFF&)\\1c&HFFFFFF&\\bord0)}%s",x,y,syl.text)
	 l.start_time = line.start_time + syl.start_time
	 l.end_time = l.start_time + 30 + syl.duration 
     l.layer = 1
	 subs.append(l)
	 
	 for i=0, 20 do
	 --Syl3
	 l.text = string.format("{\\an5\\bord1\\blur2\\1c&HFFFFFF&\\3c&HFFFFFF&\\move(%d,%d,%d,%d)\\fad(%d,%d)\\p4}m 20 0  b  20 10  30 20  40 20  b  30 20  20 30  20 40  b  20 30  10 20  0 20  b  10 20  20 10  20 0}%s",x,y,x+math.random(-50,50),y+math.random(-50,50),100,300,syl.text)
	 l.start_time = line.start_time + syl.start_time + math.random(0,1000)
	 l.end_time = line.start_time + syl.end_time + math.random(-1000,2000)
     l.layer = 1
	 subs.append(l)
	 end	
	
	--Template
	l.text=string.format("{\\3c%s\\be10\\fad(%d,%d)\\an5\\pos(%d,%d)\\t(%d,%d,\\3c%s)\\t(%d,%d,\\1c%s,\\3c%s)}%s",line.styleref.color1,0,500,x,y,0,600,line.styleref.color3,line.end_time-line.start_time+100-syl.end_time+(syl.i-count)*100,line.end_time-line.start_time+600-syl.end_time+(syl.i-count)*100,line.styleref.color1,line.styleref.color3,syl.text_stripped)
	l.start_time=line.start_time + syl.end_time
	l.end_time=line.start_time + syl.end_time + 600 +(syl.i-count)*100
	l.layer=1
	subs.append(l)
	
	else
		
	if (line.style == "ED Kanji") then
	
		for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(%d,%d)\\t(%d,%d,\\blur2\\be2)\\t(%d,%d,\\fscx100\\fscy100\\blur0\\be0)}%s",charx,chary,400,0,0,400,400,800,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	count = 0
	
	for syl in unicode.chars(syl.text) do
	count = count+1
	end
   
	--Syl
   	l.text=string.format("{\\an5\\pos(%d,%d)\\t(0,%d,\\be10\\fscy200\\bord0.2\\3c%s\\fscx120)\\t(%d,%d,\\fscx100\\fscy100\\3c%s\\bord2}%s",x,y,syl.duration/2,line.styleref.color1,syl.duration/2,syl.duration,line.styleref.color1,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
	subs.append(l)
   
    --Syl2
	 l.text = string.format("{\\shad0\\an5\\pos(%d,%d)\\be5\\t($start,$mid,\\fscy150)\\t($mid,$end,\\fscx150\\fscy250)\\t(!$end-80!,$end,\\alpha&HFF&)\\1c&HFFFFFF&\\bord0)}%s",x,y,syl.text)
	 l.start_time = line.start_time + syl.start_time
	 l.end_time = l.start_time + 30 + syl.duration 
     l.layer = 1
	 subs.append(l)
	 
	 for i=0, 20 do
	 --Syl3
	 l.text = string.format("{\\an5\\bord1\\blur2\\1c&HFFFFFF&\\3c&HFFFFFF&\\move(%d,%d,%d,%d)\\fad(%d,%d)\\p4}m 20 0  b  20 10  30 20  40 20  b  30 20  20 30  20 40  b  20 30  10 20  0 20  b  10 20  20 10  20 0}%s",x,y,x+math.random(-50,50),y+math.random(-50,50),100,300,syl.text)
	 l.start_time = line.start_time + syl.start_time + math.random(0,1000)
	 l.end_time = line.start_time + syl.end_time + math.random(-1000,2000)
     l.layer = 1
	 subs.append(l)
	 end	
	
	--Template
	l.text=string.format("{\\3c%s\\be10\\fad(%d,%d)\\an5\\pos(%d,%d)\\t(%d,%d,\\3c%s)\\t(%d,%d,\\1c%s,\\3c%s)}%s",line.styleref.color1,0,500,x,y,0,600,line.styleref.color3,line.end_time-line.start_time+100-syl.end_time+(syl.i-count)*100,line.end_time-line.start_time+600-syl.end_time+(syl.i-count)*100,line.styleref.color1,line.styleref.color3,syl.text_stripped)
	l.start_time=line.start_time + syl.end_time
	l.end_time=line.start_time + syl.end_time + 600 +(syl.i-count)*100
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

aegisub.register_macro("Bleach Ending","", macro_MF)

aegisub.register_filter("Bleach Ending","",2000,bleach)