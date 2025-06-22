--Trinity Seven ED3 kara
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 250
	line.outfade = 250
	
	if line.style == "ED_Romaji" or line.style == "ED_Romaji_L" or line.style == "ED_Romaji_R" or line.style == "ED_Kanji" or line.style == "ED_Kanji_L" or line.style == "ED_Kanji_R" then
		
		if line.actor == "fx_1" then
			
			if line.effect == "red" then
				color = "&H2C0C8F&"
			end
			if line.effect == "blue" then
				color = "&HDF992A&"
			end
			
			for ci,char in ipairs(line.chars) do
				
				if char.text~="" then
					--fx_1 infade
					
					l.layer = 5
					
					l.start_time = line.start_time-line.infade+25*char.i-25-50*#line.chars
					l.end_time = line.start_time+char.start_time
					
					local rsx, rsy = char.center + math.randomsteps(-50, -20, 5), char.middle + math.randomsteps(-50, -20, 10)
					local frx, fry = math.randomsteps(-360, 360, 90), math.randomsteps(-360, 360, 45)
					
					l.text=string.format("{\\an5\\b1\\blur5\\bord1\\fscx100\\fscy100\\frx%d\\fry%d\\t(0,500,\\frx0\\fry0)\\1c%s\\3c%s\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f, 0,500)}%s"
					,frx,fry,color,color,rsx,rsy,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
				
				if char.text~="" then
					--fx_1 fx1
					
					l.layer = 4
					
					l.start_time = line.start_time+char.start_time
					l.end_time = line.start_time+char.end_time
					
					l.text=string.format("{\\an5\\b1\\blur3\\fscx100\\fscy100\\t(0,%d,\\blur10\\fscx200\\fscy200)\\t(%d,%d,\\blur3\\fscx100\\fscy100)\\bord0\\1c%s\\fad(%d,%d)\\pos(%.3f,%.3f)}%s"
					,char.duration/2,char.duration/2,char.duration,color,char.duration/4,3*char.duration/4,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
				
				if char.text~="" then
					--fx_1 fx2
					
					l.layer = 5
					
					local re = math.randomsteps(250, 500, 50)
					
					l.start_time = line.start_time+char.start_time
					l.end_time = line.start_time+char.end_time+re
					
					local rsx, rsy = char.center + math.randomsteps(20, 50, 5), char.middle + math.randomsteps(20, 50, 10)
					local frx, fry = math.randomsteps(-360, 360, 90), math.randomsteps(-360, 360, 45)
					
					l.text=string.format("{\\an5\\b1\\blur5\\bord1\\fscx100\\fscy100\\t(0,150,\\bord3\\fscx120\\fscy120)\\t(150,%.3f,\\bord1\\fscx100\\fscy100)\\frx0\\fry0\\t(\\frx%d\\fry%d)\\1c%s\\3c%s\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
					,char.duration+re,frx,fry,color,color,char.center,char.middle,rsx,rsy,char.text)
					
					io.write_line(l)
				end
			end
		else
			for ci,char in ipairs(line.chars) do
				if char.text~="" then
					--infade
					
					l.layer = 5
					
					l.start_time = line.start_time-line.infade+25*char.i-25
					l.end_time = line.start_time+char.start_time
					
					if line.effect == "green2" then
						color = "&H2AE519&"
					elseif line.effect == "blue2" then
						color = "&HA60C0E&"
					elseif line.effect == "red2" then
						color = "&H2000C8&"
					elseif line.effect == "lblue2" then
						color = "&HEAD41B&"
					elseif line.effect == "yellow2" then
						color = "H33A49D&"
					elseif line.effect =="white" then
						color = "&H000000&"
					end
					
					l.text=string.format("{\\an5\\bord1\\blur1.5\\fscx100\\fscy100\\fry90\\t(0,100,\\fry30\\fscx150\\fscy150)\\t(100,200,\\fry0\\fscx100\\fscy100)\\1c&HFFFFFF&\\3c%s\\pos(%.3f,%.3f)}%s"
					,color,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
				
				if char.text~="" then
					--line shad
					
					l.layer = 2
					
					l.start_time = line.start_time-line.infade+25*char.i-25
					l.end_time = line.start_time+char.end_time
					
					if line.effect == "green2" then
						color = "&H2AE519&"
						x1, y1 = char.center - 2, char.middle - 2
						x2, y2 = char.center - 5, char.middle - 5
					elseif line.effect == "blue2" then
						color = "&HA60C0E&"
						x1, y1 = char.center + 2, char.middle - 2
						x2, y2 = char.center + 5, char.middle - 5
					elseif line.effect == "red2" then
						color = "&H2000C8&"
						x1, y1 = char.center - 2, char.middle - 2
						x2, y2 = char.center - 5, char.middle - 5
					elseif line.effect == "lblue2" then
						color = "&HEAD41B&"
						x1, y1 = char.center + 2, char.middle - 2
						x2, y2 = char.center + 5, char.middle - 5
					elseif line.effect == "yellow2" then
						color = "&H0CFFEE&"
						x1, y1 = char.center - 2, char.middle - 2
						x2, y2 = char.center - 5, char.middle - 5
					elseif line.effect =="white" then
						color = "&H000000&"
						x1, y1 = char.center, char.middle
						x2, y2 = char.center, char.middle
					end
					
					local of_start = l.end_time - l.start_time - char.duration
					local of_end = l.end_time - l.start_time
					
					l.text=string.format("{\\an5\\bord2\\blur0.6\\fscx100\\fscy100\\fry90\\t(0,100,\\fry30\\fscx150\\fscy150)\\t(100,200,\\fry0\\fscx100\\fscy100)\\1c%s\\3c%s\\t(%d,%d,\\fscx200\\blur3)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
					,color,color,of_start,of_end,char.duration,x1,y1,x2,y2,char.text)
					
					io.write_line(l)
				end
			end
			
			for si,syl in ipairs(line.syls) do
				if syl.text~="" then
					--fx1
					
					local max_frame = 12
					
					for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
						
						l.layer = 8
						
						l.start_time = s
						l.end_time = e + 250
						
						step = i / n
						
						if line.effect == "green2" then
							color = "&H2AE519&"
						elseif line.effect == "blue2" then
							color = "&HA60C0E&"
						elseif line.effect == "red2" then
							color = "&H2000C8&"
						elseif line.effect == "lblue2" then
							color = "&HEAD41B&"
						elseif line.effect == "yellow2" then
							color = "H33A49D&"
						elseif line.effect =="white" then
							color = "&H000000&"
						end
						
						local sc = 100 + 20*math.sin(math.rad(utils.interpolate(step, 0, 180)))
						local y = syl.middle
						local x1 = utils.interpolate(step, syl.center, syl.center - 5)
						local x2 = x1 + 10
						
						l.text=string.format("{\\an5\\bord1\\blur1.5\\fscx%.3f\\fscy%.3f\\1c&HFFFFFF&\\3c%s\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
						,sc,sc,color,x1,y,x2,y,syl.text)
						
						io.write_line(l)
					end
				end
			end
		end
	end
	
	if line.style == "ED_TL" or line.style == "ED_TL_L" or line.style == "ED_TL_R" then
		
		for ci,char in ipairs(line.chars) do
			if char.text~="" then
				--TL infade
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+25*char.i-25
				l.end_time = line.end_time-line.outfade
				
				if line.effect == "green2" then
					color = "&H2AE519&"
				elseif line.effect == "blue2" then
					color = "&HA60C0E&"
				elseif line.effect == "red2" then
					color = "&H2000C8&"
				elseif line.effect == "lblue2" then
					color = "&HEAD41B&"
				elseif line.effect == "yellow2" then
					color = "H33A49D&"
				elseif line.effect =="white" then
					color = "&H000000&"
				end
				
				l.text=string.format("{\\an5\\bord1\\blur1.5\\fscx100\\fscy100\\fry90\\t(0,100,\\fry30\\fscx150\\fscy150)\\t(100,200,\\fry0\\fscx100\\fscy100)\\1c&HFFFFFF&\\fad(0,250)\\3c%s\\pos(%.3f,%.3f)}%s"
				,color,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--TL line shad
				
				l.layer = 2
				
				l.start_time = line.start_time-line.infade+25*char.i-25
				l.end_time = line.end_time-line.outfade
				
				if line.effect == "green2" then
					color = "&H2AE519&"
					x1, y1 = char.center - 2, char.middle - 2
					x2, y2 = char.center - 5, char.middle - 5
				elseif line.effect == "blue2" then
					color = "&HA60C0E&"
					x1, y1 = char.center + 2, char.middle - 2
					x2, y2 = char.center + 5, char.middle - 5
				elseif line.effect == "red2" then
					color = "&H2000C8&"
					x1, y1 = char.center - 2, char.middle - 2
					x2, y2 = char.center - 5, char.middle - 5
				elseif line.effect == "lblue2" then
					color = "&HEAD41B&"
					x1, y1 = char.center + 2, char.middle - 2
					x2, y2 = char.center + 5, char.middle - 5
				elseif line.effect == "yellow2" then
					color = "&H0CFFEE&"
					x1, y1 = char.center - 2, char.middle - 2
					x2, y2 = char.center - 5, char.middle - 5
				elseif line.effect =="white" then
					color = "&H000000&"
					x1, y1 = char.center, char.middle
					x2, y2 = char.center, char.middle
				end
				
				local of_start = l.end_time - l.start_time - char.duration
				local of_end = l.end_time - l.start_time
				
				l.text=string.format("{\\an5\\bord2\\blur0.6\\fscx100\\fscy100\\fry90\\t(0,100,\\fry30\\fscx150\\fscy150)\\t(100,200,\\fry0\\fscx100\\fscy100)\\1c%s\\3c%s\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,color,color,x1,y1,x2,y2,char.text)
				
				io.write_line(l)
			end
		end
		
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end