--Absolute Duo OP
--Karaoke by Amberdrake
--VSFilterMod

function kara(line, l)
	
	line.infade = 250
	line.outfade = 250
	
	if line.style == "AD_OP_romaji" or line.style == "AD_OP_romaji_L" or line.style == "AD_OP_romaji_R" or line.style == "AD_OP_kanji" or line.style == "AD_OP_kanji_L" or line.style == "AD_OP_kanji_R" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--infade
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+25*syl.i-25
				l.end_time = line.start_time+syl.start_time
				
				local pct = math.abs(math.sin(math.rad(utils.interpolate(syl.i/#line.syls, 0, 360))))
				
				local c0 = utils.interpolate(pct, "&H842716&", "&H191684&")
				
				if syl.i%2 == 1 then
					color = string.format("(%s, &HFFFFFF&, &HFFFFFF&, %s)",c0,c0)
					frxs = math.randomsteps(-360, -90, 90)
					frys = math.randomsteps(-360, -90, 45)
				else
					color = string.format("(&HFFFFFF&, &HFFFFFF&, %s, %s)",c0,c0)
					frxs = math.randomsteps(90, 360, 45)
					frys = math.randomsteps(90, 360, 90)
				end
				
				local rs = math.randomsteps(-25,25,10)
				local jp = math.randomsteps(25,100,25)
				local js = math.random(1,4)
				
				l.text = string.format("{\\an5\\bord2\\blur0.6\\shad0\\fscx80\\fscy100\\frx%d\\fry%d\\t(0,250,\\frx0\\fry0)\\1vc%s\\3c&H000000&\\fad(100,0)\\move(%.3f, %.3f, %.3f, %.3f, 0, 250)}%s"
				,frxs,frys,color,syl.center,syl.middle+rs,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx
				
				local max_frame = 25
				
				local rsc = math.randomsteps(20,30,5)
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 6
					
					local step = i / n
					
					l.start_time = s
					l.end_time = e
					
					local pct = math.abs(math.sin(math.rad(utils.interpolate(syl.i/#line.syls, 0, 360))))
					
					local c0 = utils.interpolate(pct, "&H842716&", "&H191684&")
					
					if syl.i%2 == 1 then
						color = string.format("(%s, &HFFFFFF&, &HFFFFFF&, %s)",c0,c0)
					else
						color = string.format("(&HFFFFFF&, &HFFFFFF&, %s, %s)",c0,c0)
					end
					
					local rs = math.randomsteps(-25,25,10)
					local j1, j2, j3, j4 = math.random(1,2), math.random(1,3), math.randomsteps(1,3,2),math.random(1,4)
					local jp = math.randomsteps(25,100,25)
					local js = math.random(1,4)
					
					local scx = 80 + rsc*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					local scy = 100 + rsc*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					
					local x, y = syl.center + 3*math.sin(math.rad(utils.interpolate(step, 0, 360))), syl.middle + 3*math.sin(math.rad(utils.interpolate(step, 0, 360)))
					
					l.text = string.format("{\\an5\\bord2\\blur0.6\\shad0\\fscx%d\\fscy%d\\1vc%s\\3c&H000000&\\jitter(%d,%d,%d,%d ,%d,%d)\\pos(%.3f, %.3f}%s"
					,scx,scy,color,j1,j2,j3,j4,jp,js,x,y,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--outfade top right
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 4
				
				l.start_time = line.start_time + syl.end_time
				l.end_time = line.start_time+syl.end_time + 500
				
				local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
				local xmove, ymove = xpos + math.randomsteps(-20,20,5), ypos + math.randomsteps(-20,20,10)
				local x_rot, y_rot = math.randomsteps(-80,40,15), math.randomsteps(-40,80,10)
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
				
				local pct = math.abs(math.sin(math.rad(utils.interpolate(syl.i/#line.syls, 0, 360))))
				local c0 = utils.interpolate(pct, "&H842716&", "&H191684&")
				if syl.i%2 == 1 then
					color = string.format("(%s, &HFFFFFF&, &HFFFFFF&, %s)",c0,c0)
				else
					color = string.format("(&HFFFFFF&, &HFFFFFF&, %s, %s)",c0,c0)
				end
				
				l.text=string.format("{\\p4\\an7\\bord2\\blur0.6\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1vc%s\\3c&H000000&\\fad(0,500)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
				,of_start,of_end,x_rot,y_rot,color,xpos,ypos,xmove,ymove,of_start,of_end,deform)
				
				io.write_line(l)
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--outfade bottom right
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 4
				
				l.start_time = line.start_time + syl.end_time
				l.end_time = line.start_time+syl.end_time + 500
				
				local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
				local xmove, ymove = xpos + math.randomsteps(-25,25,5), ypos + math.randomsteps(-30,30,10)
				local x_rot, y_rot = math.randomsteps(-120,50,15), math.randomsteps(-100,130,10)
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
				
				local pct = math.abs(math.sin(math.rad(utils.interpolate(syl.i/#line.syls, 0, 360))))
				local c0 = utils.interpolate(pct, "&H842716&", "&H191684&")
				if syl.i%2 == 1 then
					color = string.format("(%s, &HFFFFFF&, &HFFFFFF&, %s)",c0,c0)
				else
					color = string.format("(&HFFFFFF&, &HFFFFFF&, %s, %s)",c0,c0)
				end
				
				l.text=string.format("{\\p4\\an7\\bord2\\blur0.6\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1vc%s\\3c&H000000&\\fad(0,500)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
				,of_start,of_end,x_rot,y_rot,color,xpos,ypos,xmove,ymove,of_start,of_end,deform)
				
				io.write_line(l)
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--outfade bottom left
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 4
				
				l.start_time = line.start_time + syl.end_time
				l.end_time = line.start_time+syl.end_time + 500
				
				local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
				local xmove, ymove = xpos + math.randomsteps(-30,30,5), ypos + math.randomsteps(-25,25,5)
				local x_rot, y_rot = math.randomsteps(-80,80,15), math.randomsteps(-110,130,10)
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
				
				local pct = math.abs(math.sin(math.rad(utils.interpolate(syl.i/#line.syls, 0, 360))))
				local c0 = utils.interpolate(pct, "&H842716&", "&H191684&")
				if syl.i%2 == 1 then
					color = string.format("(%s, &HFFFFFF&, &HFFFFFF&, %s)",c0,c0)
				else
					color = string.format("(&HFFFFFF&, &HFFFFFF&, %s, %s)",c0,c0)
				end
				
				l.text=string.format("{\\p4\\an7\\bord2\\blur0.6\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1vc%s\\3c&H000000&\\fad(0,500)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
				,of_start,of_end,x_rot,y_rot,color,xpos,ypos,xmove,ymove,of_start,of_end,deform)
				
				io.write_line(l)
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--outfade top left
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 4
				
				l.start_time = line.start_time + syl.end_time
				l.end_time = line.start_time+syl.end_time + 500
				
				local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
				local xmove, ymove = xpos + math.randomsteps(-20,20,2), ypos + math.random(-30,30)
				local x_rot, y_rot = math.randomsteps(-145,45,15), math.randomsteps(-120,120,10)
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
				
				local pct = math.abs(math.sin(math.rad(utils.interpolate(syl.i/#line.syls, 0, 360))))
				local c0 = utils.interpolate(pct, "&H842716&", "&H191684&")
				if syl.i%2 == 1 then
					color = string.format("(%s, &HFFFFFF&, &HFFFFFF&, %s)",c0,c0)
				else
					color = string.format("(&HFFFFFF&, &HFFFFFF&, %s, %s)",c0,c0)
				end
				
				l.text=string.format("{\\p4\\an7\\bord2\\blur0.6\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1vc%s\\3c&H000000&\\fad(0,500)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
				,of_start,of_end,x_rot,y_rot,color,xpos,ypos,xmove,ymove,of_start,of_end,deform)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "AD_OP_TL" or line.style == "AD_OP_TL_L" or line.style == "AD_OP_TL_R" then
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--infade
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+25*syl.i-25
				l.end_time = line.end_time
				
				local pct = math.abs(math.sin(math.rad(utils.interpolate(syl.i/#line.syls, 0, 360))))
				
				local c0 = utils.interpolate(pct, "&H842716&", "&H191684&")
				
				if syl.i%2 == 1 then
					color = string.format("(%s, &HFFFFFF&, &HFFFFFF&, %s)",c0,c0)
					frxs = math.randomsteps(-360, -90, 90)
					frys = math.randomsteps(-360, -90, 45)
				else
					color = string.format("(&HFFFFFF&, &HFFFFFF&, %s, %s)",c0,c0)
					frxs = math.randomsteps(90, 360, 45)
					frys = math.randomsteps(90, 360, 90)
				end
				
				local rs = math.randomsteps(-25,25,10)
				local jp = math.randomsteps(25,100,25)
				local js = math.random(1,4)
				
				l.text = string.format("{\\an5\\bord2\\blur0.6\\shad0\\fscx80\\fscy100\\frx%d\\fry%d\\t(0,250,\\frx0\\fry0)\\1vc%s\\3c&H000000&\\fad(100,0)\\move(%.3f, %.3f, %.3f, %.3f, 0, 250)}%s"
				,frxs,frys,color,syl.center,syl.middle+rs,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--outfade top right
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 4
				
				l.start_time = line.end_time
				l.end_time = line.end_time + 500
				
				local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
				local xmove, ymove = xpos + math.randomsteps(-20,20,5), ypos + math.randomsteps(-20,20,10)
				local x_rot, y_rot = math.randomsteps(-80,40,15), math.randomsteps(-40,80,10)
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
				
				local pct = math.abs(math.sin(math.rad(utils.interpolate(syl.i/#line.syls, 0, 360))))
				local c0 = utils.interpolate(pct, "&H842716&", "&H191684&")
				if syl.i%2 == 1 then
					color = string.format("(%s, &HFFFFFF&, &HFFFFFF&, %s)",c0,c0)
				else
					color = string.format("(&HFFFFFF&, &HFFFFFF&, %s, %s)",c0,c0)
				end
				
				l.text=string.format("{\\p4\\an7\\bord2\\blur0.6\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1vc%s\\3c&H000000&\\fad(0,500)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
				,of_start,of_end,x_rot,y_rot,color,xpos,ypos,xmove,ymove,of_start,of_end,deform)
				
				io.write_line(l)
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--outfade bottom right
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 4
				
				l.start_time = line.end_time
				l.end_time = line.end_time + 500
				
				local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
				local xmove, ymove = xpos + math.randomsteps(-25,25,5), ypos + math.randomsteps(-30,30,10)
				local x_rot, y_rot = math.randomsteps(-120,50,15), math.randomsteps(-100,130,10)
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
				
				local pct = math.abs(math.sin(math.rad(utils.interpolate(syl.i/#line.syls, 0, 360))))
				local c0 = utils.interpolate(pct, "&H842716&", "&H191684&")
				if syl.i%2 == 1 then
					color = string.format("(%s, &HFFFFFF&, &HFFFFFF&, %s)",c0,c0)
				else
					color = string.format("(&HFFFFFF&, &HFFFFFF&, %s, %s)",c0,c0)
				end
				
				l.text=string.format("{\\p4\\an7\\bord2\\blur0.6\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1vc%s\\3c&H000000&\\fad(0,500)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
				,of_start,of_end,x_rot,y_rot,color,xpos,ypos,xmove,ymove,of_start,of_end,deform)
				
				io.write_line(l)
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--outfade bottom left
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 4
				
				l.start_time = line.end_time
				l.end_time = line.end_time + 500
				
				local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
				local xmove, ymove = xpos + math.randomsteps(-30,30,5), ypos + math.randomsteps(-25,25,5)
				local x_rot, y_rot = math.randomsteps(-80,80,15), math.randomsteps(-110,130,10)
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
				
				local pct = math.abs(math.sin(math.rad(utils.interpolate(syl.i/#line.syls, 0, 360))))
				local c0 = utils.interpolate(pct, "&H842716&", "&H191684&")
				if syl.i%2 == 1 then
					color = string.format("(%s, &HFFFFFF&, &HFFFFFF&, %s)",c0,c0)
				else
					color = string.format("(&HFFFFFF&, &HFFFFFF&, %s, %s)",c0,c0)
				end
				
				l.text=string.format("{\\p4\\an7\\bord2\\blur0.6\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1vc%s\\3c&H000000&\\fad(0,500)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
				,of_start,of_end,x_rot,y_rot,color,xpos,ypos,xmove,ymove,of_start,of_end,deform)
				
				io.write_line(l)
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--outfade top left
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 4
				
				l.start_time = line.end_time
				l.end_time = line.end_time + 500
				
				local xpos, ypos = syl.center - syl.width/2, syl.middle - syl.height/2
				local xmove, ymove = xpos + math.randomsteps(-20,20,2), ypos + math.random(-30,30)
				local x_rot, y_rot = math.randomsteps(-145,45,15), math.randomsteps(-120,120,10)
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
				
				local pct = math.abs(math.sin(math.rad(utils.interpolate(syl.i/#line.syls, 0, 360))))
				local c0 = utils.interpolate(pct, "&H842716&", "&H191684&")
				if syl.i%2 == 1 then
					color = string.format("(%s, &HFFFFFF&, &HFFFFFF&, %s)",c0,c0)
				else
					color = string.format("(&HFFFFFF&, &HFFFFFF&, %s, %s)",c0,c0)
				end
				
				l.text=string.format("{\\p4\\an7\\bord2\\blur0.6\\shad0\\fscx100\\fscy100\\frx0\\fry0\\t(%d,%d,\\frx%d\\fry%d)\\1vc%s\\3c&H000000&\\fad(0,500)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
				,of_start,of_end,x_rot,y_rot,color,xpos,ypos,xmove,ymove,of_start,of_end,deform)
				
				io.write_line(l)
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end