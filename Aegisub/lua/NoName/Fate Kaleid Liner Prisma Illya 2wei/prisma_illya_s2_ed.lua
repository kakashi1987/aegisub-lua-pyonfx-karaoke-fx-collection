--Fate/kaleid liner PRISMA ILLYA Zwei! ED
--Karaoke by Amberdrake
--VSFilter

function romanji(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 50 then
		line.outfade = 250
	end
	if line.outfade < 50*#line.syls then
		of_fix = 50*#line.syls
	else
		of_fix = 0
	end
	
	local star_color_dist = utils.distributor({"&HF7CD7F&", "&H2618E3&", "&H52FFAD&", "&H56FFF6&"})
	
	local star_color_dist2 = utils.distributor({"&HFBFFA8&", "&HBF5D2D&", "&HA40D5F&", "&HE9C2BE&", "&H764125&", "&H763052&"})
	local star_bord_color_dist2 = utils.distributor({"&HFEFFEC&", "&HF7AABF&", "&HE9C2BE&", "&HF5F4E6&", "&HB79E8E&", "&H9AC9D8&"})
	
	if line.style == "ED_TL" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--infade
				maxj = line.height
				for j = 1,maxj,1 do
					
					l.layer = 8
					
					l.start_time = line.start_time-line.infade-10*j+10+50*syl.i-50
					l.end_time = line.start_time+syl.end_time
					
					local clip_src = shape.rectangle(line.width,1)
					local clip = shape.move(clip_src,line.left,line.top+j)
					local color = utils.interpolate(j/maxj,"&HF2CBFF&","&HFFFFFF&")
					
					l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\fad(250,0)\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
					,color,clip,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
				
			end
			
			if syl.text~=" " and syl.text~="" then
				--infade outline
				
				l.layer = 7
				
				l.start_time = line.start_time-line.infade+40*syl.i-40
				l.end_time = line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur1\\bord1\\shad0\\fscx100\\fscy100\\1c&H715492&\\3c&H715492&\\fad(150,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~=" " and syl.text~="" then
				--infade outline 2
				
				l.layer = 6
				
				l.start_time = line.start_time-line.infade+40*syl.i-40
				l.end_time = line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur1\\bord2\\shad0\\fscx100\\fscy100\\1c&H503586&\\3c&H503586&\\fad(150,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~=" " and syl.text~="" then
				--infade outline 3
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+40*syl.i-40
				l.end_time = line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur4\\bord4\\shad0\\fscx100\\fscy100\\1c&HE0BFF5&\\3c&HE0BFF5&\\fad(150,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade
				maxj = line.height
				for j = 1,maxj,1 do
					
					l.layer = 8
					
					l.start_time = line.start_time+syl.end_time
					l.end_time = line.end_time+line.outfade+10*j-10+50*syl.i-50-of_fix
					
					local clip_src = shape.rectangle(line.width,1)
					local clip = shape.move(clip_src,line.left,line.top+j)
					
					local color = utils.interpolate(j/maxj,"&HF2CBFF&","&HFFFFFF&")
					
					local of_start = l.end_time-l.start_time-250
					local of_end = l.end_time-l.start_time
					
					l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\fad(0,250)\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
					,color,clip,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
				
			end
			
			if syl.text~=" " and syl.text~="" then
				--outfade outline
				
				l.layer = 7
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+40*syl.i-40-of_fix
				
				l.text=string.format("{\\an5\\blur1\\bord1\\shad0\\fscx100\\fscy100\\1c&H715492&\\3c&H715492&\\fad(0,150)\\pos(%.3f, %.3f))}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~=" " and syl.text~="" then
				--outfade outline 2
				
				l.layer = 6
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+40*syl.i-40-of_fix
				
				l.text=string.format("{\\an5\\blur1\\bord2\\shad0\\fscx100\\fscy100\\1c&H503586&\\3c&H503586&\\fad(0,150)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~=" " and syl.text~="" then
				--outfade outline 3
				
				l.layer = 5
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+40*syl.i-40-of_fix
				
				l.text=string.format("{\\an5\\blur4\\bord4\\shad0\\fscx100\\fscy100\\1c&HE0BFF5&\\3c&HE0BFF5&\\fad(0,150)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
		end
		
	else
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--infade
				maxj = line.height
				for j = 1,maxj,1 do
					
					l.layer = 8
					
					l.start_time = line.start_time-line.infade-10*j+10+50*syl.i-50
					l.end_time = line.start_time+syl.start_time
					
					local clip_src = shape.rectangle(line.width,1)
					local clip = shape.move(clip_src,line.left,line.top+j)
					local color = utils.interpolate(j/maxj,"&HF2CBFF&","&HFFFFFF&")
					
					l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\fad(250,0)\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
					,color,clip,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
				
			end
			
			if syl.text~=" " and syl.text~="" then
				--infade outline
				
				l.layer = 7
				
				l.start_time = line.start_time-line.infade+40*syl.i-40
				l.end_time = line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\blur1\\bord1\\shad0\\fscx100\\fscy100\\1c&H715492&\\3c&H715492&\\fad(150,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~=" " and syl.text~="" then
				--infade outline 2
				
				l.layer = 6
				
				l.start_time = line.start_time-line.infade+40*syl.i-40
				l.end_time = line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\blur1\\bord2\\shad0\\fscx100\\fscy100\\1c&H503586&\\3c&H503586&\\fad(150,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~=" " and syl.text~="" then
				--infade outline 3
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+40*syl.i-40
				l.end_time = line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\blur4\\bord4\\shad0\\fscx100\\fscy100\\1c&HE0BFF5&\\3c&HE0BFF5&\\fad(150,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~=" " and syl.text~="" then
				--infade stars fx
				if line.actor == "white" then
					star = "m 11 -11 l 11 -11 l 3 -25 l 17 -19 l 29 -29 l 24 -10 l 38 -14 l 25 -2 l 23 14 l 16 -1 l 0 1 "
				else
					star = "m 0 0 l 6 13 l 21 14 l 11 25 l 15 40 l 1 35 l -11 42 l -10 27 l -21 16 l -6 13 "
				end
				
				l.layer = 2
				
				l.start_time = line.start_time+50*syl.i-50-line.infade
				l.end_time = line.end_time-math.randomsteps(0,500,100)
				
				local sc = math.randomsteps(80,100,5)
				
				local rot_start = math.randomsteps(-90,90,15)
				local rot_end = rot_start + math.randomsteps(-360,360,90)
				
				if line.actor == "color" then
					star_color = star_color_dist:get()
					star_bord = "&HFFFFFF&"
				end
				if line.actor == "white" then
					star_color = "&HF8FDFF&"
					star_bord = "&HFAFDFF&"
				end
				if line.actor == "blue" then
					star_color = star_color_dist2:get()
					star_bord = star_bord_color_dist2:get()
				end
				
				local rf = math.randomsteps(100, 500, 100)
				
				local rsx, rsy = syl.center + math.random(-5,5), syl.middle + math.random(-5,5)
				
				if line.actor == "color" then
					rex, rey = rsx + math.randomsteps(10,50,10), rsy + math.randomsteps(-30,30,10)
				else
					rex, rey = rsx + math.randomsteps(-50,-10,10), rsy + math.randomsteps(-30,30,10)
				end
				
				l.text=string.format("{\\p1\\an5\\blur2\\bord1.2\\shad0\\fscx%d\\fscy%d\\frz%d\\t(\\frz%d)\\1c%s\\3c%s\\fad(100,%d)\\move(%.3f, %.3f, %.3f, %.3f)}%s"
				,sc,sc,rot_start,rot_end,star_color,star_bord,rf,rsx,rsy,rex,rey,star)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx
				
				max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					maxj = line.height
					for j = 1,maxj,1 do
						
						l.layer = 8
						
						l.start_time = s
						l.end_time = e
						
						local step = i / n
						
						local grow = math.sin(math.rad(utils.interpolate(step, 0, 180)))
						
						local sc = 100 - 5*grow
						
						local mov = 5*math.sin(math.rad(utils.interpolate(step, 90, 180)))
						
						local clip_src = shape.rectangle(line.width+50,1)
						local clip = shape.move(clip_src,line.left-25,line.top+j+mov)
						
						local color = utils.interpolate(j/maxj, "&HF2CBFF&", "&HFFFFFF&")
						
						l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy%d\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
						,sc,color,clip,syl.center,syl.middle+mov,syl.text)
						
						io.write_line(l)
					end
				end
				
			end
			
			if syl.text~=" " and syl.text~="" then
				--syl fx outline
				
				max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 7
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local grow = math.sin(math.rad(utils.interpolate(step, 0, 180)))
					
					local sc = 100 - 5*grow
					
					local mov = 5*math.sin(math.rad(utils.interpolate(step, 90, 180)))
					
					l.text=string.format("{\\an5\\blur1\\bord1\\shad0\\fscx100\\fscy%d\\1c&H715492&\\\3c&H715492&\\pos(%.3f, %.3f)}%s"
					,sc,syl.center,syl.middle+mov,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~=" " and syl.text~="" then
				--syl fx outline 2
				
				max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					l.layer = 6
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local grow = math.sin(math.rad(utils.interpolate(step, 0, 180)))
					
					local sc = 100 - 5*grow
					
					local mov = 5*math.sin(math.rad(utils.interpolate(step, 90, 180)))
					
					l.text=string.format("{\\an5\\blur1\\bord2\\shad0\\fscx100\\fscy%d\\1c&H503586&\\3c&H503586&\\pos(%.3f, %.3f)}%s"
					,sc,syl.center,syl.middle+mov,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~=" " and syl.text~="" then
				--syl fx outline 3
				
				max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local grow = math.sin(math.rad(utils.interpolate(step, 0, 180)))
					
					local sc = 100 - 5*grow
					
					local mov = 5*math.sin(math.rad(utils.interpolate(step, 90, 180)))
					
					l.text=string.format("{\\an5\\blur4\\bord4\\shad0\\fscx100\\fscy%d\\1c&HE0BFF5&\\3c&HE0BFF5&\\pos(%.3f, %.3f)}%s"
					,sc,syl.center,syl.middle+mov,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~=" " and syl.text~="" then
				--syl stars fx
				if line.actor == "white" then
					spark = "m 11 -11 l 11 -11 l 3 -25 l 17 -19 l 29 -29 l 24 -10 l 38 -14 l 25 -2 l 23 14 l 16 -1 l 0 1 "
				else
					spark = "m 0 0 l 6 13 l 21 14 l 11 25 l 15 40 l 1 35 l -11 42 l -10 27 l -21 16 l -6 13 "
				end
				
				maxj = math.random(10,15)
				for j = 1,maxj,1 do
					
					l.start_time = line.start_time+syl.start_time
					l.end_time = line.start_time+syl.end_time+250
					
					l.layer = 10
					
					local rf = math.randomsteps(200, 350, 50)
					
					if line.actor == "color" then
						star_color = star_color_dist:get()
						star_bord = "&HFFFFFF&"
					end
					if line.actor == "white" then
						star_color = "&HF8FDFF&"
						star_bord = "&HFAFDFF&"
					end
					if line.actor == "blue" then
						star_color = star_color_dist2:get()
					end
					
					if line.actor == "white" then
						alpha = "&H00&"
					else
						alpha = "&H64&"
					end
					
					xpos = math.randomsteps(syl.left-2, syl.right+2, 0.5)
					ypos = math.randomsteps(syl.top-2, syl.bottom+2, 0.25)
					sx = syl.center
					sy = syl.middle
					vx = xpos - sx
					vy = ypos - sy
					xmove = syl.center+2*vx+math.random(-3,3)
					ymove = syl.middle+2*vy+math.random(-2,2)
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord1\\1a%s\\3a&H32&\\shad0\\fscx25\\fscy25\\fad(0,%d)\\1c%s\\3c%s\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,alpha,rf,star_color,star_bord,xpos,ypos,xmove,ymove,spark)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--outfade
				maxj = line.height
				for j = 1,maxj,1 do
					
					l.layer = 8
					
					l.start_time = line.start_time+syl.end_time
					l.end_time = line.end_time+line.outfade+10*j-10+50*syl.i-50-of_fix
					
					local clip_src = shape.rectangle(line.width,1)
					local clip = shape.move(clip_src,line.left,line.top+j)
					
					local color = utils.interpolate(j/maxj,"&HF2CBFF&","&HFFFFFF&")
					
					local of_start = l.end_time-l.start_time-250
					local of_end = l.end_time-l.start_time
					
					l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\fad(0,250)\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
					,color,clip,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
				
			end
			
			if syl.text~=" " and syl.text~="" then
				--outfade outline
				
				l.layer = 7
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+40*syl.i-40-of_fix
				
				l.text=string.format("{\\an5\\blur1\\bord1\\shad0\\fscx100\\fscy100\\1c&H715492&\\3c&H715492&\\fad(0,150)\\pos(%.3f, %.3f))}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~=" " and syl.text~="" then
				--outfade outline 2
				
				l.layer = 6
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+40*syl.i-40-of_fix
				
				l.text=string.format("{\\an5\\blur1\\bord2\\shad0\\fscx100\\fscy100\\1c&H503586&\\3c&H503586&\\fad(0,150)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~=" " and syl.text~="" then
				--outfade outline 3
				
				l.layer = 5
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+40*syl.i-40-of_fix
				
				l.text=string.format("{\\an5\\blur4\\bord4\\shad0\\fscx100\\fscy100\\1c&HE0BFF5&\\3c&HE0BFF5&\\fad(0,150)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
		end
	end
	
end

for li, line in ipairs(lines) do
	
	romanji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end