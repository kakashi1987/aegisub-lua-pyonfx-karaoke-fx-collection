--Date A Live II OP
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	if line.infade > 250 then
		line.infade = 250
	end
	if line.outfade > 250 then
		line.outfade = 250
	end
	
	if line.style == "OP_romanji" or line.style == "OP_kanji" then
		
		for si, syl in ipairs(line.syls) do
			if syl.text~="" then
				--infade
				
				l.layer=2
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.2\\shad0\\fscx100\\fscy100\\1c&H000000&\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f, 0,250)}%s"
				,syl.center-25,syl.middle,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--bord infade
				
				l.layer=1
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord4\\blur3\\shad0\\fscx100\\fscy100\\1a&HFF&\\3c&HFFFFFF&\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f, 0,250)}%s"
				,syl.center-25,syl.middle,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl effect
				
				max_frame = 25
				a = 0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer=2
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					shear = math.sin(math.rad(a))/10
					a = a + 90
					
					y = syl.middle + utils.interpolate(step, -10, 0)
					
					l.text=string.format("{\\an5\\bord0\\blur0.2\\shad0\\fscx100\\fscy100\\fax%.3f\\1c&H000000&\\pos(%.3f,%.3f)}%s"
					,shear,syl.center,y,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--syl bord effect
				
				max_frame = 25
				a = 0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer=1
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					shear = math.sin(math.rad(a))/10
					a = a + 90
					
					y = syl.middle + utils.interpolate(step, -10, 0)
					
					l.text=string.format("{\\an5\\bord3\\blur4\\shad0\\fscx100\\fscy100\\fax%.3f\\1a&HFF&\\3c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
					,shear,syl.center,y,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--outfade
				
				l.layer=2
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time+line.outfade
				
				of_start=l.end_time-l.start_time-250
				of_end=l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.2\\shad0\\fscx100\\fscy100\\1c&H000000&\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f, %d,%d)}%s"
				,syl.center,syl.middle,syl.center+25,syl.middle,of_start,of_end,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--bord outfade
				
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time+line.outfade
				
				of_start=l.end_time-l.start_time-250
				of_end=l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\bord4\\blur3\\shad0\\fscx100\\fscy100\\1a&HFF&\\3c&HFFFFFF&\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f, %d,%d)}%s"
				,syl.center,syl.middle,syl.center+25,syl.middle,of_start,of_end,syl.text)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "OP_TL" then
		
		for si, syl in ipairs(line.syls) do
			if syl.text~="" then
				--infade
				
				l.layer=2
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.2\\shad0\\fscx100\\fscy100\\1c&H000000&\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f, 0,250)}%s"
				,syl.center-25,syl.middle,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--bord infade
				
				l.layer=1
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord4\\blur3\\shad0\\fscx100\\fscy100\\1a&HFF&\\3c&HFFFFFF&\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f, 0,250)}%s"
				,syl.center-25,syl.middle,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			if syl.text~="" then
				--outfade
				
				l.layer=2
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time+line.outfade
				
				of_start=l.end_time-l.start_time-250
				of_end=l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.2\\shad0\\fscx100\\fscy100\\1c&H000000&\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f, %d,%d)}%s"
				,syl.center,syl.middle,syl.center+25,syl.middle,of_start,of_end,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--bord outfade
				
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time+line.outfade
				
				of_start=l.end_time-l.start_time-250
				of_end=l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\bord4\\blur3\\shad0\\fscx100\\fscy100\\1a&HFF&\\3c&HFFFFFF&\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f, %d,%d)}%s"
				,syl.center,syl.middle,syl.center+25,syl.middle,of_start,of_end,syl.text)
				
				io.write_line(l)
			end
		end
	end
	
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end