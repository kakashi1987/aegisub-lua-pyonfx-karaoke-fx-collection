--Fate/kaleid liner PRISMA ILLYA OP
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 250
	line.outfade = 250
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" and syl.text~=" " and syl.text~="　" then
			text_shape = convert.text_to_shape(syl.text, line.styleref)
			tlx, tly, brx, bry = shape.bounding(text_shape)
			xc, yc = (tlx+brx)/2, (tly+bry)/2
			text_split = shape.split(text_shape, 1)
			text_outline = shape.tooutline(text_split, 2)
		end
		
		if syl.text~=" " then
			--stars infade effect
			
			max_frame = 25
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time+line.infade, max_frame) do
				
				local star = shape.star(4, 2, 6)
				
				rs = math.randomsteps(0,line.infade,50)
				
				l.start_time = s + rs
				l.end_time = e + rs + line.infade
				
				l.layer = 8
				
				step = i / n
				
				bord = 3*math.sin(math.rad(utils.interpolate(step, 90, 180)))
				sc = utils.interpolate(step, 80, 60)
				
				x = math.random(line.left, line.right)
				y = math.random(line.top, line.bottom)+5
				
				l.text = string.format("{\\an5\\p1\\blur3\\bord%d\\shad0\\fscx%d\\fscy%d\\fad(0,100)\\3a&H64&\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,bord,sc,sc,x,y,star)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			--text infade
			
			l.layer = 5
			
			l.start_time = line.start_time-line.infade
			l.end_time = line.start_time+syl.start_time
			
			l.text = string.format("{\\an7\\p4\\bord2\\blur1.5\\shad0\\fscx100\\fscy100\\fad(250,0)\\1c&HAF1FEC&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
			,syl.left,syl.top,text_shape)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--syl_fx 1
			
			local max_frame = 25
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				l.layer = 5
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				local deform = shape.filter(text_shape,
				function(x,y)
					local xdef = 0
					local min_x, max_x = tlx, brx
					local vy = (y - yc)*0.5
					if y >= yc then
						ydef = vy*math.sin(math.pi*(x/max_x))*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					end
					if y < yc then
						ydef = vy*math.sin(math.pi*(x/max_x))*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					end
					
					return x+xdef, y+ydef
				end
				)
				
				l.text = string.format("{\\an7\\p4\\bord2\\blur1.5\\shad0\\fscx100\\fscy100\\1c&HAF1FEC&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,syl.left,syl.top,deform)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			--text outfade
			
			l.layer = 5
			
			l.start_time = line.start_time+syl.end_time
			l.end_time = line.end_time+line.outfade
			
			l.text = string.format("{\\an7\\p4\\bord2\\blur1.5\\shad0\\fscx100\\fscy100\\fad(0,250)\\1c&HAF1FEC&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
			,syl.left,syl.top,text_shape)
			
			io.write_line(l)
		end
		
		if syl.text~="" and syl.text~=" " and syl.text~="　" then
			--outline infade
			
			l.layer = 10
			
			l.start_time = line.start_time-line.infade
			l.end_time = line.start_time+syl.start_time
			
			l.text = string.format("{\\an7\\p4\\bord0.2\\blur1.3\\shad0\\fscx100\\fscy100\\1c&H000000&\\fad(250,0)\\pos(%.3f, %.3f)}%s"
			,syl.left,syl.top,text_outline)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--outline_fx 1
			
			local max_frame = 25
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				l.layer = 10
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				local outline_deform = shape.filter(text_outline,
				function(x,y)
					local xdef = 0
					local min_x, max_x = tlx, brx
					local vy = (y - yc)*0.5
					if y >= yc then
						ydef = vy*math.sin(math.pi*(x/max_x))*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					end
					if y < yc then
						ydef = vy*math.sin(math.pi*(x/max_x))*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					end
					
					return x+xdef, y+ydef
				end
				)
				
				l.text = string.format("{\\an7\\p4\\bord0.2\\blur1.3\\shad0\\fscx100\\fscy100\\1c&H000000&\\pos(%.3f, %.3f)}%s"
				,syl.left,syl.top,outline_deform)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			--outline_fx 2
			
			local max_frame = 100
			local u_in, u_out = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				l.layer = 1
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				local infad, outfad = syl.duration/3, syl.duration/3
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				
				local outline_deform = shape.filter(text_shape,
				function(x,y)
					local min_x, max_x = tlx, brx
					local min_y, max_y = tly, bry
					local vx, vy = (x - xc)*0.75, (y - yc)*2
					if x >= xc then
						xdef = vx*math.sin(math.pi*(y/max_y))*math.sin(math.rad(utils.interpolate(step, 90, 0)))
					end
					if x < xc then
						xdef = vx*math.sin(math.pi*(y/max_y))*math.sin(math.rad(utils.interpolate(step, 90, 0)))
					end
					if y >= yc then
						ydef = vy*math.sin(math.pi*(x/max_x))*math.sin(math.rad(utils.interpolate(step, 90, 0)))
					end
					if y < yc then
						ydef = vy*math.sin(math.pi*(x/max_x))*math.sin(math.rad(utils.interpolate(step, 90, 0)))
					end
					
					return x+xdef, y+ydef
				end
				)
				
				local blur = utils.interpolate(step, 5, 1.5)
				
				if i < math.ceil(infad/max_frame) then
					alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
					u_in = u_in + 1
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					u_out = u_out + 1
				else
					alpha="&H00&"
				end
				
				l.text = string.format("{\\an7\\p4\\bord0\\blur%2f\\shad0\\fscx100\\fscy100\\alpha%s\\1c&HAF1FEC&\\pos(%.3f, %.3f)}%s"
				,blur,alpha,syl.left,syl.top,outline_deform)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.text~=" " and syl.text~="　" then
			--outline fx3
			
			l.layer = 1
			
			l.start_time = line.start_time+syl.end_time
			l.end_time = line.end_time+line.outfade
			
			l.text = string.format("{\\an5\\bord3\\blur2.5\\shad0\\fscx100\\fscy100\\1c&HAF1FEC&\\3c&HAF1FEC&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" and syl.text~=" " and syl.text~="　" then
			--outline outfade
			
			l.layer = 10
			
			l.start_time = line.start_time+syl.end_time
			l.end_time = line.end_time+line.outfade
			
			l.text = string.format("{\\an7\\p4\\bord0.2\\blur1.3\\shad0\\fscx100\\fscy100\\1c&H000000&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
			,syl.left,syl.top,text_outline)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--syl_fx 2
			
			local maxj = syl.duration/5
			for j = 1, maxj, 1 do
				
				local max_frame = math.randomsteps(150,250,50)
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local deform = shape.filter(text_shape,
					function(x,y)
						local xdef = 0
						local min_x, max_x = tlx, brx
						local vy = (y - yc)*0.5
						if y >= yc then
							ydef = vy*math.sin(math.pi*(x/max_x))*math.sin(math.rad(utils.interpolate(step, 0, 180)))
						end
						if y < yc then
							ydef = vy*math.sin(math.pi*(x/max_x))*math.sin(math.rad(utils.interpolate(step, 0, 180)))
						end
						
						return x+xdef, y+ydef
					end
					)
					
					local clip_fix = shape.filter(deform,
					function(x,y)
						local x, y = x/8, y/8
						return x,y
					end
					)
					
					local star = shape.star(4, 3, 6)
					
					local clip = shape.move(clip_fix, syl.left, syl.top)
					
					l.layer = math.random(7,9)
					
					local x, y = math.random(syl.left, syl.right), math.random(syl.top, syl.bottom)
					
					local color_array = {"&H0000FF&" , "&HFF0000&" , "&H00FF00&", "&HFFFF00&" , "&HFF00FF&", "&H0000FF&" }
					local color = color_array[math.random(1,table.getn(color_array))]
					
					l.text = string.format("{\\an7\\p1\\bord3\\blur2\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c%s\\fad(%d,%d)\\clip(%s)\\pos(%.3f, %.3f)}%s"
					,color,max_frame/2,max_frame/2,clip,x,y,star)
					
					io.write_line(l)
				end
			end
		end
		
		if syl.text~=" " then
			--stars outfade effect
			
			max_frame = 25
			
			for s, e, i, n in utils.frames(line.end_time-line.outfade, line.end_time+line.outfade, max_frame) do
				
				local star = shape.star(4, 2, 6)
				
				rs = math.randomsteps(0,line.outfade,50)
				
				l.start_time = s + rs
				l.end_time = e + rs + line.outfade
				
				l.layer = 8
				
				step = i / n
				
				bord = 3*math.sin(math.rad(utils.interpolate(step, 90, 180)))
				sc = utils.interpolate(step, 80, 60)
				
				x = math.random(line.left, line.right)
				y = math.random(line.top, line.bottom)+5
				
				l.text = string.format("{\\an5\\p1\\blur3\\bord%d\\shad0\\fscx%d\\fscy%d\\fad(0,100)\\3a&H64&\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,bord,sc,sc,x,y,star)
				
				io.write_line(l)
			end
		end
	end
	
	local x_shift_dist, y_shift_dist = utils.distributor({15, -15, -15, 15}), utils.distributor({-15, 15, 15, -15})
	
	for ci,char in ipairs(line.chars) do
		
		local x_shift, y_shift = x_shift_dist:get(), y_shift_dist:get()
		local x, y = char.center + x_shift, char.middle + y_shift
		
		if char.text~="" and char.text~=" " and char.text~="　" then
			char_shape = convert.text_to_shape(char.text, line.styleref)
			tlx, tly, brx, bry = shape.bounding(text_shape)
			xc, yc = (tlx+brx)/2, (tly+bry)/2
		end
		
		if char.text~="" and char.text~=" " and char.text~="　" then
			--masking infade
			
			l.layer = 6
			
			l.start_time = line.start_time-line.infade
			l.end_time = line.start_time+char.start_time
			
			local clip_fix = shape.filter(char_shape,
			function(x,y)
				local x = x/8
				local y = y/8
				return x, y
			end
			)
			
			local clip = shape.move(clip_fix, char.left, char.top)
			
			local circle = shape.ellipse(35,35)
			
			l.text = string.format("{\\an5\\p1\\bord0\\blur3\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\fad(250,0)\\clip(%s)\\pos(%.3f, %.3f)}%s"
			,clip,x,y,circle)
			
			io.write_line(l)
		end
		
		if char.text~="" and char.text~=" " and char.text~="　" then
			--masking outfade
			
			l.layer = 6
			
			l.start_time = line.start_time+char.end_time
			l.end_time = line.end_time+line.outfade
			
			local clip_fix = shape.filter(char_shape,
			function(x,y)
				local x = x/8
				local y = y/8
				return x, y
			end
			)
			
			local clip = shape.move(clip_fix, char.left, char.top)
			
			local circle = shape.ellipse(35,35)
			
			l.text = string.format("{\\an5\\p1\\bord0\\blur3\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\fad(0,250)\\clip(%s)\\pos(%.3f, %.3f)}%s"
			,clip,x,y,circle)
			
			io.write_line(l)
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end