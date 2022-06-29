--Madoka Magica movie 2: Insert song 2: Connect
--Karaoke by Amberdrake

function romaji(line, l)

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
			
			
			l.start_time=line.start_time+50*syl.i-line.infade/8
			l.end_time=line.start_time+syl.start_time
			
			
			l.text=string.format("{\\an5\\bord0\\shad0\\blur0.4\\1c&HFF0000&\\3c&HD1D1D1&\\fscx100\\fscy100\\move(%.3f,%.3f,%.3f,%.3f,0,50)\\fad(100,0)}%s"
			,syl.center-25,syl.middle-100,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=2
			
			shape_star="m 0 0 l -10 10 l -30 0 l -10 -10 l 0 -30 l 10 -10 l 30 0 l 10 10 l 0 30 l -10 10"
			
			l.start_time=line.start_time+syl.start_time-500
			l.end_time=line.start_time+syl.start_time
			
			
			l.text=string.format("{\\an7\\p1\\bord0\\shad0\\blur1\\fad(0,200)\\1c&H57DDF5&\\3c&HD1D1D1&\\fscx100\\fscy100\\frz0\\t(\\frz180)\\move(%.3f,%.3f,%.3f,%.3f)\\fad(100,0)}%s"
			,syl.center+100,syl.middle-100,syl.center,syl.middle,shape_star)
			
			
			io.write_line(l)
		end
	end	

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=4
			
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time
			
			
			l.text=string.format("{\\an5\\bord10\\shad0\\blur10\\fad(20,%d)\\1c&HFFFFFF&\\3c&HFFFFFF&\\fscx100\\fscy100\\pos(%.3f,%.3f)}%s"
			,syl.duration/2,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=3
			
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time+100
			
			
			l.text=string.format("{\\an5\\bord2\\shad0\\blur4\\1c&HFFFFFF&\\3c&H57DDF5&\\fscx110\\fscy110\\t(0,%d\\fscx120,\\fscy120\\blur10)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f)\\frz0\\t(\\frz110)}%s"
			,syl.duration*2,syl.duration/2,syl.center,syl.middle,syl.center-100,syl.middle+75,syl.text)
			
			
			io.write_line(l)
		end
	end
		


	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=1
			
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.end_time+25*syl.i+line.outfade/40
				
			l.text=string.format("{\\an5\\1a&HFF&\\bord2\\shad0\\blur2\\fad(%d,200)\\1c&HFF0000&\\3c&H000000&\\fscx100\\fscy100)\\pos(%.3f,%.3f)}%s"
			,syl.duration/2,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=2
			
			shape_star_small="m 0 -12 l -3 -4 l -12 -4 l -5 2 l -8 11 l 0 5 l 8 11 l 5 2 l 12 -4 l 3 -4 "
			
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.start_time+syl.end_time+750
			
			
			l.text=string.format("{\\an7\\p1\\bord0\\shad0\\blur2\\fad(0,200)\\1c&H57DDF5&\\3c&HD1D1D1&\\fscx100\\fscy100\\frz0\\t(\\frz720)\\move(%.3f,%.3f,%.3f,%.3f)\\fad(0,100)}%s"
			,syl.center,syl.middle,syl.center+75,syl.middle+75,shape_star_small)
			
			
			io.write_line(l)
		end
	end

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=2
			
			shape_star_small="m 0 -12 l -3 -4 l -12 -4 l -5 2 l -8 11 l 0 5 l 8 11 l 5 2 l 12 -4 l 3 -4 "
			
			l.start_time=line.start_time+syl.start_time+50
			l.end_time=line.start_time+syl.end_time+600
			
			
			l.text=string.format("{\\an7\\p1\\bord0\\shad0\\blur2\\fad(0,200)\\1c&H57DDF5&\\3c&HD1D1D1&\\fscx100\\fscy100\\frz0\\t(\\frz500)\\move(%.3f,%.3f,%.3f,%.3f)\\fad(0,100)}%s"
			,syl.center,syl.middle,syl.center-75,syl.middle+75,shape_star_small)
			
			
			io.write_line(l)
		end
	end

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=2
			
			shape_star_small="m 0 -12 l -3 -4 l -12 -4 l -5 2 l -8 11 l 0 5 l 8 11 l 5 2 l 12 -4 l 3 -4 "
			
			l.start_time=line.start_time+syl.start_time+40
			l.end_time=line.start_time+syl.end_time+800
			
			
			l.text=string.format("{\\an7\\p1\\bord0\\shad0\\blur2\\fad(0,200)\\1c&H57DDF5&\\3c&HD1D1D1&\\fscx100\\fscy100\\frz0\\t(\\frz-300)\\move(%.3f,%.3f,%.3f,%.3f)\\fad(0,100)}%s"
			,syl.center,syl.middle,syl.center,syl.middle+50,shape_star_small)
			
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=2
			
			shape_star_small="m 0 -12 l -3 -4 l -12 -4 l -5 2 l -8 11 l 0 5 l 8 11 l 5 2 l 12 -4 l 3 -4 "
			
			l.start_time=line.start_time+syl.start_time+60
			l.end_time=line.start_time+syl.end_time+800
			
			
			l.text=string.format("{\\an7\\p1\\bord0\\shad0\\blur2\\fad(0,200)\\1c&H57DDF5&\\3c&HD1D1D1&\\fscx100\\fscy100\\frz0\\t(\\frz-300)\\move(%.3f,%.3f,%.3f,%.3f)\\fad(0,100)}%s"
			,syl.center,syl.middle,syl.center,syl.middle+50,shape_star_small)
			
			
			io.write_line(l)
		end
	end	





end
for li, line in ipairs(lines) do
	
	romaji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end