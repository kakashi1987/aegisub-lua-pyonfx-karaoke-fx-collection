--Fate/kaleid liner PRISMA ILLYA Zwei! ED
--Karaoke by Amberdrake
--VSFilterMOD

function romanji(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	if line.outfade < 50*#line.syls then
		of_fix = 50*#line.syls
	else
		of_fix = 0
	end
	
	if line.style == "OP_romanji" or line.style == "OP_romanji_L" or line.style == "OP_romanji_R" or line.style == "OP_kanji" or line.style == "OP_kanji_L" or line.style == "OP_kanji_R" then
		
		for si,syl in ipairs(line.syls) do
			
			local fx_x, fx_y = syl.center + math.randomsteps(-1,1,0.2), syl.middle + math.randomsteps(-1,1,0.1)
			
			if syl.text~="" then
				--infade particles
				
				local particle = shape.ellipse(5,5)
				
				maxj = 50
				for j = 1, maxj, 1 do
					
					max_frame = 100
					u_in = 0
					
					local xs, ys = math.random(syl.left+2, syl.right-2), math.random(syl.top+8, syl.bottom)
					
					for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time-line.infade+50*syl.i+50, max_frame) do
						l.layer = 2
						
						l.start_time = s
						l.end_time = e
						
						local color_array = {"&HFDBBE3&" , "&HF0BD91&" , "&HFCFFCC&" , "&HF0BD91&" , "&HFFE0A6&"}
						local random_color = color_array[math.random(1,table.getn(color_array))]
						
						local fad = 150
						max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
							u_in=u_in+1
						else
							alpha="&H00&"
						end
						
						local x,y = xs + math.randomsteps(-2,2,0.5), ys + math.randomsteps(-2,2,0.5)
						
						l.text = string.format("{\\p1\\an5\\blur2\\bord0\\shad0\\fscx100\\fscy100\\1c%s\\alpha%s\\pos(%.3f, %.3f)}%s"
						,random_color,alpha,x,y,particle)
						
						io.write_line(l)
					end
				end
			end
			
			if syl.text~="" then
				--infade
				l.layer = 8
				
				l.start_time = line.start_time-line.infade+50*syl.i-50
				l.end_time = line.start_time+syl.start_time
				
				if syl.i%2 == 1 then
					color = "(&HFF9CFF&, &HFFFFFF&, &HFFFFFF&, &HFF9CFF&)"
				else
					color = "(&HFFFFFF&, &HFFFFFF&, &HFF9CFF&, &HFF9CFF&)"
				end
				
				l.text = string.format("{\\an5\\blur3\\bord0\\shad0\\fscx100\\fscy250\\1vc(&HFFFFFF&,&HFFFFFF&,&HFFFFFF&,&HFFFFFF&)\\t(0,100,\\blur0.6\\fscy100\\1vc%s)\\pos(%.3f, %.3f)}%s"
				,color,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade outline 1
				l.layer = 6
				
				l.start_time = line.start_time-line.infade+50*syl.i-50
				l.end_time = line.start_time+syl.start_time
				
				l.text = string.format("{\\an5\\blur3\\bord2.5\\shad0\\fscx100\\fscy250\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(0,100,\\blur1\\fscy100\\1c&H9F0A83&\\3c&H9F0A83&)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade outline 1
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+50*syl.i-50
				l.end_time = line.start_time+syl.start_time
				
				l.text = string.format("{\\an5\\blur4\\bord3\\shad0\\fscx100\\fscy250\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(0,100,\\blur1.5\\fscy100\\1c&HFF9CFF&\\3c&HFF9CFF&)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx
				
				local max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 8
					
					l.start_time = s
					l.end_time = e
					
					step = i / n
					
					if syl.i%2 == 1 then
						color = "(&HFF9CFF&, &HFFFFFF&, &HFFFFFF&, &HFF9CFF&)"
					else
						color = "(&HFFFFFF&, &HFFFFFF&, &HFF9CFF&, &HFF9CFF&)"
					end
					
					local sc = 110 + 10*math.sin(math.rad(utils.interpolate(step, 0, 720)))
					
					l.text = string.format("{\\an5\\blur0.6\\bord0\\shad0\\fscx%d\\fscy%d\\1vc%s\\jitter(2,2,2,2)\\pos(%.3f, %.3f)}%s"
					,sc,sc,color,fx_x,fx_y,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--syl fx outline 1
				
				local max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 6
					
					l.start_time = s
					l.end_time = e
					
					step = i / n
					
					if syl.i%2 == 1 then
						color = "(&HFF9CFF&, &HFFFFFF&, &HFFFFFF&, &HFF9CFF&)"
					else
						color = "(&HFFFFFF&, &HFFFFFF&, &HFF9CFF&, &HFF9CFF&)"
					end
					
					local sc = 110 + 10*math.sin(math.rad(utils.interpolate(step, 0, 720)))
					
					l.text = string.format("{\\an5\\blur1\\bord2.5\\shad0\\fscx%d\\fscy%d\\1c&H9F0A83&\\3c&H9F0A83&\\jitter(2,2,2,2)\\pos(%.3f, %.3f)}%s"
					,sc,sc,fx_x,fx_y,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--syl fx outline 1
				
				local max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					step = i / n
					
					if syl.i%2 == 1 then
						color = "(&HFF9CFF&, &HFFFFFF&, &HFFFFFF&, &HFF9CFF&)"
					else
						color = "(&HFFFFFF&, &HFFFFFF&, &HFF9CFF&, &HFF9CFF&)"
					end
					
					local sc = 110 + 10*math.sin(math.rad(utils.interpolate(step, 0, 720)))
					
					l.text = string.format("{\\an5\\blur4\\bord3\\shad0\\fscx%d\\fscy%d\\1c&HFF9CFF&\\3c&HFF9CFF&\\jitter(2,2,2,2)\\pos(%.3f, %.3f)}%s"
					,sc,sc,fx_x,fx_y,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--outfade
				l.layer = 8
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+50*syl.i-250-of_fix
				
				if syl.i%2 == 1 then
					color = "(&HFF9CFF&, &HFFFFFF&, &HFFFFFF&, &HFF9CFF&)"
				else
					color = "(&HFFFFFF&, &HFFFFFF&, &HFF9CFF&, &HFF9CFF&)"
				end
				
				l.text = string.format("{\\an5\\blur0.6\\bord0\\shad0\\fscx100\\fscy100\\1vc%s\\fad(0,50)\\pos(%.3f, %.3f)}%s"
				,color,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade outline 1
				l.layer = 6
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+50*syl.i-250-of_fix
				
				l.text = string.format("{\\an5\\blur1\\bord2.5\\shad0\\fscx100\\fscy100\\1c&H9F0A83&\\3c&H9F0A83&\\fad(0,50)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade outline 1
				l.layer = 5
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+50*syl.i-250-of_fix
				
				l.text = string.format("{\\an5\\blur1.5\\bord3\\shad0\\fscx100\\fscy100\\1c&HFF9CFF&\\3c&HFF9CFF&\\fad(0,50)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do
					--outfade feathers
					
					local feather = "m 0 0 b -18 0 -37 -2 -53 8 l -44 1 l -55 3 b -54 -7 -47 -11 -40 -20 b -53 -12 -60 -9 -63 7 b -67 2 -67 -8 -68 -15 b -71 -12 -71 0 -72 7 b -73 2 -74 -6 -74 -13 b -75 -6 -75 2 -74 7 b -74 10 -79 11 -81 12 b -107 9 -187 79 -172 111 b -171 114 -168 113 -163 108 b -143 80 -124 59 -91 45 b -81 38 -74 30 -70 25 b -69 25 -67 24 -66 24 b -67 27 -67 31 -66 34 b -63 37 -61 39 -62 34 b -63 30 -63 27 -62 23 b -58 29 -52 31 -47 35 b -50 31 -56 27 -57 22 b -52 27 -45 31 -38 33 b -43 29 -50 25 -54 19 b -47 21 -41 21 -33 20 b -40 19 -48 18 -52 15 b -44 11 -28 3 0 0 "
					l.layer = 10
					
					l.start_time = line.end_time+line.outfade+50*syl.i-300-of_fix
					l.end_time = line.end_time+line.outfade+50*syl.i-of_fix
					
					local alpha_array = {"&HFF&" , "&HFF&" , "&HFF&" , "&H00&" }
					local random_alpha=alpha_array[math.random(1,table.getn(alpha_array))]
					
					local px, py = syl.left + pixel.x, syl.top + pixel.y
					local xrot1, yrot1 = math.randomsteps(-360,-90, 15), math.randomsteps(-360,-90, 15)
					local xrot2, yrot2 = math.randomsteps(90, 360, 15), math.randomsteps(90, 360, 15)
					local msx, msy = px + math.randomsteps(-15, 15, 3), py + math.randomsteps(-15, 15, 3)
					local randomfad = math.randomsteps(50,100,25)
					
					l.text = string.format("{\\p5\\an7\\blur0.2\\bord0\\shad0\\fscx60\\fscy100\\1c&HFFFFFF&\\alpha%s\\frx%d\\fry%d\\t(\\frx%.3f\\fry%.3f\\fscx150\\fscy150)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
					,random_alpha,xrot1,yrot1,xrot2,yrot2,randomfad,px,py,msx,msy,feather)
					
					io.write_line(l)
					
				end
			end
		end
	end
	
	if line.style == "OP_TL" then
		for si,syl in ipairs(line.syls) do
			
			local fx_x, fx_y = syl.center + math.randomsteps(-1,1,0.2), syl.middle + math.randomsteps(-1,1,0.1)
			
			if syl.text~="" then
				--infade particles
				
				local particle = shape.ellipse(5,5)
				
				maxj = 50
				for j = 1, maxj, 1 do
					
					max_frame = 100
					u_in = 0
					
					local xs, ys = math.random(syl.left+2, syl.right-2), math.random(syl.top+8, syl.bottom)
					
					for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time-line.infade+50*syl.i+50, max_frame) do
						l.layer = 2
						
						l.start_time = s
						l.end_time = e
						
						local color_array = {"&HFDBBE3&" , "&HF0BD91&" , "&HFCFFCC&" , "&HF0BD91&" , "&HFFE0A6&"}
						local random_color = color_array[math.random(1,table.getn(color_array))]
						
						local fad = 150
						max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
							u_in=u_in+1
						else
							alpha="&H00&"
						end
						
						local x,y = xs + math.randomsteps(-2,2,0.5), ys + math.randomsteps(-2,2,0.5)
						
						l.text = string.format("{\\p1\\an5\\blur2\\bord0\\shad0\\fscx100\\fscy100\\1c%s\\alpha%s\\pos(%.3f, %.3f)}%s"
						,random_color,alpha,x,y,particle)
						
						io.write_line(l)
					end
				end
			end
			
			if syl.text~="" then
				--infade
				l.layer = 8
				
				l.start_time = line.start_time-line.infade+50*syl.i-50
				l.end_time = line.start_time+syl.end_time
				
				if syl.i%2 == 1 then
					color = "(&HFF9CFF&, &HFFFFFF&, &HFFFFFF&, &HFF9CFF&)"
				else
					color = "(&HFFFFFF&, &HFFFFFF&, &HFF9CFF&, &HFF9CFF&)"
				end
				
				l.text = string.format("{\\an5\\blur3\\bord0\\shad0\\fscx100\\fscy250\\1vc(&HFFFFFF&,&HFFFFFF&,&HFFFFFF&,&HFFFFFF&)\\t(0,100,\\blur0.6\\fscy100\\1vc%s)\\pos(%.3f, %.3f)}%s"
				,color,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade outline 1
				l.layer = 6
				
				l.start_time = line.start_time-line.infade+50*syl.i-50
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an5\\blur3\\bord2.5\\shad0\\fscx100\\fscy250\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(0,100,\\blur1\\fscy100\\1c&H9F0A83&\\3c&H9F0A83&)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade outline 1
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+50*syl.i-50
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an5\\blur4\\bord3\\shad0\\fscx100\\fscy250\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(0,100,\\blur1.5\\fscy100\\1c&HFF9CFF&\\3c&HFF9CFF&)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			
			if syl.text~="" then
				--outfade
				l.layer = 8
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+50*syl.i-250-of_fix
				
				if syl.i%2 == 1 then
					color = "(&HFF9CFF&, &HFFFFFF&, &HFFFFFF&, &HFF9CFF&)"
				else
					color = "(&HFFFFFF&, &HFFFFFF&, &HFF9CFF&, &HFF9CFF&)"
				end
				
				l.text = string.format("{\\an5\\blur0.6\\bord0\\shad0\\fscx100\\fscy100\\1vc%s\\fad(0,50)\\pos(%.3f, %.3f)}%s"
				,color,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade outline 1
				l.layer = 6
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+50*syl.i-250-of_fix
				
				l.text = string.format("{\\an5\\blur1\\bord2.5\\shad0\\fscx100\\fscy100\\1c&H9F0A83&\\3c&H9F0A83&\\fad(0,50)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade outline 1
				l.layer = 5
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+50*syl.i-250-of_fix
				
				l.text = string.format("{\\an5\\blur1.5\\bord3\\shad0\\fscx100\\fscy100\\1c&HFF9CFF&\\3c&HFF9CFF&\\fad(0,50)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do
					--outfade feathers
					
					local feather = "m 0 0 b -18 0 -37 -2 -53 8 l -44 1 l -55 3 b -54 -7 -47 -11 -40 -20 b -53 -12 -60 -9 -63 7 b -67 2 -67 -8 -68 -15 b -71 -12 -71 0 -72 7 b -73 2 -74 -6 -74 -13 b -75 -6 -75 2 -74 7 b -74 10 -79 11 -81 12 b -107 9 -187 79 -172 111 b -171 114 -168 113 -163 108 b -143 80 -124 59 -91 45 b -81 38 -74 30 -70 25 b -69 25 -67 24 -66 24 b -67 27 -67 31 -66 34 b -63 37 -61 39 -62 34 b -63 30 -63 27 -62 23 b -58 29 -52 31 -47 35 b -50 31 -56 27 -57 22 b -52 27 -45 31 -38 33 b -43 29 -50 25 -54 19 b -47 21 -41 21 -33 20 b -40 19 -48 18 -52 15 b -44 11 -28 3 0 0 "
					l.layer = 10
					
					l.start_time = line.end_time+line.outfade+50*syl.i-300-of_fix
					l.end_time = line.end_time+line.outfade+50*syl.i-of_fix
					
					local alpha_array = {"&HFF&" , "&HFF&" , "&HFF&" , "&H00&" }
					local random_alpha=alpha_array[math.random(1,table.getn(alpha_array))]
					
					local px, py = syl.left + pixel.x, syl.top + pixel.y
					local xrot1, yrot1 = math.randomsteps(-360,-90, 15), math.randomsteps(-360,-90, 15)
					local xrot2, yrot2 = math.randomsteps(90, 360, 15), math.randomsteps(90, 360, 15)
					local msx, msy = px + math.randomsteps(-15, 15, 3), py + math.randomsteps(-15, 15, 3)
					local randomfad = math.randomsteps(50,100,25)
					
					l.text = string.format("{\\p5\\an7\\blur0.2\\bord0\\shad0\\fscx60\\fscy100\\1c&HFFFFFF&\\alpha%s\\frx%d\\fry%d\\t(\\frx%.3f\\fry%.3f\\fscx150\\fscy150)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
					,random_alpha,xrot1,yrot1,xrot2,yrot2,randomfad,px,py,msx,msy,feather)
					
					io.write_line(l)
					
				end
			end
		end
	end
end

for li, line in ipairs(lines) do
	
	romanji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end