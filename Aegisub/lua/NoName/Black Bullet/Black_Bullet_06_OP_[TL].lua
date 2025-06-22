--Black Bullet OP 2
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	
	line.infade = 1000
	line.outfade = 1000
	
	if line.actor == "blue" then
		color = "&HFFFF5E&"
	end
	if line.actor == "red" then
		color = "&H5B30F9&"
	end
	if line.actor == "purple" then
		color = "&HF565CD&"
	end
	if line.actor == "yellow" then
		color = "&H8DFFFF&"
	end
	
	for si, syl in ipairs(line.syls) do
		
		if syl.i == 1 then
			
			if syl.text~="" then
				--shine fx layer 1
				
				local shine = shape.ellipse(140, 140)
				
				max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time-1000, line.start_time+1000, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 1
					
					local step = i / n
					
					local sc = utils.interpolate(step, 100, 30)+10*math.sin(math.rad(utils.interpolate(step, 0, 720)))+math.randomsteps(-10,10,5)
					
					local xpos, ypos = line.center, line.middle
					
					local deform = shape.filter(shape.split(shine),
					function(x,y)
						local xdef = math.randomsteps(-6,6,1)
						local ydef = math.randomsteps(-6,6,0.5)
						return x+xdef, y+ydef
					end)
					
					l.text = string.format("{\\an5\\p1\\blur15\\bord0\\fscx%d\\fscy%d\\alpha&H96&\\1c%s\\pos(%.3f, %.3f)}%s"
					,sc,sc,color,xpos,ypos,deform)
					
					io.write_line(l)
					
				end
			end
			
			if syl.text~="" then
				--shine fx layer 2
				
				local shine = shape.ellipse(70, 70)
				
				max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time-1000, line.start_time+1000, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 2
					
					local step = i / n
					
					local sc = utils.interpolate(step, 100, 10)+5*math.sin(math.rad(utils.interpolate(step, 0, 720)))+math.randomsteps(-10,10,5)
					
					local xpos, ypos = line.center, line.middle
					
					local deform = shape.filter(shape.split(shine),
					function(x,y)
						local xdef = math.randomsteps(-2,2,0.5)
						local ydef = math.randomsteps(-2,2,1)
						return x+xdef, y+ydef
					end)
					
					l.text = string.format("{\\an5\\p1\\bord3\\blur8\\bord0\\fscx%d\\fscy%d\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,sc,sc,xpos,ypos,deform)
					
					io.write_line(l)
					
				end
				
			end
		end
		
		if syl.text~="" then
			--infade top right
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			max_frame=25
			
			sylstep = syl.i/#line.syls
			ord = syl.i - syl.i + math.cos(math.rad(utils.interpolate(sylstep, 0, 360)))
			
			rs = math.randomsteps(30+10*syl.i, 150+10*syl.i, 10)
			
			for s, e, i, n in utils.frames(line.start_time-1000, line.start_time-50*ord, max_frame) do
				
				local step = i / n
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 5
				
				local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
				local orgx, orgy = line.center, line.middle
				
				local rotation = utils.interpolate(step, rs, 720)
				
				local color2 = utils.interpolate(step, color, "3c&HAEA9B1&")
				
				local deform = shape.filter(split_shape,
				function(x,y)
					
					local x = x + 0
					
					if y < (tly+bry)/2 then
						y = y + 0
					else
						y = (tly+bry)/2
					end
					
					return x, y
				end)
				
				l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\frz%.3f\\1c&HFFFFFF&\\3c%s\\pos(%.3f, %.3f)\\org(%.3f,%.3f)}%s"
				,rotation,color2,xpos,ypos,orgx,orgy,deform)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			--infade bottom
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			max_frame=25
			
			sylstep = syl.i/#line.syls
			ord = syl.i - syl.i + math.cos(math.rad(utils.interpolate(sylstep, 0, 360)))
			
			rs = math.randomsteps(30+10*syl.i, 150+10*syl.i, 10)
			
			for s, e, i, n in utils.frames(line.start_time-1000, line.start_time-50*ord, max_frame) do
				
				local step = i / n
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 5
				
				local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
				local orgx, orgy = line.center, line.middle
				
				local rotation = utils.interpolate(step, rs, -720)
				
				local color2 = utils.interpolate(step, color, "3c&HAEA9B1&")
				
				local deform = shape.filter(split_shape,
				function(x,y)
					
					local x = x + 0
					
					if y > (tly+bry)/2 then
						y = y + 0
					else
						y = (tly+bry)/2
					end
					
					return x, y
				end)
				
				l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\frz%.3f\\1c&HFFFFFF&\\3c%s\\pos(%.3f, %.3f)\\org(%.3f,%.3f)}%s"
				,rotation,color2,xpos,ypos,orgx,orgy,deform)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			--placeholder top right
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			l.layer = 6
			
			l.start_time = line.start_time-100*ord
			l.end_time = line.start_time + syl.start_time
			
			l.layer = 5
			
			local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
			
			local deform = shape.filter(split_shape,
			function(x,y)
				if x > (tlx+brx)/2 then
					x = x + 0
				else
					x = (tlx+brx)/2
				end
				
				if y < (tly+bry)/2 then
					y = y + 0
				else
					y = (tly+bry)/2
				end
				
				return x, y
			end)
			
			l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HAEA9B1&\\pos(%.3f, %.3f)}%s"
			,xpos,ypos,deform)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--placeholder bottom right
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			l.layer = 6
			
			l.start_time = line.start_time-100*ord
			l.end_time = line.start_time + syl.start_time
			
			l.layer = 5
			
			local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
			
			local deform = shape.filter(split_shape,
			function(x,y)
				if x > (tlx+brx)/2 then
					x = x + 0
				else
					x = (tlx+brx)/2
				end
				
				if y > (tly+bry)/2 then
					y = y + 0
				else
					y = (tly+bry)/2
				end
				
				return x, y
			end)
			
			l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HAEA9B1&\\pos(%.3f, %.3f)}%s"
			,xpos,ypos,deform)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--placeholder bottom left
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			l.layer = 6
			
			l.start_time = line.start_time-100*ord
			l.end_time = line.start_time + syl.start_time
			
			l.layer = 5
			
			local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
			
			local deform = shape.filter(split_shape,
			function(x,y)
				if x < (tlx+brx)/2 then
					x = x + 0
				else
					x = (tlx+brx)/2
				end
				
				if y > (tly+bry)/2 then
					y = y + 0
				else
					y = (tly+bry)/2
				end
				
				return x, y
			end)
			
			l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HAEA9B1&\\pos(%.3f, %.3f)}%s"
			,xpos,ypos,deform)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--placeholder top left
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			l.layer = 6
			
			l.start_time = line.start_time-100*ord
			l.end_time = line.start_time + syl.start_time
			
			l.layer = 5
			
			local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
			
			local deform = shape.filter(split_shape,
			function(x,y)
				if x < (tlx+brx)/2 then
					x = x + 0
				else
					x = (tlx+brx)/2
				end
				
				if y < (tly+bry)/2 then
					y = y + 0
				else
					y = (tly+bry)/2
				end
				
				return x, y
			end)
			
			l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HAEA9B1&\\pos(%.3f, %.3f)}%s"
			,xpos,ypos,deform)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--fx top right
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			max_frame=25
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				local step = i / n
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 5
				
				local xpos, ypos = syl.center - syl.width/2 + 3*math.sin(math.rad(utils.interpolate(step, 0 , 180))), syl.middle - syl.height/2 + 3*math.sin(math.rad(utils.interpolate(step, 180 , 360)))
				local orgx, orgy = syl.center, syl.middle
				local rotation = 3*math.sin(math.rad(utils.interpolate(step, 0, 360)))
				
				local deform = shape.filter(split_shape,
				function(x,y)
					if x > (tlx+brx)/2 then
						x = x + 0
					else
						x = (tlx+brx)/2 + 5*math.sin(math.rad(utils.interpolate(step, 1, x))) + math.random(-10,10)
					end
					
					if y < (tly+bry)/2 then
						y = y + 0
					else
						y = (tly+bry)/2 + 5*math.sin(math.rad(utils.interpolate(step, 1, y))) + math.randomsteps(-10,10,2.5)
					end
					
					return x, y
				end)
				
				l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\frz%.3f\\1c&HFFFFFF&\\3c&HAEA9B1&\\pos(%.3f, %.3f)\\org(%.3f,%.3f)}%s"
				,rotation,xpos,ypos,orgx,orgy,deform)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			--fx top bottom
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			max_frame=25
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				local step = i / n
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 5
				
				local xpos, ypos = syl.center - syl.width/2 + 3*math.sin(math.rad(utils.interpolate(step, 0 , 180))), syl.middle - syl.height/2 + 3*math.sin(math.rad(utils.interpolate(step, 0 , 180)))
				local orgx, orgy = syl.center, syl.middle
				local rotation = 3*math.sin(math.rad(utils.interpolate(step, 0, 360)))
				
				local deform = shape.filter(split_shape,
				function(x,y)
					if x > (tlx+brx)/2 then
						x = x + 0
					else
						x = (tlx+brx)/2 + 5*math.sin(math.rad(utils.interpolate(step, 1, x))) + math.random(-10,10)
					end
					
					if y > (tly+bry)/2 then
						y = y + 0
					else
						y = (tly+bry)/2 + 5*math.sin(math.rad(utils.interpolate(step, 1, y))) + math.randomsteps(-10,10,2.5)
					end
					
					return x, y
				end)
				
				l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\frz%.3f\\1c&HFFFFFF&\\3c&HAEA9B1&\\pos(%.3f, %.3f)\\org(%.3f,%.3f)}%s"
				,rotation,xpos,ypos,orgx,orgy,deform)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			--fx bottom left
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			max_frame=25
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				local step = i / n
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 5
				
				local xpos, ypos = syl.center - syl.width/2 + 3*math.sin(math.rad(utils.interpolate(step, 180 , 360))), syl.middle - syl.height/2 + 3*math.sin(math.rad(utils.interpolate(step, 0 , 180)))
				local orgx, orgy = syl.center, syl.middle
				local rotation = 3*math.sin(math.rad(utils.interpolate(step, 0, 360)))
				
				local deform = shape.filter(split_shape,
				function(x,y)
					if x < (tlx+brx)/2 then
						x = x + 0
					else
						x = (tlx+brx)/2 + 5*math.sin(math.rad(utils.interpolate(step, 1, x))) + math.random(-10,10)
					end
					
					if y > (tly+bry)/2 then
						y = y + 0
					else
						y = (tly+bry)/2 + 5*math.sin(math.rad(utils.interpolate(step, 1, y))) + math.randomsteps(-10,10,2.5)
					end
					
					return x, y
				end)
				
				l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\frz%.3f\\1c&HFFFFFF&\\3c&HAEA9B1&\\pos(%.3f, %.3f)\\org(%.3f,%.3f)}%s"
				,rotation,xpos,ypos,orgx,orgy,deform)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			--fx top left
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			max_frame=25
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				local step = i / n
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 5
				
				local xpos, ypos = syl.center - syl.width/2 + 3*math.sin(math.rad(utils.interpolate(step, 180 , 360))), syl.middle - syl.height/2 + 3*math.sin(math.rad(utils.interpolate(step, 180 , 360)))
				local orgx, orgy = syl.center, syl.middle
				local rotation = 3*math.sin(math.rad(utils.interpolate(step, 0, 360)))
				
				local deform = shape.filter(split_shape,
				function(x,y)
					if x < (tlx+brx)/2 then
						x = x + 0
					else
						x = (tlx+brx)/2 + 5*math.sin(math.rad(utils.interpolate(step, 1, x))) + math.random(-10,10)
					end
					
					if y < (tly+bry)/2 then
						y = y + 0
					else
						y = (tly+bry)/2 + 5*math.sin(math.rad(utils.interpolate(step, 1, y))) + math.randomsteps(-10,10,2.5)
					end
					
					return x, y
				end)
				
				l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\frz%.3f\\1c&HFFFFFF&\\3c&HAEA9B1&\\pos(%.3f, %.3f)\\org(%.3f,%.3f)}%s"
				,rotation,xpos,ypos,orgx,orgy,deform)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			--outfade top right
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			l.layer = 6
			
			l.start_time = line.start_time + syl.end_time
			l.end_time = line.end_time + 250
			
			l.layer = 5
			
			local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
			local xmove, ymove = xpos + math.randomsteps(-10,10,2), ypos + math.random(-10,10)
			local x_rot, y_rot = math.randomsteps(-60,60,15), math.randomsteps(-60,60,10)
			local of_start = l.end_time-l.start_time-500
			local of_end = l.end_time-l.start_time
			
			local deform = shape.filter(split_shape,
			function(x,y)
				if x > (tlx+brx)/2 then
					x = x + 0
				else
					x = (tlx+brx)/2
				end
				
				if y < (tly+bry)/2 then
					y = y + 0
				else
					y = (tly+bry)/2
				end
				
				return x, y
			end)
			
			l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1c&HFFFFFF&\\3c&HAEA9B1&\\fad(0,250)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
			,of_start,of_end,x_rot,y_rot,xpos,ypos,xmove,ymove,of_start,of_end,deform)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--outfade bottom right
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			l.layer = 6
			
			l.start_time = line.start_time + syl.end_time
			l.end_time = line.end_time + 250
			
			l.layer = 5
			
			local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
			local xmove, ymove = xpos + math.randomsteps(-10,10,2), ypos + math.random(-10,10)
			local x_rot, y_rot = math.randomsteps(-60,60,15), math.randomsteps(-60,60,10)
			local of_start = l.end_time-l.start_time-500
			local of_end = l.end_time-l.start_time
			
			local deform = shape.filter(split_shape,
			function(x,y)
				if x > (tlx+brx)/2 then
					x = x + 0
				else
					x = (tlx+brx)/2
				end
				
				if y > (tly+bry)/2 then
					y = y + 0
				else
					y = (tly+bry)/2
				end
				
				return x, y
			end)
			
			l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1c&HFFFFFF&\\3c&HAEA9B1&\\fad(0,250)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
			,of_start,of_end,x_rot,y_rot,xpos,ypos,xmove,ymove,of_start,of_end,deform)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--outfade bottom left
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			l.layer = 6
			
			l.start_time = line.start_time + syl.end_time
			l.end_time = line.end_time + 250
			
			l.layer = 5
			
			local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
			local xmove, ymove = xpos + math.randomsteps(-10,10,2), ypos + math.random(-10,10)
			local x_rot, y_rot = math.randomsteps(-60,60,15), math.randomsteps(-60,60,10)
			local of_start = l.end_time-l.start_time-500
			local of_end = l.end_time-l.start_time
			
			local deform = shape.filter(split_shape,
			function(x,y)
				if x < (tlx+brx)/2 then
					x = x + 0
				else
					x = (tlx+brx)/2
				end
				
				if y > (tly+bry)/2 then
					y = y + 0
				else
					y = (tly+bry)/2
				end
				
				return x, y
			end)
			
			l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1c&HFFFFFF&\\3c&HAEA9B1&\\fad(0,250)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
			,of_start,of_end,x_rot,y_rot,xpos,ypos,xmove,ymove,of_start,of_end,deform)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--outfade top left
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			
			l.layer = 6
			
			l.start_time = line.start_time + syl.end_time
			l.end_time = line.end_time + 250
			
			l.layer = 5
			
			local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
			local xmove, ymove = xpos + math.randomsteps(-10,10,2), ypos + math.random(-10,10)
			local x_rot, y_rot = math.randomsteps(-60,60,15), math.randomsteps(-60,60,10)
			local of_start = l.end_time-l.start_time-500
			local of_end = l.end_time-l.start_time
			
			local deform = shape.filter(split_shape,
			function(x,y)
				if x < (tlx+brx)/2 then
					x = x + 0
				else
					x = (tlx+brx)/2
				end
				
				if y < (tly+bry)/2 then
					y = y + 0
				else
					y = (tly+bry)/2
				end
				
				return x, y
			end)
			
			l.text=string.format("{\\p4\\an7\\blur3\\bord0.5\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1c&HFFFFFF&\\3c&HAEA9B1&\\fad(0,250)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
			,of_start,of_end,x_rot,y_rot,xpos,ypos,xmove,ymove,of_start,of_end,deform)
			
			io.write_line(l)
		end
	end
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end