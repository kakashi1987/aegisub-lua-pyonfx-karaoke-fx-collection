--Kamisama Minarau ED2
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 250
	line.outfade = 250
	
	for ci,char in ipairs(line.chars) do
		
		color = utils.interpolate(char.i/#line.chars, "&HCC7FED&", "&H8FF8A6&")
		s_color = utils.interpolate(char.i/#line.chars, "&HC099FD&", "&HBBD26B&")
		
		if char.text~="" then
			--infade l1
			
			l.start_time = line.start_time - line.infade
			l.end_time = line.start_time+char.start_time
			
			l.layer = 5
			
			l.text = string.format("{\\an5\\b1\\bord3\\shad2\\blur1.8\\fscx100\\fscy100\\fad(250,0)\\4a&H64&\\1c%s\\3c%s\\4c%s\\pos(%.3f, %.3f)}%s"
			,color,color,s_color,char.center,char.middle,char.text)
			
			io.write_line(l)
			
		end
		
		if char.text~="" then
			--infade l2
			
			l.start_time = line.start_time - line.infade
			l.end_time = line.start_time+char.start_time
			
			l.layer = 6
			
			l.text = string.format("{\\an5\\b1\\bord0.1\\shad0\\blur3\\fscx100\\fscy100\\fad(250,0)\\3a&H64&\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
			,char.center,char.middle,char.text)
			
			io.write_line(l)
			
		end
		
		if char.text~="" then
			--char fx l1
			
			l.start_time = line.start_time + char.start_time - 50
			l.end_time = line.start_time + char.end_time + 50
			
			l.layer = 3
			
			local y1 = char.middle - 10*math.cos(math.rad(180*char.i))
			
			l.text = string.format("{\\an5\\b1\\bord3\\shad2\\blur1.8\\fscx100\\fscy100\\fad(50,50)\\4a&H64&\\1c%s\\3c%s\\4c%s\\move(%.3f, %.3f, %.3f, %.3f)}%s"
			,color,color,s_color,char.center,y1,char.center,char.middle,char.text)
			
			io.write_line(l)
			
		end
		
		if char.text~="" then
			--char fx l2
			
			l.start_time = line.start_time + char.start_time
			l.end_time = line.start_time + char.end_time
			
			l.layer = 8
			
			local y1 = char.middle - 10*math.cos(math.rad(180*char.i))
			
			l.text = string.format("{\\an5\\b1\\bord0.1\\shad0\\blur3\\fscx100\\fscy100\\3a&H64&\\1c&HFFFFFF&\\3c&H000000&\\move(%.3f, %.3f, %.3f, %.3f)}%s"
			,char.center,y1,char.center,char.middle,char.text)
			
			io.write_line(l)
			
		end
		
		if char.text~="" then
			--outfade l1
			
			l.start_time = line.start_time + char.end_time
			l.end_time = line.end_time + line.outfade
			
			l.layer = 5
			
			l.text = string.format("{\\an5\\b1\\bord3\\shad2\\blur1.8\\fscx100\\fscy100\\fad(0,250)\\4a&H64&\\1c%s\\3c%s\\4c%s\\pos(%.3f, %.3f)}%s"
			,color,color,s_color,char.center,char.middle,char.text)
			
			io.write_line(l)
			
		end
		
		if char.text~="" then
			--otfade l2
			
			l.start_time = line.start_time + char.end_time
			l.end_time = line.end_time + line.outfade
			
			l.layer = 6
			
			l.text = string.format("{\\an5\\b1\\bord0.1\\shad0\\blur3\\fscx100\\fscy100\\fad(0,250)\\3a&H64&\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
			,char.center,char.middle,char.text)
			
			io.write_line(l)
			
		end
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--eggs fx
			
			local max_frame = 200
			
			local egg = "m 0 0 b -13 0 -4 -18 0 -18 b 4 -18 14 0 0 0"
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				l.start_time = s - 150
				l.end_time = e + 600
				
				local step = i / n
				
				l.layer = 1
				
				local frz = math.randomsteps(0, 360, 45)
				
				local x, y = syl.center, syl.middle + math.random(-1,1)*10*math.sin(math.rad(utils.interpolate(step, 0, 180)))
				
				local dur = l.end_time - l.start_time
				local pul_1, pul_2, pul_3, pul_4 = dur/4, dur/2, 3*(dur/4), dur
				
				local color_array = {"&HABF8D0&", "&HD972AE&", "&H8D84D9&", "&HDD9F83&"}
				local color = color_array[math.random(1,table.getn(color_array))]
				
				l.text = string.format("{\\an5\\p1\\bord1\\shad0\\blur0.8\\1a&H64\\3c&H64&&\\frz%d\\t(\\frz%d)\\fscx10\\fscy10\\t(0,%d,\\fscx140\\fscy140)\\t(%d,%d,\\fscx30\\fscy30)\\t(%d,%d,\\fscx140\\fscy140)\\t(%d,%d,\\fscx30\\fscy30)\\1c&HFFFFFF&\\3c&H000000&\\fad(100,250)\\move(%.3f, %.3f, %.3f, %.3f)\\org(%d,%d)}%s"
				,frz,frz+math.randomsteps(-360, 360, 180),pul_1, pul_1,pul_2 ,pul_2,pul_3, pul_3,pul_4,x,y,x-50,y+math.random(-15,15),syl.center,syl.bottom,egg)
				
				io.write_line(l)
				
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end