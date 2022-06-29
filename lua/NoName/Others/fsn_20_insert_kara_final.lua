--Fate/stay night: Unlimited Blade Works ED2
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 300
	line.outfade = 300
	
	if line.style == "fsn_insert_romaji" or line.style == "fsn_insert_kanji" then
		
		for ci, char in ipairs(line.chars) do
			
			if char.text~="" and char.text~=" " and char.text~="　" then
				--infade fx layer 1
				local l = table.copy(line)
				
				local bx1, by1 = char.left + math.randomsteps(-100,100,25), char.top + math.randomsteps(-30,30,10)
				local bx2, by2 = char.left + math.randomsteps(-55,65,5), char.top + math.randomsteps(-45,45,15)
				local bx3, by3 = char.left + math.randomsteps(-40,45,5), char.bottom + math.randomsteps(-55,55,10)
				local bx4, by4 = char.left + math.randomsteps(-40,30,5), char.bottom + math.randomsteps(-20,20,5)
				
				for pi, pixel in ipairs(convert.text_to_pixels(char.text, line.styleref)) do
					
					l.layer = 5
					
					l.start_time=line.start_time-line.infade+32*char.i-600
					l.end_time=line.start_time+32*char.i-32
					
					local x, y = char.center, char.middle
					
					local px, py = char.left + pixel.x, char.top + pixel.y
					
					local bpoint = math.bezier(math.randomsteps(0, 1, 0.01),
					{
					{bx1, by1},
					{bx2, by2},
					{bx3, by3},
					{bx4, by4}
					}
					)
					
					local mx, my = bpoint[1] + math.random(-1,1), bpoint[2] + math.random(-1,1)
					
					local ms, me = 0, math.randomsteps(100, l.end_time-50, 25)-l.start_time
					
					local fad = math.random(char.duration+500, char.duration+1000)
					
					local color = "&HFAF529&"
					
					l.text=string.format("{\\an7\\bord0.1\\blur0.1\\shad1\\fscx100\\fscy100\\fad(%d,0)\\1c%s\\3c%s\\4c&HFFFFFF&\\4a&H64&\\move(%.3f,%.3f,%.3f,%.3f, %.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
					,fad,color,color,mx,my,px,py,ms,me)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" and char.text~=" " and char.text~="　" then
				--infade fx layer 2
				local l = table.copy(line)
				
				local bx1, by1 = char.left + math.randomsteps(-50,65,5), char.top + math.randomsteps(-20,20,5)
				local bx2, by2 = char.left + math.randomsteps(35,65,5), char.top + math.randomsteps(-15,25,5)
				local bx3, by3 = char.left + math.randomsteps(-45,15,5), char.bottom + math.randomsteps(-35,65,5)
				local bx4, by4 = char.left + math.randomsteps(-20,30,5), char.bottom + math.randomsteps(-40,40,5)
				
				for pi, pixel in ipairs(convert.text_to_pixels(char.text, line.styleref)) do
					
					l.layer = 5
					
					l.start_time=line.start_time-line.infade+32*char.i-600
					l.end_time=line.start_time+32*char.i-100
					
					local x, y = char.center, char.middle
					
					local px, py = char.left + pixel.x + math.random(-3, 3), char.top + pixel.y + math.random(-3, 3)
					
					local bpoint = math.bezier(math.randomsteps(0, 1, 0.01),
					{
					{bx1, by1},
					{bx2, by2},
					{bx3, by3},
					{bx4, by4}
					}
					)
					
					local mx, my = bpoint[1] + math.random(-1,1), bpoint[2] + math.random(-1,1)
					
					local ms, me = 0, math.randomsteps(100, l.end_time-50, 25) - l.start_time
					
					local fad = math.random(500, l.end_time-l.start_time)
					
					local color = "&HFCFF95&"
					
					l.text=string.format("{\\an7\\bord0.1\\blur0.1\\shad1\\fscx100\\fscy100\\fad(%d,0)\\1c%s\\3c%s\\4c&HFFFFFF&\\4a&H64&\\move(%.3f,%.3f,%.3f,%.3f, %.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
					,fad,color,color,mx,my,px,py,ms,me)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--infade fx 2 layer 1
				l.layer = 7
				
				l.start_time=line.start_time+32*char.i-32
				l.end_time=l.start_time+250
				
				l.text=string.format("{\\an8\\bord2\\blur3\\shad0\\fscx100\\fscy120\\t(\\blur1\\bord0.2\\fscy100)\\fad(50,100)\\1c&HFCFFC3&\\3c&HFCFFC3&\\pos(%.3f,%.3f)}%s"
				,char.center,char.top,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--infade fx 2 layer 2
				l.layer = 7
				
				l.start_time=line.start_time+32*char.i-32
				l.end_time=l.start_time+250
				
				l.text=string.format("{\\an2\\bord2\\blur3\\shad0\\fscx100\\fscy120\\t(\\blur1\\bord0.2\\fscy100)\\fad(50,100)\\1c&HFCFFC3&\\3c&HFCFFC3&\\pos(%.3f,%.3f)}%s"
				,char.center,char.bottom,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--placeholder bord
				l.layer = 5
				
				l.start_time=line.start_time+32*char.i-32
				l.end_time=line.start_time+char.start_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\shad0\\fscx100\\fscy100\\1c&HFCFFC3&\\3c&HFCFFC3&\\pos(%.3f,%.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--placeholder main
				l.layer = 6
				
				l.start_time=line.start_time+32*char.i-32
				l.end_time=line.start_time+char.start_time
				
				l.text=string.format("{\\an5\\bord0.5\\blur0.6\\shad0\\fscx100\\fscy100\\1c&H958721&\\3c&FFFFFF&\\pos(%.3f,%.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--placeholder 2 bord
				l.layer = 5
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time-32*#line.chars
				
				l.text=string.format("{\\an5\\bord2\\blur3\\shad0\\fscx100\\fscy100\\1c&HFCFFC3&\\3c&HFCFFC3&\\pos(%.3f,%.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--placeholder 2 main
				l.layer = 6
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time-32*#line.chars
				
				l.text=string.format("{\\an5\\bord0.5\\blur0.6\\shad0\\fscx100\\fscy100\\1c&H958721&\\3c&FFFFFF&\\pos(%.3f,%.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" and char.text~=" " and char.text~="　" then
				--oufade fx layer 1
				local l = table.copy(line)
				
				local bx1, by1 = char.left + math.randomsteps(-100,100,25), char.top + math.randomsteps(-30,30,10)
				local bx2, by2 = char.left + math.randomsteps(-55,65,5), char.top + math.randomsteps(-45,45,15)
				local bx3, by3 = char.left + math.randomsteps(-40,45,5), char.bottom + math.randomsteps(-55,55,10)
				local bx4, by4 = char.left + math.randomsteps(-40,30,5), char.bottom + math.randomsteps(-20,20,5)
				
				for pi, pixel in ipairs(convert.text_to_pixels(char.text, line.styleref)) do
					
					l.layer = math.random(1,7)
					
					l.start_time=line.end_time-32*#line.chars
					l.end_time=line.end_time+1000+25*char.i-32*#line.chars
					
					local x, y = char.center, char.middle
					
					local px, py = char.left + pixel.x, char.top + pixel.y
					
					local bpoint = math.bezier(math.randomsteps(0, 1, 0.01),
					{
					{bx1, by1},
					{bx2, by2},
					{bx3, by3},
					{bx4, by4}
					}
					)
					
					local mx, my = bpoint[1] + math.random(-1,1), bpoint[2] + math.random(-1,1)
					
					local ms, me = math.randomsteps(0, 1000, 50), l.end_time-l.start_time
					
					local fad = math.random(char.duration+500, char.duration+1000)
					
					local color = "&HFAF529&"
					
					l.text=string.format("{\\an7\\bord0.1\\blur0.1\\shad1\\fscx100\\fscy100\\fad(0,%d)\\1c%s\\3c%s\\4c&HFFFFFF&\\4a&H64&\\move(%.3f,%.3f,%.3f,%.3f, %.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
					,fad,color,color,px,py,mx,my,ms,me)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--fadeout bord
				l.layer = 6
				
				l.start_time=line.end_time-32*#line.chars
				l.end_time=line.end_time+250+25*char.i-32*#line.chars
				
				local cc_s = l.end_time-l.start_time-150
				local cc_e = l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\shad0\\fscx100\\fscy100\\1c&H958721&\\t(%d,%d,\\1c&HFCFFC3&)\\3c&HFCFFC3&\\fad(0,250)\\pos(%.3f,%.3f)}%s"
				,cc_s,cc_e,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
		
		for si, syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--syl fx bord
				l.layer = 7
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord3\\blur5.5\\shad0\\fscx130\\fscy130\\t(\\bord1\\blur2.5\\fscx100\\fscy100)\\1c&HFCFFC3&\\3c&HFCFFC3&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx main
				l.layer = 8
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0.5\\blur0.6\\shad0\\fscx140\\fscy140\\t(\\fscx100\\fscy100)\\1c&H958721&\\3c&FFFFFF&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--syl fx 2
				
				l.layer = 10
				
				local start_time = line.start_time+syl.start_time
				local end_time = line.start_time+syl.end_time
				local max_frame = 50
				
				for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do
					
					for s, e, i, n in utils.frames(start_time, end_time, max_frame) do
						
						l.start_time = s
						l.end_time = e
						
						local step = i / n
						
						local cx, cy = (syl.left + syl.right)/2, (syl.bottom + syl.top)/2
						local px, py = syl.left + pixel.x, syl.top + pixel.y
						
						local vx, vy = (px - cx)/2, (py - cy)/2
						
						local x, y = utils.interpolate(step, px+vx, px) + math.randomsteps(-0.5, 0.5, 0.1), utils.interpolate(step, py+vy, py) + math.randomsteps(-0.5, 0.5, 0.1)
						
						local color = "&HFCFF95&"
						
						l.text=string.format("{\\an7\\bord0\\blur0.1\\sha01\\fscx100\\fscy100\\1c%s\\pos(%.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
						,color,x,y)
						
						io.write_line(l)
					end
				end
			end
		end
	end
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end