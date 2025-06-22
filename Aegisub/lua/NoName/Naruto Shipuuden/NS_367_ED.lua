--Naruto Shippuden ED 30
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	
	line.infade = 250
	line.outfade = 250
	if line.style == "ED_rap" or line.style == "ED_rap_overlap" then
		for ci, char in ipairs(line.chars) do
			
			if char.text~=" " then
				--rap infade fx1
				
				max_frame = 25
				u_in=0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time+char.start_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 5
					
					local step = i / n
					
					fad = 250
					max=math.ceil(fad/max_frame)
					
					if i<math.ceil(fad/max_frame) then
						if char.i%2==0 then
							xpos = utils.interpolate(u_in/max, char.center-10, char.center)
						else
							xpos = utils.interpolate(u_in/max, char.center+10, char.center)
						end
						u_in=u_in+1
					else
						xpos = char.center
					end
					
					l.text = string.format("{\\an5\\blur1.2\\bord3\\fscx100\\fscy100\\1c&H000000&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,xpos,char.middle,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~=" " then
				--rap infade fx2
				
				max_frame = 25
				u_in=0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time-line.infade+250, max_frame) do
					
					l.start_time = s
					l.end_time = e + 500
					
					l.layer = 4
					
					local step = i / n
					
					fad = 250
					max=math.ceil(fad/max_frame)
					
					if i<math.ceil(fad/max_frame) then
						if char.i%2==0 then
							xpos = utils.interpolate(u_in/max, char.center-10, char.center)
						else
							xpos = utils.interpolate(u_in/max, char.center+10, char.center)
						end
						u_in=u_in+1
					else
						xpos = char.center
					end
					
					l.text = string.format("{\\an5\\blur1\\bord2\\fscx100\\fscy100\\fad(0,500)\\1c&H000000&\\3c&HFFFFFF&\\alpha&H64&\\pos(%.3f, %.3f)}%s"
					,xpos,char.middle,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~=" " then
				--rap char fx
				
				max_frame = 25
				a = 0
				b = 0
				
				for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
					
					l.layer = 6
					
					step = i / n
					
					l.start_time = s
					l.end_time = e
					
					x = char.center
					
					if char.i%2 == 0 then
						sc_x = 100 + 60*math.sin(math.rad(utils.interpolate(step, 30, 180)))
						sc_y = 100 + 40*math.sin(math.rad(utils.interpolate(step, 30, 180)))
						x_rot = 10*math.sin(math.rad(a))
						y_rot = 50*math.sin(math.rad(b))
						a = a + 10
						b = b + 15
						y = char.middle + 2*math.sin(math.rad(utils.interpolate(step, 0,180)))
					end
					if char.i%2 == 1 then
						sc_x = 100 + 60*math.sin(math.rad(utils.interpolate(step, 0, 180)))
						sc_y = 100 + 40*math.sin(math.rad(utils.interpolate(step, 0, 180)))
						x_rot = 10*math.cos(math.rad(b))
						y_rot = 50*math.cos(math.rad(a))
						a = a + 10
						b = b + 15
						y = char.middle + 2*math.sin(math.rad(utils.interpolate(step,180,270)))
					end
					
					l.text = string.format("{\\an5\\blur1.2\\bord3\\1c&H000000&\\3c&HFFFFFF&\\fscx%d\\fscy%d\\frx%d\\fry%d\\pos(%.3f, %.3f}%s"
					,sc_x,sc_y,x_rot,y_rot,x,y,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~=" " then
				--rap char fx2
				
				max_frame = 25
				a = 0
				b = 0
				
				for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
					
					l.layer = 3
					
					step = i / n
					
					l.start_time = s
					l.end_time = e + 250
					
					x = char.center
					
					if char.i%2 == 0 then
						sc_x = 100 + 60*math.sin(math.rad(utils.interpolate(step, 30, 180)))
						sc_y = 100 + 40*math.sin(math.rad(utils.interpolate(step, 30, 180)))
						x_rot = 10*math.sin(math.rad(a))
						y_rot = 50*math.sin(math.rad(b))
						a = a + 10
						b = b + 15
						y = char.middle + 2*math.sin(math.rad(utils.interpolate(step, 0,180)))
					end
					if char.i%2 == 1 then
						sc_x = 100 + 60*math.sin(math.rad(utils.interpolate(step, 0, 180)))
						sc_y = 100 + 40*math.sin(math.rad(utils.interpolate(step, 0, 180)))
						x_rot = 10*math.cos(math.rad(b))
						y_rot = 50*math.cos(math.rad(a))
						a = a + 10
						b = b + 15
						y = char.middle + 2*math.sin(math.rad(utils.interpolate(step,180,270)))
					end
					
					l.text = string.format("{\\an5\\blur1\\bord1\\1c&H000000&\\3c&HFFFFFF&\\1a&HFF&\\3a&H64&\\fscx%d\\fscy%d\\frx%d\\fry%d\\fad(0,150)\\pos(%.3f, %.3f}%s"
					,sc_x,sc_y,x_rot,y_rot,x,y,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~=" " then
				--rap fadeout
				
				l.layer = 4
				
				l.start_time = line.start_time+char.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\blur1.2\\bord3\\fscx100\\fscy100\\1c&H000000&\\3c&HFFFFFF&\\fad(0,500)\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
	end
	if line.style == "ED_sing" or line.style == "ED_sing_overlap" then
		
		for ci, char in ipairs(line.chars) do
			
			if char.text~=" " then
				--sing infade fx1
				
				max_frame = 25
				u_in=0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+10*char.i-10, line.start_time+char.start_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 5
					
					local step = i / n
					
					fad = 250
					max=math.ceil(fad/max_frame)
					
					if i<math.ceil(fad/max_frame) then
						if char.i%2==0 then
							ypos = utils.interpolate(u_in/max, char.middle-10, char.middle)
						else
							ypos = utils.interpolate(u_in/max, char.middle+10, char.middle)
						end
						u_in=u_in+1
					else
						ypos = char.middle
					end
					
					l.text = string.format("{\\an5\\blur1.2\\bord3\\fscx100\\fscy100\\1c&H000000&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,char.center,ypos,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~=" " then
				--sing infade fx2
				
				max_frame = 25
				u_in=0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+10*char.i-10, line.start_time-line.infade+250, max_frame) do
					
					l.start_time = s
					l.end_time = e + 350
					
					l.layer = 4
					
					local step = i / n
					
					fad = 250
					max=math.ceil(fad/max_frame)
					
					if i<math.ceil(fad/max_frame) then
						if char.i%2==0 then
							ypos = utils.interpolate(u_in/max, char.middle-10, char.middle)
						else
							ypos = utils.interpolate(u_in/max, char.middle+10, char.middle)
						end
						u_in=u_in+1
					else
						ypos = char.middle
					end
					
					l.text = string.format("{\\an5\\blur1.2\\bord3\\fscx100\\fscy100\\fad(0,250)\\1c&H000000&\\3c&HFFFFFF&\\alpha&H96&\\pos(%.3f, %.3f)}%s"
					,char.center,ypos,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~=" " then
				--sing fadeout
				
				l.layer = 4
				
				l.start_time = line.start_time+char.end_time
				l.end_time = line.end_time+line.outfade-10*char.i-10
				
				l.text = string.format("{\\an5\\blur1.2\\bord3\\fscx100\\fscy100\\1c&H000000&\\3c&HFFFFFF&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
		
		for si, syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--sing fx 1
				
				max_frame = 25
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 7
					
					local step = i / n
					
					local sc = utils.interpolate(step, 100, 130)+10*math.sin(math.rad(utils.interpolate(step, 0, 720)))+math.randomsteps(-10,10,5)
					
					local xpos, ypos = syl.left+syl.width/2 , utils.interpolate(step, syl.top, syl.top+syl.height/4)
					
					local deform = shape.filter(shape.split(text_shape),
					function(x,y)
						local xdef = math.randomsteps(-10,10,1)
						local ydef = math.randomsteps(-10,10,0.5)
						return x+xdef, y+ydef
					end)
					
					l.text = string.format("{\\an5\\p4\\blur1.2\\bord3\\fscx%d\\fscy%d\\1c&H000000&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,sc,sc,xpos,ypos,deform)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--sing fx 2
				
				max_frame = 25
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e + 250
					
					l.layer = 2
					
					local step = i / n
					
					local sc = utils.interpolate(step, 100, 130)+10*math.sin(math.rad(utils.interpolate(step, 0, 720)))+math.randomsteps(-10,10,5)
					
					local xpos, ypos = syl.left+syl.width/2 , utils.interpolate(step, syl.top, syl.top+syl.height/4)
					
					local deform = shape.filter(shape.split(text_shape),
					function(x,y)
						local xdef = math.randomsteps(-10,10,1)
						local ydef = math.randomsteps(-10,10,0.5)
						return x+xdef, y+ydef
					end)
					
					l.text = string.format("{\\an5\\p4\\blur1.2\\bord3\\fscx%d\\fscy%d\\1c&H000000&\\3c&HFFFFFF&\\fad(0,250)\\alpha&H64&\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,sc,sc,xpos,ypos,xpos,ypos-10,deform)
					
					io.write_line(l)
				end
			end
		end
	end
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end