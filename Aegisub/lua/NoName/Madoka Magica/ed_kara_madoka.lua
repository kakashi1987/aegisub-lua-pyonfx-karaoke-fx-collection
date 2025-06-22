function romaji(line, l)

	
	math.randomseed(8317)

	

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=2
			
			
			l.start_time=line.start_time+50*syl.i-line.infade/2
			l.end_time=line.start_time+syl.start_time
			
			
			l.text=string.format("{\\an5\\bord0\\shad0\\blur1\\1c&H270595&\\3c&HF3E2F7&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\fad(100,0)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=2
			
			
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time
			
			
			l.text=string.format("{\\an5\\bord5\\shad0\\blur3\\1c&H270595&\\3c&H7C7C76&\\fscx120\\fscy120\\pos(%.3f,%.3f)\\jitter(2,2,2,2)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	

	local color_vsfiltermod="1vc(&HFAF9F5&,&HFAF9F5&,&HF7E2F9&,&HF7E2F9&)"
	local color_vsfilter="1c&HF9E6F5&"
	
	

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=1
			
			
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.end_time+50*syl.i+line.outfade/2
			
			
			l.text=string.format("{\\an5\\bord0\\shad0\\blur1\\1c&H270595&\\3c&HF3E2F7&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\fad(300,0)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
end


for li, line in ipairs(lines) do
	
	romaji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end