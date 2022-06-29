function romanji(line, l)
	--Akame ga Kill OP
	--Karaoke by Amberdrake
	--VSFilter
	
	if line.infade > 250 then
		line.infade = 250
	end
	if line.outfade > 250 then
		line.outfade = 250
	end
	for ci,char in ipairs(line.chars) do
		if char.text~=" " and char.i == 1 and line.style == "OP_romanji" or line.style == "OP_TL" then
			--infade cut
			
			max_frame=2
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time-line.infade + 10*#line.chars, max_frame) do
				
				local if_shape = "m 0 0 b -3 -1 -4 -2 -6 -2 b -8 -3 -10 -1 -21 -1 b -30 -1 -55 -1 -90 0 b -50 0 -36 1 -21 1 b -10 1 -8 3 -6 2 b -4 2 -3 1 0 0 "
				l.layer = 6
				
				l.start_time = s
				l.end_time = e + 150
				
				local step = i / n
				
				local x1, x2, y = line.left, line.left+line.width+50, line.middle
				local x = utils.interpolate(step, x1, x2)
				
				l.text=string.format("{\\p1\\an7\\blur1.5\\bord0\\shad0\\fscx100\\fscy100\\1c&H391B73&\\t(\\fscx0\\fscy0\\1c&HFFFFFF&)\\fad(0,150)\\pos(%.3f, %.3f)}%s"
				,x,y,if_shape)
				
				io.write_line(l)
			end
		end
	end
	if line.style == "OP_romanji" or line.style == "OP_kanji" then
		for ci,char in ipairs(line.chars) do
			
			if char.text~=" " and char.text~="" then
				
				--infade red
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local tlx, tly, brx, bry = shape.bounding(text_shape)

				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+10*char.i-10
				l.end_time = line.start_time+char.end_time
				
				local x1, y1, x2, y2 = char.center - char.width/2, char.middle - char.height/2 - 15, char.center - char.width/2, char.middle - char.height/2
				
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
				
				l.text=string.format("{\\p4\\an7\\blur0.4\\bord0\\shad1\\fscx100\\fscy100\\1c&H391B73&\\4c&HFFFFFF&\\fad(50,0)\\move(%.3f, %.3f, %.3f, %.3f, 0, 100)}%s"
				,x1,y1,x2,y2,deform)
				
				io.write_line(l)
			end
			
			if char.text~=" " and char.text~="" then
				--infade black
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+10*char.i-10
				l.end_time = line.start_time+char.end_time
				
				local x1, y1, x2, y2 = char.center - char.width/2, char.middle - char.height/2 + 15, char.center - char.width/2, char.middle - char.height/2
				
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
				
				l.text=string.format("{\\p4\\an7\\blur0.4\\bord0\\shad1\\fscx100\\fscy100\\1c&H000000&\\4c&HFFFFFF&\\fad(50,0)\\move(%.3f, %.3f, %.3f, %.3f, 0, 100)}%s"
				,x1,y1,x2,y2,deform)
				
				io.write_line(l)
			end
		end
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~=" " and syl.text~="" then
				--cut paths
				if syl.i % 2 == 0 then
					local text_shape = convert.text_to_shape(syl.text, line.styleref)
					local tlx, tly, brx, bry = shape.bounding(text_shape)
					xp1 = math.random(syl.left+tlx/4-syl.width/2, syl.left+tlx/4)
					yp1 = math.random(syl.top+tly/4-syl.height/2, syl.top+tly/4)
					xp2 = math.randomsteps(syl.left+brx/4-syl.width/2, syl.left+brx/4, 2)
					yp2 = math.randomsteps(syl.top+bry/4-syl.height/2, syl.top+bry/4, 2)
				end
				
				if syl.i % 2 == 1 then
					local text_shape = convert.text_to_shape(syl.text, line.styleref)
					tlx, tly, brx, bry = shape.bounding(text_shape)
					xp1 = math.randomsteps(syl.left+brx/4-syl.width/2, syl.left+brx/4, 2)
					yp1 = math.random(syl.top+tly/4-syl.height/2, syl.top+tly/4)
					yp2 = math.randomsteps(syl.top+bry/4-syl.height/2, syl.top+bry/4, 2)
					xp2 = math.random(syl.left+tlx/4-syl.width/2, syl.left+tlx/4)
				end
				fad1 = math.randomsteps(50,250,50)
				fad2 = math.randomsteps(50,250,25)
				xrange = math.random(10,15)
				yrange = math.randomsteps(10,14,2)
			end
			if syl.text~=" " and syl.text~="" and line.style == "OP_romanji" or line.style == "OP_kanji" then
				--syl fx 2
				
				local fx_shape = shape.ellipse(2,2)
				max_frame = 1
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.start_time+150, max_frame) do
					
					l.layer = 6
					
					l.start_time = s
					l.end_time = e + 500
					
					local step = i / n
					
					local x, y = utils.interpolate(step, xp1, xp2), utils.interpolate(step, yp1, yp2)
					
					l.text=string.format("{\\an7\\p1\\bord0\\blur0\\shad0\\fscx100\\fscy100\\t(\\fscx0\\fscy0\\1c&HFFFFFF&)\\1c&H1200B3&)\\fad(0,500)\\pos(%.3f, %.3f)}%s"
					,x,y,fx_shape)
					
					io.write_line(l)
				end
			end
			if syl.text~=" " and syl.text~="" then
				--outfade red pt1
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				u_out = 0
				
				max_frame = 23.976
				
				for s, e, i, n in utils.frames(line.start_time+syl.end_time, line.start_time+syl.end_time+500, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local x, y= syl.center - syl.width/2, syl.middle - syl.height/2
					
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
					
					if syl.i%2 == 0 then
						xmov = utils.interpolate(step, 0, xrange)
						ymov = utils.interpolate(step, 0, yrange)
						d1 = syl.right + 5
						d2 = syl.left - 5
					else
						xmov = utils.interpolate(step, 0, -xrange)
						ymov = utils.interpolate(step, 0, -yrange)
						d1 = syl.left - 5
						d2 = syl.right + 5
					end
					
					max=math.ceil(fad1/max_frame)
					if i>(n-math.ceil(fad1/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					l.text=string.format("{\\p4\\an7\\blur0.4\\bord0\\shad1\\fscx100\\fscy100\\alpha%s\\1c&H391B73&\\4c&HFFFFFF&\\clip(m %.3f %.3f l %.3f %.3f %.3f %.3f %.3f %.3f)\\pos(%.3f, %.3f)}%s"
					,alpha,xp1+xmov,yp1+ymov,xp2+xmov,yp2+ymov,d1+xmov, syl.top+ymov, d2+xmov, syl.top+ymov,x+xmov,y+ymov,deform)
					
					io.write_line(l)
				end
			end
			if syl.text~=" " and syl.text~="" then
				--outfade red pt2
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				u_out = 0
				
				max_frame = 23.976
				
				for s, e, i, n in utils.frames(line.start_time+syl.end_time, line.start_time+syl.end_time+500, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local x, y= syl.center - syl.width/2, syl.middle - syl.height/2
					
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
					
					if syl.i%2 == 0 then
						xmov = utils.interpolate(step, 0, -xrange)
						ymov = utils.interpolate(step, 0, -yrange)
						d1 = syl.right + 5
						d2 = syl.left - 5
					else
						xmov = utils.interpolate(step, 0, xrange)
						ymov = utils.interpolate(step, 0, yrange)
						d1 = syl.left - 5
						d2 = syl.right + 5
					end
					
					max=math.ceil(fad1/max_frame)
					if i>(n-math.ceil(fad1/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					l.text=string.format("{\\p4\\an7\\blur0.4\\bord0\\shad1\\fscx100\\fscy100\\alpha%s\\1c&H391B73&\\4c&HFFFFFF&\\clip(m %.3f %.3f l %.3f %.3f %.3f %.3f %.3f %.3f)\\pos(%.3f, %.3f)}%s"
					,alpha,xp1+xmov,yp1+ymov,xp2+xmov,yp2+ymov,d1+xmov, syl.bottom+ymov, d2+xmov, syl.bottom+ymov,x+xmov,y+ymov,deform)
					
					io.write_line(l)
				end
			end
			
			if syl.text~=" " and syl.text~="" then
				--outfade black pt1
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				u_out = 0
				
				max_frame = 23.976
				
				for s, e, i, n in utils.frames(line.start_time+syl.end_time, line.start_time+syl.end_time+500, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local x, y= syl.center - syl.width/2, syl.middle - syl.height/2
					
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
					
					if syl.i%2 == 0 then
						xmov = utils.interpolate(step, 0, -xrange)
						ymov = utils.interpolate(step, 0, -yrange)
						d1 = syl.right+5
						d2 = syl.left-5
					else
						xmov = utils.interpolate(step, 0, xrange)
						ymov = utils.interpolate(step, 0, -yrange)
						d1 = syl.left-5
						d2 = syl.right+5
					end
					
					max=math.ceil(fad2/max_frame)
					if i>(n-math.ceil(fad2/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					l.text=string.format("{\\p4\\an7\\blur0.4\\bord0\\shad1\\fscx100\\fscy100\\1c&H000000&\\alpha%s\\4c&HFFFFFF&\\clip(m %.3f %.3f l %.3f %.3f %.3f %.3f %.3f %.3f)\\pos(%.3f, %.3f)}%s"
					,alpha,xp1+xmov,yp1+ymov,xp2+xmov,yp2+ymov,d1+xmov, syl.bottom+ymov, d2+xmov, syl.bottom+ymov,x+xmov,y+ymov,deform)
					
					io.write_line(l)
				end
			end
			
			if syl.text~=" " and syl.text~="" then
				--outfade black pt2
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				u_out = 0
				
				max_frame = 23.976
				
				for s, e, i, n in utils.frames(line.start_time+syl.end_time, line.start_time+syl.end_time+500, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local x, y= syl.center - syl.width/2, syl.middle - syl.height/2
					
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
					
					if syl.i%2 == 0 then
						xmov = utils.interpolate(step, 0, xrange)
						ymov = utils.interpolate(step, 0, yrange)
						d1 = syl.left-5
						d2 = syl.right+5
					else
						xmov = utils.interpolate(step, 0, -xrange)
						ymov = utils.interpolate(step, 0, -yrange)
						d1 = syl.left-5
						d2 = syl.right+5
					end
					
					max=math.ceil(fad2/max_frame)
					if i>(n-math.ceil(fad2/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					l.text=string.format("{\\p4\\an7\\blur0.4\\bord0\\shad1\\fscx100\\fscy100\\alpha%s\\1c&H000000&\\4c&HFFFFFF&\\clip(m %.3f %.3f l %.3f %.3f %.3f %.3f %.3f %.3f)\\pos(%.3f, %.3f)}%s"
					,alpha,xp1+xmov,yp1+ymov,xp2+xmov,yp2+ymov,d1+xmov, syl.top+ymov, d2+xmov, syl.top+ymov,x+xmov,y+ymov,deform)
					
					io.write_line(l)
				end
			end
		end
	end
	if line.style == "OP_TL" then
		for ci,char in ipairs(line.chars) do
			
			if char.text~=" " and char.text~="" then
				--infade red
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+10*char.i-10
				l.end_time = line.end_time
				
				local x1, y1, x2, y2 = char.center - char.width/2, char.middle - char.height/2 - 15, char.center - char.width/2, char.middle - char.height/2
				
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
				
				l.text=string.format("{\\p4\\an7\\blur0.4\\bord0\\shad1\\fscx100\\fscy100\\1c&H391B73&\\4c&HFFFFFF&\\fad(50,250)\\move(%.3f, %.3f, %.3f, %.3f, 0, 100)}%s"
				,x1,y1,x2,y2,deform)
				
				io.write_line(l)
			end
			
			if char.text~=" " and char.text~="" then
				--infade black
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+10*char.i-10
				l.end_time = line.end_time
				
				local x1, y1, x2, y2 = char.center - char.width/2, char.middle - char.height/2 + 15, char.center - char.width/2, char.middle - char.height/2
				
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
				
				l.text=string.format("{\\p4\\an7\\blur0.4\\bord0\\shad1\\fscx100\\fscy100\\1c&H000000&\\4c&HFFFFFF&\\fad(50,250)\\move(%.3f, %.3f, %.3f, %.3f, 0, 100)}%s"
				,x1,y1,x2,y2,deform)
				
				io.write_line(l)
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	romanji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end