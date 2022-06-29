--Fate/kaleid liner PRISMA ILLYA Zwei! ED TL
--Karaoke by Amberdrake
--VSFilter

function romanji(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 50 then
		line.outfade = 250
	end
	
	if line.text~="" then
		--infade
		maxj = line.height
		for j = 1,maxj,1 do
			
			l.layer = 8
			
			l.start_time = line.start_time-line.infade
			l.end_time = line.end_time+line.outfade
			
			local clip_src = shape.rectangle(line.width,1)
			local clip = shape.move(clip_src,line.left,line.top+j)
			local color = utils.interpolate(j/maxj,"&HF2CBFF&","&HFFFFFF&")
			
			l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\fad(250,250)\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
			,color,clip,line.center,line.middle,line.text)
			
			io.write_line(l)
		end
		
	end
	
	if line.text~=" " and line.text~="" then
		--infade outline
		
		l.layer = 7
		
		l.start_time = line.start_time-line.infade
		l.end_time = line.end_time+line.outfade
		
		l.text=string.format("{\\an5\\blur1\\bord1\\shad0\\fscx100\\fscy100\\1c&H715492&\\3c&H715492&\\fad(250,250)\\pos(%.3f, %.3f)}%s"
		,line.center,line.middle,line.text)
		
		io.write_line(l)
	end
	
	if line.text~=" " and line.text~="" then
		--infade outline 2
		
		l.layer = 6
		
		l.start_time = line.start_time-line.infade
		l.end_time = line.end_time+line.outfade
		
		l.text=string.format("{\\an5\\blur1\\bord2\\shad0\\fscx100\\fscy100\\1c&H503586&\\3c&H503586&\\fad(250,250)\\pos(%.3f, %.3f)}%s"
		,line.center,line.middle,line.text)
		
		io.write_line(l)
	end
	
	if line.text~=" " and line.text~="" then
		--infade outline 3
		
		l.layer = 5
		
		l.start_time = line.start_time-line.infade
		l.end_time = line.end_time+line.outfade
		
		l.text=string.format("{\\an5\\blur4\\bord4\\shad0\\fscx100\\fscy100\\1c&HE0BFF5&\\3c&HE0BFF5&\\fad(250,250)\\pos(%.3f, %.3f)}%s"
		,line.center,line.middle,line.text)
		
		io.write_line(l)
	end
	
end
for li, line in ipairs(lines) do
	
	romanji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end