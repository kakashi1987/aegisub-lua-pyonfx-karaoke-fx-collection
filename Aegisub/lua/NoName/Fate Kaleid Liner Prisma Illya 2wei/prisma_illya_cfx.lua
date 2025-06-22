--Fate/kaleid liner PRISMA ILLYA Zwei! combat effects
--Effects by Amberdrake
--VSFilter

function cfx(line, l)
	
	line.infade = 0
	line.outfade = 0
	
	if line.style == "CFX_Pyramide" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--cfx pyramide text
				
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-250+50*syl.i, line.end_time+250+50*syl.i, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local infad, outfad = 250, 250
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fx_max = math.ceil((syl.end_time-syl.start_time)/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = "&H00&"
						sc = 100
						x, y = syl.center + (utils.interpolate(u_in/inmax, 30*math.sin(math.rad(45*syl.i)), 0)), syl.middle + (utils.interpolate(u_in/inmax, 30*math.sin(math.rad(90*syl.i)), 0))
						frz = utils.interpolate(u_in/inmax, math.randomsteps(-45, 45, 15), 0)
						u_in = u_in + 1
					elseif i >= math.ceil(syl.start_time/max_frame) and i <= math.ceil(syl.end_time/max_frame) then
						sc = utils.interpolate(u_fx/fx_max, 150, 100)
						x, y = syl.center, syl.middle + 7*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 360)))
						frz = 10*math.sin(math.rad(a))
						u_fx = u_fx + 1
						a = a + 90
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						sc = 100
						x, y = syl.center + (utils.interpolate(u_out/outmax, 0, 30*math.sin(math.rad(45*syl.i)))), syl.middle + (utils.interpolate(u_out/outmax, 0, 30*math.sin(math.rad(90*syl.i))))
						frz = utils.interpolate(u_out/outmax, 0, math.randomsteps(-45, 45, 15))
						u_out = u_out + 1
					else
						sc = 100
						x, y = syl.center, syl.middle
						frz = 0
						alpha="&H00&"
					end
					
					l.text = string.format("{\\an5\\blur0.6\\bord1.5\\shad0\\fscx%d\\fscy%d\\frz%d\\alpha%s\\1c&HF5A0F5&\\3c&H000000&\\4c&H85D0EB&\\pos(%.3f, %.3f)}%s"
					,sc,sc,frz,alpha,x,y,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--cfx pyramide triangle
				
				local triangle_source = shape.triangle(80)
				local triangle = shape.tooutline(triangle_source,3)
				
				l.layer = 4
				
				l.start_time = line.start_time-250
				l.end_time = line.end_time+250
				
				local x1, y, x2 = line.left - 15, line.middle+5, line.right + 15
				
				l.text = string.format("{\\p1\\an5\\blur3\\bord1\\shad0\\fscx100\\fscy100\\frz0\\t(\\frz360)\\fad(250,250)\\1c&HF5A0F5&\\3c&HFFFFFF&\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,x1,y,x2,y,triangle)
				
				io.write_line(l)
			end
		end
	end
	if line.style == "CFX_Trance" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--cfx trance text
				
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+50*char.i-50, line.end_time+line.outfade+50*char.i+50, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local infad, outfad = 100, 250
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fx_max = math.ceil((char.end_time-char.start_time)/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = "&H00&"
						sc = 100
						x, y = utils.interpolate(u_in/inmax, char.left, char.center), char.middle - 15*math.sin(math.rad(utils.interpolate(u_in/inmax, 0, 360)))
						u_in = u_in + 1
					elseif i >= math.ceil(char.start_time/max_frame) and i <= math.ceil(char.end_time/max_frame) then
						sc = 100+20*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 180)))
						x, y = char.center, char.middle + 7*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 360)))
						u_fx = u_fx + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						sc = 100
						x, y = utils.interpolate(u_out/outmax, char.center, char.right), char.middle - 15*math.sin(math.rad(utils.interpolate(u_out/outmax, 0, 360)))
						u_out = u_out + 1
					else
						sc = 100
						x, y = char.center, char.middle
						alpha="&H00&"
					end
					
					l.text = string.format("{\\an5\\blur0.6\\bord1.5\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&HF5A0F5&\\3c&H000000&\\4c&H85D0EB&\\pos(%.3f, %.3f)}%s"
					,sc,sc,alpha,x,y,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--cfx trance feathers
				
				local feather = "m 0 0 b -18 0 -37 -2 -53 8 l -44 1 l -55 3 b -54 -7 -47 -11 -40 -20 b -53 -12 -60 -9 -63 7 b -67 2 -67 -8 -68 -15 b -71 -12 -71 0 -72 7 b -73 2 -74 -6 -74 -13 b -75 -6 -75 2 -74 7 b -74 10 -79 11 -81 12 b -107 9 -187 79 -172 111 b -171 114 -168 113 -163 108 b -143 80 -124 59 -91 45 b -81 38 -74 30 -70 25 b -69 25 -67 24 -66 24 b -67 27 -67 31 -66 34 b -63 37 -61 39 -62 34 b -63 30 -63 27 -62 23 b -58 29 -52 31 -47 35 b -50 31 -56 27 -57 22 b -52 27 -45 31 -38 33 b -43 29 -50 25 -54 19 b -47 21 -41 21 -33 20 b -40 19 -48 18 -52 15 b -44 11 -28 3 0 0 "
				
				local maxj = math.random(5,10)
				for j = 1, maxj, 1 do
					
					l.layer = 4
					
					l.start_time = line.start_time+char.start_time
					l.end_time = line.end_time+line.outfade
					
					local sx, sy = math.random(char.left, char.right), math.random(char.top, char.bottom)
					local xrot1, yrot1 = math.randomsteps(-360,-90, 15), math.randomsteps(-360,-90, 15)
					local xrot2, yrot2 = math.randomsteps(90, 360, 15), math.randomsteps(90, 360, 15)
					local msx, msy = sx + math.randomsteps(-60, -40, 5), sy + math.randomsteps(-20, 20, 5)
					local rf1, rf2 = math.randomsteps(100,250,50), math.randomsteps(150,250,25)
					
					l.text = string.format("{\\p4\\an7\\blur3\\bord0.1\\shad0\\fscx80\\fscy120\\1c&HF7E6FD&\\3c&HFFFFFF&\\fad(%d, %d)\\1a&H32&\\3a&H64&\\frx%d\\fry%d\\t(\\frx%.3f\\fry%.3f\\fscx150\\fscy150)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
					,rf1,rf2,xrot1,yrot1,xrot2,yrot2,sx,sy,msx,msy,feather)
					
					io.write_line(l)
				end
			end
		end
	end
	
	if line.style == "CFX_Illya" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--cfx Illya text
				
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+50*char.i-50, line.end_time+line.outfade+50*char.i-50, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					if char.i%2 == 0 then
						y1 = char.middle - 30
					else
						y1 = char.middle + 30
					end
					
					local rx, ry = math.randomsteps(-90,90,15), math.randomsteps(-90,90,30)
					
					local xmove, ymove = char.center + math.randomsteps(-30, 30, 5), char.middle + math.randomsteps(-30, 30, 10)
					
					local infad, outfad = 250, 250
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fx_max = math.ceil((char.end_time-char.start_time)/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						sc = 100
						x, y = char.center, utils.interpolate(u_in/inmax, y1, char.middle)
						xrot, yrot = 0, 0
						u_in = u_in + 1
					elseif i >= math.ceil(char.start_time/max_frame) and i <= math.ceil(char.end_time/max_frame) then
						alpha = "&H00&"
						sc = 100+20*math.sin(math.rad(a))
						x, y = char.center, char.middle
						xrot, yrot = 0, 0
						u_fx = u_fx + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						sc = utils.interpolate(u_out/outmax, 100, 150)
						xrot,yrot = utils.interpolate(u_out/outmax, 0, rx), utils.interpolate(u_out/outmax, 0, ry)
						x, y = utils.interpolate(u_out/outmax, char.center, xmove), utils.interpolate(u_out/outmax, char.middle, ymove)
						u_out = u_out + 1
					else
						alpha = "&H00&"
						xrot, yrot = 0, 0
						sc = 100
						x, y = char.center, char.middle
					end
					
					l.text = string.format("{\\an5\\blur0.6\\bord1.5\\shad0\\fscx%d\\fscy%d\\frx%d\\fry%d\\1c&HF5A0F5&\\3c&H000000&\\4c&H85D0EB&\\pos(%.3f, %.3f)}%s"
					,sc,sc,xrot,yrot,x,y,char.text)
					
					io.write_line(l)
					
					a = a + 30
				end
			end
			
			if char.text~="" and char.i == 1 then
				--cfx Illya circle
				
				local circle = shape.ellipse(10, 40)
				
				l.layer = 4
				
				l.start_time = line.start_time
				l.end_time = l.start_time + 1000
				
				local fad = (l.end_time - l.start_time)/2
				
				local x, y = line.left - 15, line.middle
				
				l.text = string.format("{\\p1\\an5\\blur1\\bord6\\shad0\\fscx100\\fscy100\\3c&HF5A0F5&\\fad(50,%d)\\1a&HFF&\\t(0,%d,\\fscx130\\fscy200)\\pos(%.3f,%.3f)}%s"
				,fad,fad,x,y,circle)
				
				io.write_line(l)
			end
			
			if char.text~="" and char.i == 1 then
				--cfx Illya projectile
				
				local projectile = "m -1 0 b -8 -34 -38 -3 -50 0 b -38 3 -8 33 -1 0 "
				
				l.layer = 2
				
				l.start_time = line.start_time
				l.end_time = l.start_time + 500
				
				local x1, y, x2 = line.left - 15, line.middle, line.right+50
				
				l.text = string.format("{\\p1\\an7\\blur1.5\\be5\\bord0\\shad0\\fscx100\\fscy100\\1c&H652EAD&\\fad(50,50)\\3a&H65&\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,x1,y,x2,y,projectile)
				
				io.write_line(l)
			end
			
			if char.text~="" and char.i == 1 then
				--cfx Illya projectile outline
				
				local projectile = "m -1 0 b -8 -34 -38 -3 -50 0 b -38 3 -8 33 -1 0 "
				
				l.layer = 3
				
				l.start_time = line.start_time
				l.end_time = l.start_time + 500
				
				local x1, y, x2 = line.left - 15, line.middle, line.right+50
				
				l.text = string.format("{\\p1\\an7\\blur3\\bord8\\shad0\\fscx100\\fscy100\\1c&HF5A0F5&\\3c&HF5A0F5&\\fad(50,50)\\1a&H64&\\3a&H62&\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,x1,y,x2,y,projectile)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "CFX_Luvia" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--cfx Luvia text if/of
				
				local max_frame = 23.976
				
				local u_in, u_out = 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e + 100
					
					local fad = 250
					local max = math.ceil(fad/max_frame)
					
					if i < math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						sc = utils.interpolate(u_in/max, 150, 0)
						u_in = u_in + 1
					elseif i > (n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						sc = utils.interpolate(u_out/max, 100, 150)
						u_out = u_out + 1
					else
						alpha = "&H00&"
						xrot, yrot = 0, 0
						sc = 100
					end
					
					l.text = string.format("{\\an5\\blur3\\bord0.2\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&H00FFFF&\\3c&H000000&\\fad(0,100)\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--cfx Luvia text fx
				
				local max_frame = 5
				
				local b = 0
				
				for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time+500, max_frame) do
					
					l.layer = 6
					
					l.start_time = s
					l.end_time = e + 250
					
					local step = i / n
					
					local sc = 100 + 50*math.sin(math.rad(utils.interpolate(step, 0, 180))) + 15*math.sin(b)
					b = b + 15
					
					l.text = string.format("{\\an5\\blur0.2\\bord0.2\\shad0\\fscx%d\\fscy%d\\fad(0,250)\\1a&HFF&\\3a&H96&\\3c&H00FFFF&\\pos(%.3f,%.3f)}%s"
					,sc,sc,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--cfx Luvia magical circle
				
				local mcircle = "m 58 0 b 90 0 116 26 116 58 b 116 90 90 115 58 115 b 26 115 0 90 0 58 b 0 26 26 0 58 0 m 58 1 b 27 1 1 27 1 58 b 1 89 27 114 58 114 b 89 114 115 89 115 58 b 115 27 89 1 58 1 m 58 3 b 87 3 113 29 113 58 b 113 87 87 112 58 112 b 29 112 3 87 3 58 b 3 29 29 3 58 3 m 58 2 b 28 2 2 28 2 58 b 2 88 28 113 58 113 b 88 113 114 88 114 58 b 114 28 88 2 58 2 m 58 11 b 82 11 105 31 105 58 b 105 84 82 104 58 104 b 34 104 11 84 11 58 b 11 31 34 11 58 11 m 58 12 b 35 12 12 32 12 58 b 12 83 35 103 58 103 b 81 103 104 83 104 58 b 104 32 81 12 58 12 m 58 11 l 98 34 l 98 81 l 58 104 l 18 81 l 18 34 l 58 11 m 58 12 l 18 35 l 19 34 l 19 81 l 18 80 l 58 103 l 98 80 l 97 81 l 97 34 l 98 35 l 58 12 m 33 26 b 40 38 31 51 19 52 l 18 51 b 30 51 39 38 32 26 m 38 23 b 47 37 38 57 19 58 l 18 57 b 37 57 46 37 37 23 m 38 92 b 47 77 69 77 77 93 l 76 93 b 68 78 48 78 39 92 m 71 95 b 65 85 51 85 44 95 l 43 95 b 50 84 66 84 72 95 l 71 96 m 97 58 b 79 57 69 37 78 24 l 78 23 l 79 24 b 70 37 80 56 97 57 m 97 52 b 86 53 75 38 84 26 l 85 27 l 84 28 b 77 38 87 52 97 51 m 58 44 b 66 44 72 50 72 58 b 72 66 66 72 58 72 b 50 72 44 66 44 58 b 44 50 50 44 58 44 m 58 45 b 51 45 45 51 45 58 b 45 65 51 71 58 71 b 65 71 71 65 71 58 b 71 51 65 45 58 45 m 58 46 b 64 46 70 52 70 58 b 70 64 64 70 58 70 b 52 70 46 64 46 58 b 46 52 52 46 58 46 m 58 47 b 53 47 47 53 47 58 b 47 63 53 69 58 69 b 63 69 69 63 69 58 b 69 53 63 47 58 47 m 66 34 l 98 34 l 98 35 l 82 63 l 81 62 l 97 35 l 66 35 m 19 34 l 50 34 l 50 35 l 19 35 l 35 62 l 34 62 l 18 35 m 58 11 l 59 11 l 59 27 l 58 27 m 58 47 l 59 47 l 59 69 l 58 69 l 58 47 m 58 87 l 59 87 l 59 103 l 58 103 l 58 87 m 19 80 l 30 73 l 31 72 l 32 73 l 19 81 m 48 63 l 67 52 l 67 53 l 48 64 m 83 42 l 98 34 l 98 35 l 83 43 m 85 73 l 97 80 l 97 81 l 85 74 l 84 74 m 38 47 l 39 45 l 39 46 l 47 51 l 46 52 l 45 51 m 49 53 l 49 52 l 67 62 l 68 63 l 67 64 l 67 63 l 49 53 m 43 75 l 43 76 l 59 104 l 58 104 l 42 76 m 74 75 l 75 76 l 74 77 l 59 103 l 58 103 m 70 50 l 78 45 l 78 46 l 70 51 m 54 7 l 62 7 l 62 8 l 54 8 m 58 4 l 59 4 l 59 10 l 58 10 m 61 10 b 53 12 53 3 61 5 l 61 6 b 55 5 54 10 61 9 m 104 33 l 105 34 b 100 40 95 29 103 30 l 103 31 b 97 30 101 38 104 33 m 101 33 b 101 32 102 31 103 32 b 104 33 102 35 101 33 m 58 27 b 63 27 66 31 66 35 b 66 39 63 43 58 43 b 53 43 50 39 50 35 b 50 31 53 27 58 27 m 58 28 b 53 28 51 32 51 35 b 51 39 54 42 58 42 b 63 42 65 38 65 35 b 65 31 62 28 58 28 m 78 61 b 83 61 86 65 86 69 b 86 73 83 77 78 77 b 73 77 70 73 70 69 b 70 65 73 61 78 61 m 78 62 b 73 62 71 66 71 69 b 71 73 74 76 78 76 b 83 76 85 72 85 69 b 85 65 82 62 78 62 m 38 61 b 43 61 46 65 46 69 b 46 73 43 77 38 77 b 33 77 30 73 30 69 b 30 65 33 61 38 61 m 38 62 b 33 62 31 66 31 69 b 31 73 34 76 38 76 b 43 76 45 72 45 69 b 45 65 42 62 38 62 m 58 42 l 59 43 l 59 44 l 58 44 m 58 72 l 59 72 l 59 81 l 58 81 m 45 65 l 46 64 l 46 65 l 45 66 m 70 64 l 72 65 l 71 66 l 70 65 m 33 43 l 32 43 l 18 35 l 18 34 l 32 42 l 33 42 m 36 63 l 39 63 l 39 68 b 36 66 33 68 34 71 l 36 70 l 35 69 l 38 69 l 37 72 l 36 71 l 35 72 b 36 74 40 73 40 69 l 44 71 l 43 73 l 42 73 l 43 71 l 43 72 l 41 71 b 35 80 28 66 38 66 l 38 64 l 36 64 m 20 51 b 21 43 26 34 34 28 l 34 29 b 27 35 22 43 21 51 m 39 25 b 49 17 67 17 78 25 l 78 26 b 66 18 50 18 39 26 m 83 29 b 89 33 95 42 96 51 l 95 51 b 95 45 89 34 83 30 m 96 58 b 97 72 87 85 76 91 l 75 90 l 76 90 b 87 83 96 71 95 58 m 70 94 b 62 98 53 97 45 94 l 45 93 b 53 96 62 97 70 93 m 39 91 b 26 84 20 73 20 58 l 21 57 b 21 73 27 83 39 90 m 72 66 l 78 65 l 75 67 b 77 66 79 66 80 69 b 80 68 82 68 83 68 l 84 67 l 84 69 b 80 68 78 71 81 74 l 79 75 l 80 73 l 80 74 b 79 74 79 72 79 71 b 77 72 74 71 74 67 l 74 68 l 74 71 m 75 68 b 75 70 78 71 79 70 b 80 68 76 66 75 68 m 53 32 l 53 31 l 54 32 b 55 29 60 28 62 32 l 63 31 l 63 32 l 62 33 b 59 29 56 30 54 33 m 56 36 b 54 34 55 31 58 31 b 61 31 62 34 60 36 l 61 38 l 62 37 l 62 38 l 61 39 l 60 39 l 60 38 l 59 36 b 60 37 56 37 57 36 l 56 38 l 56 39 l 55 39 l 54 38 l 54 37 l 55 38 l 56 36 m 58 32 b 55 32 55 36 58 36 b 61 36 61 32 58 32 m 100 85 l 101 83 l 100 82 l 101 82 b 100 80 102 77 105 80 l 104 80 b 102 78 100 82 104 82 b 104 82 102 83 101 82 l 103 83 l 103 84 l 102 83 l 101 85 m 56 106 b 59 107 59 109 56 110 b 58 109 58 107 56 106 m 60 110 b 57 109 57 107 60 106 b 58 107 58 109 60 110 m 58 105 b 58 107 60 108 61 108 b 59 108 58 110 58 111 b 58 109 56 108 55 108 b 57 108 58 106 58 105 m 11 33 b 11 30 14 30 15 32 b 15 35 12 35 11 33 m 12 32 b 12 33 13 34 14 33 b 14 32 13 31 12 32 m 12 84 b 12 81 15 81 16 83 b 16 86 13 86 12 84 m 13 83 b 13 84 14 85 15 84 b 15 83 14 82 13 83 m 15 33 l 17 34 l 17 33 l 18 35 l 16 35 l 17 35 l 14 33 m 15 83 l 18 85 l 18 84 l 19 86 l 17 86 l 18 86 l 15 84"
				
				l.layer = 4
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.end_time+line.outfade
				
				local x1, y, x2 = line.left - 15, line.middle, line.right + 15
				
				l.text = string.format("{\\p1\\an5\\blur1\\bord0.1\\shad0\\fscx80\\fscy80\\frz0\\t(\\frz720)\\fad(250,250)\\1c&H00FFFF&\\3c&HA61478&\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,x1,y,x2,y,mcircle)
				
				io.write_line(l)
			end
			
		end
	end
	
	if line.style == "CFX_Miyu" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--cfx Miyu text
				
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e + 150
					
					local infad, outfad = 250, 250
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fx_max = math.ceil((char.end_time-char.start_time)/max_frame)
					
					local vx = char.center - line.center
					local of_mov = char.center + 2*vx
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						sc = 100
						x, y = utils.interpolate(u_in/inmax, line.center, char.center), char.middle
						u_in = u_in + 1
					elseif i >= math.ceil(char.start_time/max_frame) and i <= math.ceil(char.end_time/max_frame) then
						sc = 100+30*math.sin(math.rad(a))
						x, y = char.center + math.randomsteps(-3, 3, 0.5), char.middle + math.randomsteps(-3, 3, 0.5)
						u_fx = u_fx + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						sc = 100
						x, y = utils.interpolate(u_out/outmax, char.center, of_mov), char.middle
						u_out = u_out + 1
					else
						sc = 100
						x, y = char.center, char.middle
						alpha="&H00&"
					end
					
					a = a + 35
					
					l.text = string.format("{\\an5\\blur0.6\\bord0\\shad2\\fscx%d\\fscy%d\\alpha%s\\1c&HC94108&\\4c&H000000&\\fad(0,150)\\pos(%.3f, %.3f)}%s"
					,sc,sc,alpha,x,y,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" and char.i == 1 then
				--cfx Miyu explosion layer 3
				local boom = shape.ellipse(40, 40)
				
				local max_frame = 23.976
				
				local xpos,ypos = line.center, line.middle
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 3
					
					local step = i / n
					
					local sc = 100+80*math.sin(math.rad(utils.interpolate(step, 0, 90)))
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord0\\fscx%d\\fscy%d\\1c&HFFB489&\\pos(%.3f, %.3f)}%s"
					,sc,sc,xpos,ypos,boom)
					
					io.write_line(l)
					
				end
				
			end
			
			if char.text~="" and char.i == 1 then
				--cfx Miyu explosion layer 2
				
				local max_frame = 23.976
				
				local xpos,ypos = line.center, line.middle
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 2
					
					local step = i / n
					
					local exp = shape.ellipse(50,50)
					local deform = shape.filter(shape.split(exp),
					function(x,y)
						local xdef = math.randomsteps(-2,2,1)
						local ydef = math.randomsteps(-2,2,0.5)
						return x+xdef, y+ydef
					end)
					
					local sc = 100+90*math.sin(math.rad(utils.interpolate(step, 0, 90)))
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord0\\fscx%d\\fscy%d\\1c&HE5621D&\\pos(%.3f, %.3f)}%s"
					,sc,sc,xpos,ypos,deform)
					
					io.write_line(l)
					
				end
				
			end
			
			if char.text~="" and char.i == 1 then
				--cfx Miyu explosion layer 1
				
				local max_frame = 23.976
				local u_in, u_out = 0, 0
				
				local xpos,ypos = line.center, line.middle
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+100, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 3
					
					local step = i / n
					
					local ring = shape.ring(30,28)
					local deform = shape.filter(shape.split(ring),
					function(x,y)
						local xdef = math.randomsteps(-1,1,0.25)
						local ydef = math.randomsteps(-1,1,0.5)
						return x+xdef, y+ydef
					end)
					
					local fad = 250
					local max=math.ceil(fad/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						u_in=u_in+1
					elseif i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					sc = 100+120*math.sin(math.rad(utils.interpolate(step, 0, 90)))
					
					l.text = string.format("{\\an5\\p1\\blur1.5\\bord0\\fscx%d\\fscy%d\\alpha%s\\1c&HE5621D&\\pos(%.3f, %.3f)}%s"
					,sc,sc,alpha,xpos,ypos,deform)
					
					io.write_line(l)
					
				end
				
			end
		end
	end
	
	if line.style == "CFX_KuroIllya" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--cfx KuroIllya text
				
				l.layer = 5
				
				l.start_time = line.start_time-100
				l.end_time = line.end_time+100
				
				local of_start, of_end = l.end_time - l.start_time - 100, l.end_time - l.start_time
				
				l.text = string.format("{\\an5\\blur0.6\\bord4\\shad0\\fscx180\\fscy180\\1c&H1F8006&\\3c&H000000&\\t(0,100,\\fscx100\\fscy100)\\fad(100,100)\\t(%d,%d,\\fscx50\\fscy50)\\pos(%.3f,%.3f)}%s"
				,of_start,of_end,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--cfx KuroIllya majutsu kairo fx
				
				local majutsu_kairo = "m 0 0 l 0 0 l 24 0 l 32 -6 l 54 -6 l 70 -6 l 106 -6 l 117 -14 l 152 -14 l 176 -1 l 194 -1 l 200 -10 l 227 -10 l 227 -8 l 201 -8 l 195 1 l 176 1 l 152 -12 l 117 -12 l 106 -4 l 70 -4 l 54 -4 l 32 -4 l 24 2 l 38 6 l 54 6 l 61 10 l 71 10 l 84 3 l 100 3 l 115 -4 l 148 -4 l 176 7 l 227 7 l 227 9 l 176 9 l 176 9 l 148 -2 l 115 -2 l 100 5 l 84 5 l 71 12 l 61 12 l 54 8 l 38 8 l 24 4 l 19 2 l 0 2 m 100 5 l 115 14 l 149 14 l 170 6 l 168 5 l 148 12 l 115 12 l 102 4 m 0 -14 l 17 -14 l 23 -9 l 38 -9 l 43 -14 l 64 -14 l 73 -18 l 88 -18 l 98 -24 l 123 -24 l 158 -23 l 170 -11 l 195 -11 l 204 -21 l 225 -21 l 225 -23 l 203 -23 l 194 -13 l 171 -13 l 159 -25 l 123 -26 l 98 -26 l 88 -20 l 73 -20 l 64 -16 l 43 -16 l 38 -11 l 23 -11 l 17 -16 l 0 -16 l 0 -16 m 17 -16 l 23 -22 l 38 -22 l 43 -16 l 46 -16 l 39 -24 l 22 -24 l 14 -16 m 0 15 l 35 15 l 53 21 l 72 21 l 83 12 l 100 12 l 119 26 l 146 26 l 175 14 l 227 14 l 227 16 l 175 16 l 147 28 l 119 28 l 99 14 l 83 14 l 72 23 l 53 23 l 35 17 l 0 17 m 61 23 l 68 28 l 98 28 l 107 19 l 108 20 l 98 30 l 67 30 l 58 23 "
				
				local max_frame = 1
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 6
					
					l.start_time = s
					l.end_time = e
					
					step = i / n
					
					local vis = utils.interpolate(step, 1, syl.width+10)
					local clip_src = shape.rectangle(vis,syl.height+40)
					local clip = shape.move(clip_src,syl.left-5,syl.top-20)
					
					l.text = string.format("{\\p1\\an4\\blur3\\bord0.1\\shad0\\fscx120\\fscy100\\1c&H4FFF86&\\3c&HFFFFFF&\\clip(%s)\\pos(%.3f,%.3f)}%s"
					,clip,syl.left-5,syl.middle+20,majutsu_kairo)
					
					io.write_line(l)
				end
			end
		end
	end
	
	if line.style == "CFX_Fragarach" then
		
		line.infade = 0
		line.outfade = 0
		
		for ci,char in ipairs(line.chars) do
			
			local rrx1, rry1, rrz1 = math.randomsteps(-180, 180, 5), math.randomsteps(-180, 180, 5), math.randomsteps(-180, 180, 5)
			local rrx2, rry2, rrz2 = math.randomsteps(-180, 180, 5), math.randomsteps(-180, -180, 5), math.randomsteps(-180, -180, 5)
			
			if char.text~="" then
				--cfx fragarach text
				
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-1000+50*char.i, line.end_time+50*char.i, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					local infad, outfad = 250, 250
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fxmax = math.ceil((char.end_time-char.start_time)/max_frame)
					
					if s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
						l.layer = 6
						alpha="&H00&"
						x, y = char.center, char.middle
						frx, fry, frz = math.randomsteps(-10,10,2), math.randomsteps(-10,10,2.5), math.random(-10,10)
						sc, bord, blur = utils.interpolate(u_fx/fxmax, 135, 100), 1.5+2*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180))), 2+3*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180)))
						u_fx = u_fx + 1
					elseif i < math.ceil(infad/max_frame) then
						l.layer = 4
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						x, y = utils.interpolate(u_in/inmax, char.center + line.width/2, char.center), char.middle
						frx, fry, frz = utils.interpolate(u_in/inmax, rrx1, 0), utils.interpolate(u_in/inmax, rry1, 0), utils.interpolate(u_in/inmax, rrz1, 0)
						sc, bord, blur = 100, 1.5, 2
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						l.layer = 3
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						x, y = utils.interpolate(u_out/outmax, char.center, char.center - line.width/2), char.middle
						frx, fry, frz = utils.interpolate(u_out/outmax, 0, rrx2), utils.interpolate(u_out/outmax, 0, rry2), utils.interpolate(u_out/outmax, 0, rrz2)
						sc, bord, blur = 100, 1.5, 2
						u_out = u_out + 1
					else
						l.layer = 5
						x, y = char.center, char.middle
						alpha="&H00&"
						frx, fry, frz = 0, 0, 0
						sc, bord, blur = 100, 1.5, 2
					end
					
					l.text = string.format("{\\b1\\an5\\bord%.2f\\blur%.2f\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\alpha%s\\1c&HFFFFFF&\\3c&HE2B761&\\pos(%.3f, %.3f)}%s"
					,bord,blur,sc,sc,frx,fry,frz,alpha,x,y,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" and char.i == 1 then
				--cfx fragarach sphere 1
				
				local sphere = shape.ellipse(25,25)
				local max_frame = 23.976
				local u_in, u_out = 0, 0
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-250, line.end_time+250, max_frame) do
					
					l.layer = 7
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local sc = 100 + 5*math.sin(math.rad(a))
					a = a + 60
					
					local infad, outfad = 250, 250
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						u_out = u_out + 1
					else
						alpha="&H00&"
					end
					
					local x, y = utils.interpolate(step, line.left - 30, line.right + 30), line.top
					
					l.text = string.format("{\\p1\\an5\\blur1.5\\bord0\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&HC0AD9A&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,x,y,sphere)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" and char.i == 1 then
				--cfx fragarach sphere 2
				
				local sphere2 = shape.ellipse(15,10)
				local max_frame = 23.976
				local u_in, u_out = 0, 0
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-250, line.end_time+250, max_frame) do
					
					l.layer = 7
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local sc = 100 + 5*math.sin(math.rad(a))
					a = a + 25
					
					local infad, outfad = 250, 250
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						u_out = u_out + 1
					else
						alpha="&H00&"
					end
					
					local sphere_deform = shape.filter(shape.split(sphere2),
					function(x,y)
						local xdef = math.randomsteps(-2,2,1)
						local ydef = math.randomsteps(-2,2,0.5)
						return x+xdef, y+ydef
					end)
					
					local x, y = utils.interpolate(step, line.left - 30, line.right + 30), line.top
					
					l.text = string.format("{\\p1\\an5\\blur3\\bord0\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,x,y,sphere_deform)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" and char.i == 1 then
				--cfx fragarach bezier 1
				maxj = 200
				for j = 1, maxj, 1 do
					
					local max_frame = 23.976
					local u_in, u_out = 0, 0
					local a = 0
					
					for s, e, i, n in utils.frames(line.start_time-250, line.end_time+250, max_frame) do
						
						l.layer = 8
						
						l.start_time = s
						l.end_time = e
						
						local step = i / n
						
						local bx1, by1 = utils.interpolate(step, char.left + 10, char.left + 25), utils.interpolate(step, char.middle - 5, char.middle + 5)
						local bx2, by2 = utils.interpolate(step, char.right + 5, char.right + 10), utils.interpolate(step, char.middle - 25, char.middle - 35)
						local bx3, by3 = utils.interpolate(step, char.right + 3, char.right -5), utils.interpolate(step, char.middle - 40, char.middle - 55)
						local bx4, by4 = utils.interpolate(step, char.left + 3, char.left - 8), utils.interpolate(step, char.middle -35, char.middle - 60)
						local bx5, by5 = utils.interpolate(step, char.left + 5, char.left - 5), utils.interpolate(step, char.middle -20, char.middle - 30)
						local bx6, by6 = utils.interpolate(step, char.right - 15, char.right - 5), utils.interpolate(step, char.middle - 3, char.middle + 7)
						
						local bpoint = math.bezier(1/(200/j),
						{
						{bx1, by1},
						{bx2, by2},
						{bx3, by3},
						{bx4, by4},
						{bx5, by5},
						{bx6, by6}
						}
						)
						
						local xo, yo = bpoint[1], bpoint[2]
						
						local infad, outfad = 300, 300
						local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
						
						if i < math.ceil(infad/max_frame) then
							alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H96&")
							u_in = u_in + 1
						elseif i > (n-math.ceil(outfad/max_frame)) then
							alpha = utils.interpolate(u_out/outmax, "&H96&", "&HFF&")
							u_out = u_out + 1
						else
							alpha="&H00&"
						end
						
						local sc = 125 + 25*math.cos(math.rad(utils.interpolate(1/(200/j), 0, 360)))
						
						local x, y = utils.interpolate(step, xo-50, xo+line.width), yo - 50
						
						l.text = string.format("{\\p1\\an5\\blur1.2\\bord0.1\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&HFFFFFF&\\3c&HE2B761&\\pos(%.3f,%.3f)}m 0 0 l 1 0 1 1 0 1"
						,sc,sc,alpha,x,y)
						
						io.write_line(l)
					end
				end
			end
			
			if char.text~="" and char.i == 1 then
				--cfx fragarach bezier 2
				maxj = 200
				for j = 1, maxj, 1 do
					
					local max_frame = 23.976
					local u_in, u_out = 0, 0
					local a = 0
					
					for s, e, i, n in utils.frames(line.start_time-250, line.end_time+250, max_frame) do
						
						l.layer = 8
						
						l.start_time = s
						l.end_time = e
						
						local step = i / n
						
						local bx1, by1 = utils.interpolate(step, char.left + 10, char.left + 25), utils.interpolate(step, char.middle - 10, char.middle + 5)
						local bx2, by2 = utils.interpolate(step, char.left - 40, char.left - 30), utils.interpolate(step, char.top - 30, char.top + 10)
						local bx3, by3 = utils.interpolate(step, char.left - 25, char.left - 10), utils.interpolate(step, char.middle-10, char.middle + 10)
						local bx4, by4 = utils.interpolate(step, char.left - 30, char.left - 10), utils.interpolate(step, char.bottom + 5, char.bottom + 25)
						local bx5, by5 = utils.interpolate(step, char.left + 5, char.right - 5), utils.interpolate(step, char.middle - 5, char.middle + 10)
						
						local bpoint = math.bezier(1/(200/j),
						{
						{bx1, by1},
						{bx2, by2},
						{bx3, by3},
						{bx4, by4},
						{bx5, by5}
						}
						)
						
						local xo, yo = bpoint[1], bpoint[2]
						
						local infad, outfad = 300, 300
						local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
						
						if i < math.ceil(infad/max_frame) then
							alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H96&")
							u_in = u_in + 1
						elseif i > (n-math.ceil(outfad/max_frame)) then
							alpha = utils.interpolate(u_out/outmax, "&H96&", "&HFF&")
							u_out = u_out + 1
						else
							alpha="&H00&"
						end
						
						local x, y = utils.interpolate(step, xo-50, xo+line.width), yo - 40
						
						l.text = string.format("{\\p1\\an5\\blur1.2\\bord0.1\\shad0\\fscx100\\fscy100\\alpha%s\\1c&HFFFFFF&\\3c&HE2B761&\\pos(%.3f,%.3f)}m 0 0 l 1 0 1 1 0 1"
						,alpha,x,y)
						
						io.write_line(l)
					end
				end
			end
			
			if char.text~="" and char.i == 1 then
				--cfx fragarach bezier 3
				maxj = 200
				for j = 1, maxj, 1 do
					
					local max_frame = 23.976
					local u_in, u_out = 0, 0
					local a = 0
					
					for s, e, i, n in utils.frames(line.start_time-250, line.end_time+250, max_frame) do
						
						l.layer = 8
						
						l.start_time = s
						l.end_time = e
						
						local step = i / n
						
						local bx1, by1 = utils.interpolate(step, char.left + 10, char.left + 25), utils.interpolate(step, char.middle - 10, char.middle + 5)
						local bx2, by2 = utils.interpolate(step, char.left - 40, char.left - 30), utils.interpolate(step, char.top - 30, char.top + 10)
						local bx3, by3 = utils.interpolate(step, char.right + 35, char.right + 60), utils.interpolate(step, char.middle - 10, char.middle + 10)
						local bx4, by4 = utils.interpolate(step, char.right + 40, char.right + 75), utils.interpolate(step, char.bottom + 5, char.bottom + 35)
						local bx5, by5 = utils.interpolate(step, char.left - 20, char.left - 5), utils.interpolate(step, char.top - 20, char.bottom + 10)
						local bx6, by6 = utils.interpolate(step, char.center - 5, char.center + 5), utils.interpolate(step, char.middle - 5, char.middle + 10)
						
						local bpoint = math.bezier(1/(200/j),
						{
						{bx1, by1},
						{bx2, by2},
						{bx3, by3},
						{bx4, by4},
						{bx5, by5},
						{bx6, by6}
						}
						)
						
						local xo, yo = bpoint[1], bpoint[2]
						
						local infad, outfad = 300, 300
						local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
						
						if i < math.ceil(infad/max_frame) then
							alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H96&")
							u_in = u_in + 1
						elseif i > (n-math.ceil(outfad/max_frame)) then
							alpha = utils.interpolate(u_out/outmax, "&H96&", "&HFF&")
							u_out = u_out + 1
						else
							alpha="&H00&"
						end
						
						local x, y = utils.interpolate(step, xo-50, xo+line.width), yo - 40
						
						l.text = string.format("{\\p1\\an5\\blur1.2\\bord0.1\\shad0\\fscx100\\fscy100\\alpha%s\\1c&HFFFFFF&\\3c&HE2B761&\\pos(%.3f,%.3f)}m 0 0 l 1 0 1 1 0 1"
						,alpha,x,y)
						
						io.write_line(l)
					end
				end
			end
			if char.text~="" and char.i == 1 then
				--cfx fragarach bezier 4
				maxj = 100
				for j = 1, maxj, 1 do
					
					local max_frame = 23.976
					local u_in, u_out = 0, 0
					local a = 0
					
					for s, e, i, n in utils.frames(line.start_time-250, line.end_time+250, max_frame) do
						
						l.layer = 8
						
						l.start_time = s
						l.end_time = e
						
						local step = i / n
						
						local bx1, by1 = utils.interpolate(step, char.center - 10, char.center + 10), char.top
						local bx2, by2 = utils.interpolate(step, char.left - 10, char.right + 10), utils.interpolate(step, char.top + 5, char.top + 10)
						local bx3, by3 = utils.interpolate(step, char.right + 10, char.left - 5), utils.interpolate(step, char.top + 10, char.top + 15)
						local bx4, by4 = utils.interpolate(step, char.left - 10, char.right + 15), utils.interpolate(step, char.top + 15, char.top + 25)
						local bx5, by5 = utils.interpolate(step, char.left - 10, char.right + 10), utils.interpolate(step, char.top + 25, char.top + 40)
						local bx6, by6 = utils.interpolate(step, char.center - 5, char.center + 5), char.top + 60
						
						local bpoint = math.bezier(1/(100/j),
						{
						{bx1, by1},
						{bx2, by2},
						{bx3, by3},
						{bx4, by4},
						{bx5, by5},
						{bx6, by6}
						}
						)
						
						local xo, yo = bpoint[1], bpoint[2]
						
						local infad, outfad = 300, 300
						local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
						
						if i < math.ceil(infad/max_frame) then
							alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H96&")
							u_in = u_in + 1
						elseif i > (n-math.ceil(outfad/max_frame)) then
							alpha = utils.interpolate(u_out/outmax, "&H96&", "&HFF&")
							u_out = u_out + 1
						else
							alpha="&H00&"
						end
						
						local x, y = utils.interpolate(step, xo-40, xo+line.width), yo + 10
						
						l.text = string.format("{\\p1\\an5\\blur1.2\\bord0.1\\shad0\\fscx100\\fscy100\\alpha%s\\1c&HFFFFFF&\\3c&HE2B761&\\pos(%.3f,%.3f)}m 0 0 l 1 0 1 1 0 1"
						,alpha,x,y)
						
						io.write_line(l)
					end
				end
			end
			
			if char.text~="" and char.i == 1 then
				--cfx fragarach bezier 5
				maxj = 100
				for j = 1, maxj, 1 do
					
					local max_frame = 23.976
					local u_in, u_out = 0, 0
					local a = 0
					
					for s, e, i, n in utils.frames(line.start_time-250, line.end_time+250, max_frame) do
						
						l.layer = 8
						
						l.start_time = s
						l.end_time = e
						
						local step = i / n
						
						local bx1, by1 = utils.interpolate(step, char.center - 5, char.center + 10), char.top
						local bx2, by2 = utils.interpolate(step, char.left - 15, char.right + 20), utils.interpolate(step, char.top + 5, char.top + 10)
						local bx3, by3 = utils.interpolate(step, char.left - 25, char.left + 25), utils.interpolate(step, char.top + 10, char.top + 15)
						local bx4, by4 = utils.interpolate(step, char.left - 15, char.right + 25), utils.interpolate(step, char.top + 15, char.top + 25)
						local bx5, by5 = utils.interpolate(step, char.left - 5, char.right + 15), utils.interpolate(step, char.top + 25, char.top + 40)
						local bx6, by6 = utils.interpolate(step, char.center - 15, char.center + 25), char.top + 50
						
						local bpoint = math.bezier(1/(100/j),
						{
						{bx1, by1},
						{bx2, by2},
						{bx3, by3},
						{bx4, by4},
						{bx5, by5},
						{bx6, by6}
						}
						)
						
						local xo, yo = bpoint[1], bpoint[2]
						
						local infad, outfad = 300, 300
						local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
						
						if i < math.ceil(infad/max_frame) then
							alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H96&")
							u_in = u_in + 1
						elseif i > (n-math.ceil(outfad/max_frame)) then
							alpha = utils.interpolate(u_out/outmax, "&H96&", "&HFF&")
							u_out = u_out + 1
						else
							alpha="&H00&"
						end
						
						local x, y = utils.interpolate(step, xo-50, xo+line.width), yo + 10
						
						l.text = string.format("{\\p1\\an5\\blur1.2\\bord0.1\\shad0\\fscx100\\fscy100\\alpha%s\\1c&HFFFFFF&\\3c&HE2B761&\\pos(%.3f,%.3f)}m 0 0 l 1 0 1 1 0 1"
						,alpha,x,y)
						
						io.write_line(l)
					end
				end
			end
			
			if char.text~="" and char.i == 1 then
				--cfx fragarach bezier 6
				maxj = 100
				for j = 1, maxj, 1 do
					
					local max_frame = 23.976
					local u_in, u_out = 0, 0
					local a = 0
					
					for s, e, i, n in utils.frames(line.start_time-250, line.end_time+250, max_frame) do
						
						l.layer = 8
						
						l.start_time = s
						l.end_time = e
						
						local step = i / n
						
						local bx1, by1 = utils.interpolate(step, char.center - 15, char.center + 10), char.top
						local bx2, by2 = utils.interpolate(step, char.left - 25, char.right + 20), utils.interpolate(step, char.top + 5, char.top + 10)
						local bx3, by3 = utils.interpolate(step, char.left - 5, char.left + 5), utils.interpolate(step, char.top + 10, char.top + 15)
						local bx4, by4 = utils.interpolate(step, char.left - 25, char.right + 15), utils.interpolate(step, char.top + 15, char.top + 25)
						local bx5, by5 = utils.interpolate(step, char.left - 15, char.right + 10), utils.interpolate(step, char.top + 25, char.top + 40)
						local bx6, by6 = utils.interpolate(step, char.center - 10, char.center + 5), char.top + 55
						
						local bpoint = math.bezier(1/(100/j),
						{
						{bx1, by1},
						{bx2, by2},
						{bx3, by3},
						{bx4, by4},
						{bx5, by5},
						{bx6, by6}
						}
						)
						
						local xo, yo = bpoint[1], bpoint[2]
						
						local infad, outfad = 300, 300
						local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
						
						if i < math.ceil(infad/max_frame) then
							alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H96&")
							u_in = u_in + 1
						elseif i > (n-math.ceil(outfad/max_frame)) then
							alpha = utils.interpolate(u_out/outmax, "&H96&", "&HFF&")
							u_out = u_out + 1
						else
							alpha="&H00&"
						end
						
						local x, y = utils.interpolate(step, xo-60, xo+line.width), yo + 10
						
						l.text = string.format("{\\p1\\an5\\blur1.2\\bord0.1\\shad0\\fscx100\\fscy100\\alpha%s\\1c&HFFFFFF&\\3c&HE2B761&\\pos(%.3f,%.3f)}m 0 0 l 1 0 1 1 0 1"
						,alpha,x,y)
						
						io.write_line(l)
					end
				end
			end
		end
	end
	
	if line.style == "CFX_Bellerophon" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--cfx bellerophon text
				
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time+50*char.i-250, line.end_time-25*char.i, max_frame) do
					
					l.start_time = s
					
					local infad, outfad = 250, 300
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fxmax = math.ceil((char.end_time-char.start_time)/max_frame)
					
					if s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
						l.layer = 6
						l.end_time = e
						fad = 0
						alpha="&H00&"
						sc = 120 + 10*math.sin(math.rad(45*char.i+a))
						x, y = char.center, char.middle
						u_fx = u_fx + 1
					elseif i < math.ceil(infad/max_frame) then
						l.layer = 5
						l.end_time = e + 250
						fad = 250
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						sc = utils.interpolate(u_in/inmax, 70, 100)
						x, y = utils.interpolate(u_in/inmax, char.left-25, char.center), char.middle
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						l.layer = 5
						l.end_time = e + 300
						fad = 300
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						sc = utils.interpolate(u_out/outmax, 100, 70)
						x, y = utils.interpolate(u_out/outmax, char.center, char.right+25), char.middle
						u_out = u_out + 1
					else
						l.layer = 5
						l.end_time = e
						fad = 0
						sc = 100
						x, y = char.center, char.middle
						alpha="&H00&"
					end
					
					a = a + 90
					
					l.text = string.format("{\\b1\\an5\\bord3\\blur3\\fscx%d\\fscy%d\\fad(0,%d)\\alpha%s\\1c&HFFFFFF&\\3c&HE2B761&\\pos(%.3f, %.3f)}%s"
					,sc,sc,fad,alpha,x,y,char.text)
					
					io.write_line(l)
				end
			end
		end
		for si, syl in ipairs(line.syls) do
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				
				local pegasus = "m 0 0 l -1 -2 l -2 -6 l -2 -8 l -2 -11 l -2 -14 l -4 -18 l -5 -21 l -6 -23 l -6 -27 l -8 -23 l -9 -23 l -7 -26 l -7 -29 l -7 -32 l -9 -33 l -10 -30 l -11 -30 l -12 -31 l -10 -35 l -10 -39 l -10 -43 l -8 -48 l -8 -51 l -12 -45 l -12 -40 l -12 -36 l -12 -34 l -13 -31 l -12 -29 l -12 -27 l -12 -25 l -12 -24 l -12 -23 l -12 -20 l -12 -19 l -12 -18 l -12 -18 l -13 -17 l -16 -17 l -17 -17 l -17 -16 l -18 -16 l -19 -16 l -22 -16 l -24 -17 l -24 -18 l -23 -20 l -23 -22 l -22 -24 l -21 -25 l -20 -26 l -20 -28 l -20 -30 l -20 -31 l -20 -33 l -19 -35 l -17 -37 l -17 -38 l -17 -40 l -16 -42 l -16 -43 l -17 -45 l -18 -46 l -18 -47 l -17 -48 l -16 -49 l -15 -50 l -16 -51 l -17 -55 l -19 -60 l -19 -62 l -20 -64 l -21 -68 l -21 -70 l -21 -72 l -20 -75 l -16 -80 l -16 -81 l -15 -84 l -17 -89 l -18 -90 l -18 -91 l -20 -91 l -21 -87 l -22 -84 l -24 -81 l -25 -80 l -26 -79 l -27 -78 l -28 -78 l -30 -77 l -32 -77 l -32 -77 l -34 -78 l -35 -80 l -38 -79 l -39 -78 l -42 -77 l -42 -78 l -45 -80 l -46 -80 l -48 -79 l -50 -79 l -52 -79 l -56 -79 l -57 -79 l -58 -79 l -58 -80 l -57 -82 l -59 -83 l -61 -81 l -62 -81 l -64 -81 l -66 -81 l -69 -82 l -70 -82 l -71 -83 l -70 -85 l -70 -86 l -72 -86 l -75 -86 l -80 -85 l -82 -87 l -84 -89 l -84 -90 l -89 -90 l -92 -91 l -95 -91 l -98 -93 l -99 -95 l -99 -95 l -98 -96 l -100 -97 l -101 -98 l -103 -98 l -105 -99 l -109 -101 l -111 -102 l -112 -103 l -114 -104 l -113 -105 l -112 -106 l -115 -108 l -119 -110 l -121 -111 l -123 -113 l -127 -115 l -129 -118 l -131 -120 l -130 -121 l -128 -122 l -130 -124 l -132 -125 l -134 -126 l -136 -127 l -138 -129 l -140 -131 l -142 -132 l -145 -134 l -146 -135 l -148 -137 l -149 -139 l -148 -141 l -148 -141 l -150 -144 l -152 -146 l -155 -149 l -157 -151 l -159 -154 l -161 -157 l -162 -160 l -163 -163 l -161 -163 l -161 -165 l -163 -167 l -165 -171 l -166 -175 l -167 -179 l -169 -183 l -169 -185 l -168 -186 l -165 -185 l -166 -187 l -167 -191 l -167 -192 l -169 -195 l -169 -197 l -169 -200 l -170 -203 l -170 -205 l -168 -204 l -167 -203 l -165 -202 l -166 -205 l -167 -208 l -169 -211 l -170 -215 l -171 -219 l -172 -222 l -173 -226 l -172 -228 l -172 -229 l -168 -226 l -166 -223 l -160 -216 l -155 -210 l -151 -207 l -150 -204 l -149 -205 l -145 -203 l -141 -199 l -134 -193 l -133 -194 l -116 -182 l -108 -177 l -101 -173 l -96 -169 l -90 -167 l -84 -165 l -81 -164 l -76 -160 l -68 -153 l -61 -148 l -56 -145 l -50 -141 l -46 -138 l -38 -134 l -33 -132 l -24 -128 l -22 -124 l -20 -119 l -20 -121 l -21 -125 l -22 -127 l -20 -132 l -19 -134 l -17 -136 l -16 -139 l -15 -142 l -13 -143 l -12 -144 l -10 -146 l -10 -148 l -10 -150 l -11 -153 l -11 -154 l -11 -155 l -10 -156 l -12 -158 l -12 -160 l -12 -162 l -12 -165 l -12 -166 l -11 -168 l -10 -169 l -10 -171 l -11 -174 l -13 -176 l -14 -177 l -14 -178 l -15 -179 l -16 -182 l -13 -182 l -12 -182 l -11 -184 l -10 -186 l -9 -186 l -9 -187 l -7 -190 l -6 -191 l -4 -194 l -2 -195 l -3 -198 l -2 -199 l 0 -201 l 2 -202 l 4 -202 l 5 -201 l 5 -200 l 5 -198 l 5 -196 l 6 -195 l 7 -192 l 8 -189 l 9 -188 l 9 -187 l 10 -184 l 9 -178 l 8 -176 l 7 -174 l 6 -172 l 7 -169 l 7 -168 l 8 -163 l 8 -161 l 8 -157 l 9 -152 l 9 -149 l 9 -146 l 9 -144 l 10 -140 l 11 -138 l 12 -137 l 13 -137 l 15 -137 l 17 -140 l 18 -142 l 17 -144 l 19 -146 l 20 -148 l 22 -148 l 24 -149 l 24 -151 l 28 -153 l 29 -153 l 32 -152 l 33 -152 l 34 -150 l 34 -149 l 34 -147 l 34 -144 l 33 -141 l 33 -140 l 31 -139 l 30 -139 l 28 -139 l 25 -139 l 24 -139 l 23 -134 l 23 -133 l 24 -131 l 25 -128 l 28 -130 l 32 -132 l 36 -134 l 40 -136 l 45 -139 l 48 -141 l 52 -144 l 55 -146 l 58 -149 l 61 -151 l 64 -155 l 67 -157 l 70 -159 l 74 -161 l 78 -163 l 83 -167 l 88 -170 l 93 -174 l 97 -177 l 100 -180 l 105 -183 l 109 -187 l 111 -189 l 112 -189 l 114 -190 l 119 -193 l 121 -196 l 124 -198 l 126 -200 l 127 -201 l 128 -200 l 132 -203 l 137 -207 l 140 -210 l 143 -213 l 146 -216 l 149 -219 l 151 -220 l 151 -218 l 151 -214 l 150 -210 l 149 -206 l 147 -201 l 146 -198 l 144 -196 l 141 -191 l 145 -195 l 148 -197 l 150 -199 l 150 -196 l 148 -192 l 147 -189 l 147 -186 l 144 -183 l 140 -178 l 146 -183 l 147 -182 l 145 -178 l 143 -172 l 141 -169 l 139 -166 l 141 -167 l 142 -165 l 141 -163 l 136 -153 l 134 -150 l 130 -146 l 127 -143 l 131 -145 l 130 -143 l 127 -138 l 120 -130 l 116 -127 l 113 -124 l 111 -122 l 114 -122 l 115 -122 l 109 -116 l 106 -112 l 102 -109 l 100 -108 l 104 -108 l 102 -104 l 97 -102 l 92 -98 l 89 -96 l 91 -95 l 85 -92 l 82 -92 l 77 -90 l 72 -89 l 74 -88 l 72 -88 l 68 -87 l 65 -87 l 64 -86 l 64 -85 l 64 -84 l 61 -84 l 57 -84 l 54 -83 l 51 -83 l 49 -84 l 50 -83 l 47 -82 l 44 -82 l 42 -82 l 41 -83 l 39 -84 l 39 -83 l 36 -81 l 34 -81 l 32 -82 l 31 -82 l 30 -82 l 28 -83 l 27 -81 l 26 -81 l 23 -82 l 20 -84 l 19 -84 l 17 -85 l 15 -87 l 15 -85 l 15 -82 l 16 -81 l 16 -77 l 17 -76 l 17 -73 l 18 -72 l 17 -70 l 18 -67 l 18 -63 l 17 -59 l 16 -57 l 15 -54 l 15 -52 l 15 -51 l 15 -50 l 15 -48 l 16 -46 l 17 -45 l 17 -42 l 17 -41 l 17 -37 l 17 -33 l 17 -29 l 17 -27 l 18 -25 l 19 -24 l 20 -21 l 19 -20 l 18 -18 l 19 -16 l 20 -14 l 20 -12 l 20 -11 l 21 -10 l 21 -8 l 21 -7 l 19 -6 l 16 -5 l 13 -5 l 12 -6 l 10 -6 l 9 -7 l 9 -9 l 10 -10 l 11 -12 l 11 -14 l 11 -15 l 10 -18 l 10 -19 l 10 -21 l 11 -23 l 11 -24 l 11 -27 l 11 -29 l 11 -32 l 11 -34 l 10 -36 l 9 -37 l 9 -39 l 9 -43 l 9 -44 l 9 -46 l 8 -49 l 8 -51 l 6 -54 l 6 -51 l 6 -50 l 4 -47 l 4 -45 l 5 -44 l 5 -43 l 6 -42 l 7 -42 l 6 -40 l 5 -39 l 3 -38 l 4 -37 l 5 -36 l 5 -34 l 5 -32 l 5 -31 l 5 -30 l 6 -28 l 6 -25 l 5 -25 l 7 -22 l 7 -21 l 6 -19 l 3 -21 l 1 -23 l -1 -25 l 1 -19 l 1 -16 l 3 -13 l 3 -10 l 4 -8 l 6 -7 l 6 -6 l 4 -6 l 2 -8 l 1 -8 l 0 -6 l 1 -4 "
				
				local u_in, u_out= 0, 0
				
				local max_frame = 20
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					l.layer = 3
					
					l.start_time=s
					l.end_time=e+150
					
					local step = i / n
					
					local infad, outfad = 100, 150
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						u_in = u_in + 1
						
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						u_out = u_out + 1
					else
						alpha="&H00&"
					end
					
					local x, y = utils.interpolate(step, syl.left, syl.right), syl.top
					
					l.text=string.format("{\\an7\\bord2\\blur10\\p3\\alpha%s\\1c&HFFFFFF\\3c&HE2B761&\\fad(0,150)\\fscx80\\fscy80\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,pegasus)
					
					io.write_line(l)
				end
				
			end
		end
	end
	
	if line.style == "CFX_Schneider" then
		
		line.infade = 250
		line.outfade = 250
		
		for ci,char in ipairs(line.chars) do
			for ci,char in ipairs(line.chars) do
				
				if char.text~=" " and char.text~="" then
					
					--infade
					
					l.layer = 5
					
					l.start_time = line.start_time-line.infade+10*char.i-10
					l.end_time = line.start_time+char.start_time
					
					local x, y2 = char.center - char.width/2, char.middle - char.height/2
					
					local orgx, orgy = char.center, char.middle
					
					if char.i%2==1 then
						y1 = char.middle - char.height/2 - 25
						frx = 90
					else
						y1 = char.middle - char.height/2 + 25
						frx = -90
					end
					
					
					l.text=string.format("{\\an7\\blur0.6\\bord1.5\\shad0\\frx%d\\t(0,200,\\frx0)\\fscx100\\fscy100\\1c&HF5A0F5&\\3c&H000000&\\move(%.3f, %.3f, %.3f, %.3f, 0, 200)\\org(%.3f,%.3f)}%s"
					,frx,x,y1,x,y2,orgx,orgy,char.text)
					
					io.write_line(l)
				end
				
				if char.text~=" " and char.i == 1 then
					--cut fx
					
					max_frame = 2 
					
					for s, e, i, n in utils.frames(line.start_time, line.start_time + 25*#line.chars, max_frame) do
						
						local if_shape = "m 0 0 b -3 -1 -4 -2 -6 -2 b -8 -3 -10 -1 -21 -1 b -30 -1 -55 -1 -90 0 b -50 0 -36 1 -21 1 b -10 1 -8 3 -6 2 b -4 2 -3 1 0 0 "
						l.layer = 6
						
						l.start_time = s
						l.end_time = e + 500
						
						local step = i / n
						
						local x1, x2, y = line.left, line.left+line.width+50, line.middle+7
						local x = utils.interpolate(step, x1, x2)
						
						l.text=string.format("{\\p1\\an7\\blur1.5\\bord0\\shad0\\fscx30\\fscy30\\1c&HED89F5&\\alpha&H96&\\t(\\fscx0\\fscy0\\1c&HFFFFFF&)\\fad(0,500)\\pos(%.3f, %.3f)}%s"
						,x,y,if_shape)
						
						io.write_line(l)
					end
				end
				
				if char.text~=" " and char.text~="" then
					
					--fx top
					
					local text_shape = convert.text_to_shape(char.text, line.styleref)
					local line_shape = convert.text_to_shape(line.text, line.styleref)
					local tlx, tly, brx, bry = shape.bounding(line_shape)
					local split_shape = shape.split(text_shape, 1)
					
					l.layer = 5
					
					l.start_time = line.start_time+char.start_time
					l.end_time = line.end_time+line.outfade+25*char.i-25
					
					local x1, y1, x2, y2 = char.center - char.width/2, char.middle - char.height/2, char.center - char.width/2, char.middle - char.height/2 - 15
					
					local deform = shape.filter(split_shape,
					function(x,y)
						
						local x = x + 0
						
						if y < (tly+bry)/2 + 50 then
							y = y + 0
						else
							y = (tly+bry)/2 + 50
						end
						
						return x, y
					end)
					
					l.text=string.format("{\\p4\\an7\\blur0.6\\bord1.5\\shad0\\fscx100\\fscy100\\1c&HF5A0F5&\\3c&H000000&\\fad(0,250)\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,x1,y1,x2,y2,deform)
					
					io.write_line(l)
				end
				
				if char.text~=" " and char.text~="" then
					--fx bot
					
					local text_shape = convert.text_to_shape(char.text, line.styleref)
					local line_shape = convert.text_to_shape(line.text, line.styleref)
					local tlx, tly, brx, bry = shape.bounding(line_shape)
					local split_shape = shape.split(text_shape, 1)
					
					l.layer = 5
					
					l.start_time = line.start_time+char.start_time
					l.end_time = line.end_time+line.outfade+25*char.i-25
					
					local x1, y1, x2, y2 = char.center - char.width/2, char.middle - char.height/2, char.center - char.width/2, char.middle - char.height/2 + 15
					
					local deform = shape.filter(split_shape,
					function(x,y)
						
						local x = x + 0
						
						if y > (tly+bry)/2 + 50 then
							y = y + 0
						else
							y = (tly+bry)/2 + 50
						end
						
						return x, y
					end)
					
					l.text=string.format("{\\p4\\an7\\blur0.6\\bord1.5\\shad0\\fscx100\\fscy100\\1c&HF5A0F5&\\3c&H000000&\\fad(0,250)\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,x1,y1,x2,y2,deform)
					
					io.write_line(l)
				end
			end
		end
	end
	
	if line.style == "CFX_Gandr" then
		
		line.infade = 0
		line.outfade = 0
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" and syl.text~=" " then
				--black
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local tlx, tly, brx, bry = shape.bounding(text_shape)
				
				local max_frame = 50
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-550, line.end_time+550, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local infad, outfad = 250, 500
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					local xc, yc = (tlx+brx)/2, (tly+bry)/2
					
					local a = 0
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2 + utils.interpolate(u_in/inmax, math.random(-5, 5), 0)
						deform = shape.filter(text_shape,
						function(x,y)
							local rd1, rd2 = math.random(-10,10), math.randomsteps(-10,10,2)
							local vx, vy = x + xc, y + yc
							local xdef, ydef = utils.interpolate(u_in/inmax, math.random(-40, 40), rd1), utils.interpolate(u_in/inmax, math.random(-40, 40), rd2)
							return x+xdef, y+ydef
						end)
						u_in = u_in + 1
					elseif s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
						alpha = "&H00&"
						sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2
						deform = shape.filter(text_shape,
						function(x,y)
							local rd1, rd2 = math.random(-10,10), math.randomsteps(-10,10,2)
							local vx, vy = x - xc, y - yc
							xdef = utils.interpolate((s - (line.start_time + syl.start_time))/syl.duration, 0.4*vx, rd1) + 10*math.sin(math.rad(a+10*x)) + math.randomsteps(-20, 20, 2.5)
							ydef = utils.interpolate((s - (line.start_time + syl.start_time))/syl.duration, 0.4*vy, rd2) + 10*math.sin(math.rad(a+10*y)) + math.randomsteps(-20, 20, 2.5)
							return x+xdef, y+ydef
						end)
						a = a + 15
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2
						deform = shape.filter(text_shape,
						function(x,y)
							local rd1, rd2 = math.random(-10,10), math.randomsteps(-10,10,2)
							local vx, vy = x - xc, y - yc
							local xdef, ydef = utils.interpolate(u_out/outmax, rd1, math.random(math.abs(vx), 2*math.abs(vx))), utils.interpolate(u_out/outmax, rd2, math.random(math.abs(vy), 2*math.abs(vy)))
							return x+xdef, y+ydef
						end)
						u_out = u_out + 1
					else
						sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2
						deform = shape.filter(text_shape,
						function(x,y)
							local rd1, rd2 = math.random(-10,10), math.randomsteps(-10,10,2)
							local xdef, ydef = rd1, rd2
							return x+xdef, y+ydef
						end)
						alpha="&H00&"
					end
					
					l.text = string.format("{\\p4\\an7\\blur3\\bord0.2\\shad0\\fscx100\\fscy100\\alpha%s\\1c&H000000&\\3c&H2812CC&\\pos(%.3f, %.3f)}%s"
					,alpha,sx,sy,deform)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" and syl.text~=" " then
				
				--red
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local text_outline = shape.tooutline(split_shape, 15)
				local tlx, tly, brx, bry = shape.bounding(text_shape)
				
				local max_frame = 50
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-550, line.end_time+550, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local infad, outfad = 250, 500
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					local xc, yc = (tlx+brx)/2, (tly+bry)/2
					
					local a = 0
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2 + utils.interpolate(u_in/inmax, math.random(-5, 5), 0)
						deform = shape.filter(text_outline,
						function(x,y)
							local vx, vy = x + xc, y + yc
							local xdef = utils.interpolate(u_in/inmax, math.random(-40, 40), 0) + math.randomsteps(-20, 20, 2.5)
							local ydef = utils.interpolate(u_in/inmax, math.random(-40, 40), 0) + math.randomsteps(-20, 20, 2.5)
							return x+xdef, y+ydef
						end)
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2
						deform = shape.filter(text_outline,
						function(x,y)
							local vx, vy = x - xc, y - yc
							local xdef = utils.interpolate(u_out/outmax, 0, math.random(math.abs(vx), 2*math.abs(vx))) + math.randomsteps(-20, 20, 2.5)
							local ydef = utils.interpolate(u_out/outmax, 0, math.random(math.abs(vy), 2*math.abs(vy))) + math.randomsteps(-20, 20, 2.5)
							return x+xdef, y+ydef
						end)
						u_out = u_out + 1
					else
						alpha = "&H00&"
						sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2
						deform = shape.filter(text_outline,
						function(x,y)
							local vx, vy = x - xc, y - yc
							xdef = 20*math.sin(math.rad(a+10*x)) + math.randomsteps(-20, 20, 2.5)
							ydef = 20*math.sin(math.rad(a+10*y)) + math.randomsteps(-20, 20, 2.5)
							return x+xdef, y+ydef
						end)
						a = a + 15
					end
					
					l.text = string.format("{\\p4\\an7\\blur1.2\\bord0\\shad0\\fscx100\\fscy100\\alpha%s\\1c&H2812CC&\\pos(%.3f, %.3f)}%s"
					,alpha,sx,sy,deform)
					
					io.write_line(l)
				end
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	cfx( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end