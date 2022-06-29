include("karaskel.lua")

script_name = "BLEACH Ending 28"

script_description = "Fillers end 2013"

script_author = "FloriaN"

script_version = "Final until Jecht changes"

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
			l.text = string.format("{\\3c%s\\shad0\\an5\\fscx200\\fscy200\\fry%d\\frx%d\\be2\\fad(360,0)\\move(%d,%d,%d,%d,%d,%d)\\t(0,400,\\fscx100\\fscy100\\3c%s\\frx0\\fry0)}%s",line.styleref.color1,math.random(-360,360),math.random(-360,360),charx,chary-20,charx,chary,0,400,line.styleref.color3,char)
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
		local x = line.left + syl.center
		local xl=line.center
		local y = line.middle
		local x_k = line.styleref.margin_l + line.margin_l
		local y_k = line.styleref.margin_v + line.margin_v + syl.left
		local l=table.copy(line)
		local lf=line.left
		local lr=line.right
		local lh=line.height
		local lw=line.width
		
	pox = 0
	
	-- do not fx empty shit
	if syl.text_stripped ~= "" then
	
	if (line.style == "Romaji") then
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\3c%s\\shad0\\an5\\fscx200\\fscy200\\fry%d\\frx%d\\be2\\fad(360,0)\\move(%d,%d,%d,%d,%d,%d)\\t(0,400,\\fscx100\\fscy100\\3c%s\\frx0\\fry0)}%s",line.styleref.color1,math.random(-360,360),math.random(-360,360),charx,chary-20,charx,chary,0,400,line.styleref.color3,char)
		l.start_time = line.start_time - 400 + (chari-1)*20
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	--Syl
   	l.text=string.format("{\\an5\\1a&88\\1c%s\\blur2\\move(%d,%d,%d,%d,%d,%d)\\t(500,1500,\\frz%s\\fscx80\\fscy80\\alpha&FF&)}%s",line.styleref.color2,x,y,x,y+math.random(5,10),500,1500,math.random(-30,30),syl.text_stripped)
	l.start_time=line.start_time+syl.start_time+syl.duration
	l.end_time=line.start_time+syl.end_time+1500
	l.layer=2
	subs.append(l)
   
   for i=0,5 do
	l.text=string.format("{\\an5\\pos(%d,%d)\\be1\\t(0,%d,\\fscx%d\\fscy%d\\be%d\\blur%d\\bord6)\\t(%d,%d,\\fscx100\\fscy100\\be3\\blur2\\bord2)}%s",x,y,syl.kdur*3,110+i*12,110+i*12,1+i*2,1+i*2,syl.kdur*3,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
	subs.append(l)
   end

	else
		
	if (line.style == "Kanji") then
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.styleref.margin_l + line.margin_l
		local chary = line.styleref.margin_v + line.margin_v + syl.left
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\3c%s\\shad0\\an7\\fscx200\\fscy200\\fry%d\\frx%d\\be2\\fad(360,0)\\move(%d,%d,%d,%d,%d,%d)\\t(0,400,\\fscx100\\fscy100\\3c%s\\frx0\\fry0)}%s",line.styleref.color1,math.random(-360,360),math.random(-360,360),charx,chary-20,charx,chary,0,400,line.styleref.color3,char)
		l.start_time = line.start_time - 400 + (chari-1)*20
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	
	--Syl
   	l.text=string.format("{\\an7\\1a&88\\1c%s\\blur2\\move(%d,%d,%d,%d,%d,%d)\\t(500,1500,\\frz%s\\fscx80\\fscy80\\alpha&FF&)}%s",line.styleref.color2,x_k,y_k,x_k,y_k+math.random(5,10),500,1500,math.random(-30,30),syl.text_stripped)
	l.start_time=line.start_time+syl.start_time+syl.duration
	l.end_time=line.start_time+syl.end_time+1500
	l.layer=2
	subs.append(l)
   
   for i=0,5 do
	l.text=string.format("{\\an7\\pos(%d,%d)\\be1\\t(0,%d,\\be%d\\blur%d\\bord3)\\t(%d,%d,\\fscx100\\fscy100\\be3\\blur2\\bord2)}%s",x_k,y_k,syl.kdur*3,1+i*2,1+i*2,syl.kdur*3,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
	subs.append(l)
   end
		
				end
			end
		end
	end
end

function macro_MF(subs, sel)

	aegisub.set_undo_point("before run macro")

	bleach(subs, {ismacro=true, sel=sel})

end	

aegisub.register_macro("Bleach Ending 28","", macro_MF)

aegisub.register_filter("Bleach Ending 28","",2000,bleach)