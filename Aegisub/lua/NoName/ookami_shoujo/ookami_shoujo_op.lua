--Ookami Shoujo to Kuro Ouji Opening
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	if line.style == "Romaji" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--infade l1
				
				l.layer = 5
				
				l.start_time = line.start_time+25*char.i-line.infade
				l.end_time = line.start_time+char.start_time
				
				l.text = string.format("{\\an2\\bord3\\blur3\\shad0\\fscx100\\fscy100\\t(150,250,\\fscy50)\\t(250,500,\\fscy100)\\1c&H96BBFB&\\3c&H96BBFB&\\fad(150,0)\\move(%.3f, %.3f, %.3f, %.3f, 0, 300)}%s"
				,char.center,char.bottom-25,char.center,char.bottom,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--infade l2
				
				l.layer = 6
				
				l.start_time = line.start_time+25*char.i-line.infade
				l.end_time = line.start_time+char.start_time
				
				l.text = string.format("{\\an2\\bord1\\blur1.2\\shad0\\fscx100\\fscy100\\t(150,250,\\fscy50)\\t(250,500,\\fscy100)\\1c&HFFFFFF&\\3c&H96BBFB&\\fad(150,0)\\move(%.3f, %.3f, %.3f, %.3f, 0, 300)}%s"
				,char.center,char.bottom-25,char.center,char.bottom,char.text)
				
				io.write_line(l)
			end
		end
		
		for si,syl in ipairs(line.syls) do
			
			local max_frame = 25
			local a = 0
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				if syl.text~="" then
					--syl fx
					
					l.start_time = s
					l.end_time = e
					
					local x, y = syl.center + math.randomsteps(-5, 5, 2.5), syl.middle + math.randomsteps(-5, 5, 2.5)
					
					local scale = 120 + math.random(-5, 5)
					
					local frx, fry, frz = math.randomsteps(-10, 10, 5), math.randomsteps(-10, 10, 2.5), math.randomsteps(-10, 10, 5)
					
					local orgx, orgy = syl.center + 15*math.sin(math.rad(a)), syl.middle + 50*math.sin(math.rad(a))
					a = a + 15
					
					local maxj = 2
					for j = 1, 2, 1 do
						
						if j == 1 then
							
							l.layer = 7
							
							l.text = string.format("{\\an5\\bord3\\blur3\\shad0\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\1c&H96BBFB&\\3c&H96BBFB&\\org(%.3f, %.3f)\\pos(%.3f, %.3f)}%s"
							,scale,scale,frx,fry,frz,orgx,orgy,x,y,syl.text)
							
							io.write_line(l)
						end
						
						if j == 2 then
							
							l.layer = 8
							
							l.text = string.format("{\\an5\\bord1\\blur1.2\\shad0\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\1c&HFFFFFF&\\3c&H96BBFB&\\org(%.3f, %.3f)\\pos(%.3f, %.3f)}%s"
							,scale,scale,frx,fry,frz,orgx,orgy,x,y,syl.text)
							
							io.write_line(l)
						end
					end
				end
			end
			
			if syl.text~="" then
				--placeholder l1
				
				l.layer = 5
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord3\\blur3\\shad0\\fscx100\\fscy100\\1c&H96BBFB&\\3c&H96BBFB&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--placeholder l2
				
				l.layer = 6
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord1\\blur1.2\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&H96BBFB&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "Kanji" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--infade l1
				
				l.layer = 5
				
				l.start_time = line.start_time+25*char.i-line.infade
				l.end_time = line.start_time+char.start_time
				
				l.text = string.format("{\\an2\\bord3\\blur3\\shad0\\fscx100\\fscy100\\t(150,250,\\fscy50)\\t(250,500,\\fscy100)\\1c&H96BBFB&\\3c&H96BBFB&\\fad(150,0)\\move(%.3f, %.3f, %.3f, %.3f, 0, 300)}%s"
				,char.center,char.bottom-25,char.center,char.bottom,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--infade l2
				
				l.layer = 6
				
				l.start_time = line.start_time+25*char.i-line.infade
				l.end_time = line.start_time+char.start_time
				
				l.text = string.format("{\\an2\\bord1\\blur1.2\\shad0\\fscx100\\fscy100\\t(150,250,\\fscy50)\\t(250,500,\\fscy100)\\1c&HFFFFFF&\\3c&H96BBFB&\\fad(150,0)\\move(%.3f, %.3f, %.3f, %.3f, 0, 300)}%s"
				,char.center,char.bottom-25,char.center,char.bottom,char.text)
				
				io.write_line(l)
			end
			
			local max_frame = 25
			local a = 0
			
			for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
				if char.text~="" then
					--char fx
					
					l.start_time = s
					l.end_time = e
					
					local x, y = char.center + math.randomsteps(-5, 5, 2.5), char.middle + math.randomsteps(-5, 5, 2.5)
					
					local scale = 120 + math.random(-5, 5)
					
					local frx, fry, frz = math.randomsteps(-10, 10, 5), math.randomsteps(-10, 10, 2.5), math.randomsteps(-10, 10, 5)
					
					local orgx, orgy = char.center + 15*math.sin(math.rad(a)), char.middle + 50*math.sin(math.rad(a))
					a = a + 15
					
					local maxj = 2
					for j = 1, 2, 1 do
						
						if j == 1 then
							
							l.layer = 7
							
							l.text = string.format("{\\an5\\bord3\\blur3\\shad0\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\1c&H96BBFB&\\3c&H96BBFB&\\org(%.3f, %.3f)\\pos(%.3f, %.3f)}%s"
							,scale,scale,frx,fry,frz,orgx,orgy,x,y,char.text)
							
							io.write_line(l)
						end
						
						if j == 2 then
							
							l.layer = 8
							
							l.text = string.format("{\\an5\\bord1\\blur1.2\\shad0\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\1c&HFFFFFF&\\3c&H96BBFB&\\org(%.3f, %.3f)\\pos(%.3f, %.3f)}%s"
							,scale,scale,frx,fry,frz,orgx,orgy,x,y,char.text)
							
							io.write_line(l)
						end
					end
				end
			end
			
			if char.text~="" then
				--placeholder l1
				
				l.layer = 5
				
				l.start_time = line.start_time+char.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord3\\blur3\\shad0\\fscx100\\fscy100\\1c&H96BBFB&\\3c&H96BBFB&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--placeholder l2
				
				l.layer = 6
				
				l.start_time = line.start_time+char.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord1\\blur1.2\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&H96BBFB&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "TL" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--infade l1
				
				l.layer = 5
				
				l.start_time = line.start_time+25*char.i-line.infade
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an2\\bord3\\blur3\\shad0\\fscx100\\fscy100\\t(150,250,\\fscy50)\\t(250,500,\\fscy100)\\1c&H96BBFB&\\3c&H96BBFB&\\fad(150,250)\\move(%.3f, %.3f, %.3f, %.3f, 0, 300)}%s"
				,char.center,char.bottom-25,char.center,char.bottom,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--infade l2
				
				l.layer = 6
				
				l.start_time = line.start_time+25*char.i-line.infade
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an2\\bord1\\blur1.2\\shad0\\fscx100\\fscy100\\t(150,250,\\fscy50)\\t(250,500,\\fscy100)\\1c&HFFFFFF&\\3c&H96BBFB&\\fad(150,250)\\move(%.3f, %.3f, %.3f, %.3f, 0, 300)}%s"
				,char.center,char.bottom-25,char.center,char.bottom,char.text)
				
				io.write_line(l)
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end