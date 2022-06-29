--Hunter X Hunter: The Last Mission Combat effects
--Effects by Amberdrake
--VSFilter

function cfx(line, l)
	
	line.infade = 0
	line.outfade = 0
	
	if line.style == "CFX_On" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" and syl.text~=" " then
				--On text fx
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local tlx, tly, brx, bry = shape.bounding(text_shape)
				
				local max_frame = 23.976
				
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
							local vx, vy = x + xc, y + yc
							local xdef, ydef = utils.interpolate(u_in/inmax, math.random(-40, 40), 0), utils.interpolate(u_in/inmax, math.random(-40, 40), 0)
							return x+xdef, y+ydef
						end)
						u_in = u_in + 1
					elseif s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
						sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2
						deform = shape.filter(text_shape,
						function(x,y)
							local vx, vy = x - xc, y - yc
							xdef = utils.interpolate((s - (line.start_time + syl.start_time))/syl.duration, 0.2*vx, 0) + 10*math.sin(math.rad(a+10*x)) + math.randomsteps(-20, 20, 2.5)
							ydef = utils.interpolate((s - (line.start_time + syl.start_time))/syl.duration, 0.3*vy, 0) + 10*math.sin(math.rad(a+10*y)) + math.randomsteps(-20, 20, 2.5)
							return x+xdef, y+ydef
						end)
						a = a + 15
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2
						deform = shape.filter(text_shape,
						function(x,y)
							local vx, vy = x - xc, y - yc
							local xdef, ydef = utils.interpolate(u_out/outmax, 0, math.random(math.abs(vx), 2*math.abs(vx))), utils.interpolate(u_out/outmax, 0, math.random(math.abs(vy), 2*math.abs(vy)))
							return x+xdef, y+ydef
						end)
						u_out = u_out + 1
					else
						sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2
						deform = text_shape
						alpha="&H00&"
					end
					
					l.text = string.format("{\\p4\\an7\\blur3\\bord3\\shad0\\fscx100\\fscy100\\alpha%s\\1c&H000000&\\3c&HFF6373&\\pos(%.3f, %.3f)}%s"
					,alpha,sx,sy,deform)
					
					io.write_line(l)
				end
			end
		end
	end
	
	if line.style == "CFX_Netero" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" and char.text~=" " then
				--Netero text fx1
				
				local max_frame = 100
				
				local u_in, u_out = 0, 0
				
				for s, e, i, n in utils.frames(line.start_time+50*char.i-550, line.end_time+50*char.i, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e + 500
					
					local step = i / n
					
					local infad, outfad = 500, 500
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					local a = 0
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						sx, sy = utils.interpolate(u_in/inmax, char.left - 10, char.center), char.middle
						sc = 100
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						sx, sy = utils.interpolate(u_out/outmax, char.center, char.right + 10), char.middle
						sc = 100
						u_out = u_out + 1
					else
						sx, sy = char.center, char.middle
						alpha="&H00&"
					end
					
					l.text = string.format("{\\an5\\blur0.6\\bord2\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&H7FE0E2&\\3c&H000000&\\fad(0,500)\\pos(%.3f, %.3f)}%s"
					,sc,sc,alpha,sx,sy,char.text)
					
					io.write_line(l)
				end
				
			end
		end
	end
	
	if line.style == "CFX_Kurapika" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" and char.text~=" " then
				--Kurapika text fx
				
				local max_frame = 23.976
				
				local u_in, u_out = 0, 0
				
				local sx1, sy1 = char.left - math.randomsteps(15, 30, 5), math.random(char.top - 5, char.bottom + 5)
				local sx2, sy2 = math.random(char.left-40, char.right+40), math.random(char.top-35, char.bottom+40)
				local sx3, sy3 = char.center + math.random(-40, 40), char.middle + math.random(-35, 40)
				local sx4, sy4 = char.center, char.middle
				
				local fx1, fy1 = char.center, char.middle
				local fx2, fy2 = math.random(char.left, char.right), math.random(char.top, char.bottom)
				local fx3, fy3 = math.randomsteps(char.left, char.right, 0.5), math.randomsteps(char.top, char.bottom, 0.5)
				local fx4, fy4 = char.center, char.middle
				
				local ex1, ey1 = char.center, char.middle
				local ex2, ey2 = math.random(char.left-40, char.right+40), math.random(char.top-35, char.bottom+40)
				local ex3, ey3 = char.center + math.random(-40, 40), char.middle + math.random(-35, 40)
				local ex4, ey4 = char.right + math.randomsteps(15, 30, 5), char.middle + math.randomsteps(-15, 15, 5)
				
				for s, e, i, n in utils.frames(line.start_time+50*char.i-600, line.end_time+50*char.i+550, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local infad, outfad = 550, 550
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						local spoint = math.bezier(u_in/inmax,
						{
						{sx1, sy1},
						{sx2, sy2},
						{sx3, sy3},
						{sx4, sy4}
						}
						)
						x, y = spoint[1] , spoint[2]
						u_in = u_in + 1
					elseif s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
						alpha="&H00&"
						local fxpoint = math.bezier((s - (line.start_time + char.start_time))/char.duration,
						{
						{fx1, fy1},
						{fx2, fy2},
						{fx3, fy3},
						{fx4, fy4}
						}
						)
						x, y = fxpoint[1] , fxpoint[2]
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						local epoint = math.bezier(u_out/outmax,
						{
						{ex1, ey1},
						{ex2, ey2},
						{ex3, ey3},
						{ex4, ey4}
						}
						)
						x, y = epoint[1] , epoint[2]
						u_out = u_out + 1
					else
						alpha="&H00&"
						x, y = char.center, char.middle
					end
					
					l.text = string.format("{\\an3\\blur3\\bord3\\shad0\\fscx100\\fscy100\\alpha%s\\1c&H66EBFF&\\3c&H3911BB&\\pos(%.3f, %.3f)}%s"
					,alpha,x,y,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" and char.i==1 then
				--Kurapika chain fx
				
				local chain1 = shape.ring(10, 7)
				local chain2 = shape.ellipse(20, 10)
				
				local chain_dist = utils.distributor({chain1, chain2})
				
				local max_frame = 60
				
				local x1, y1 = line.left - 30, line.top
				local x2, y2 = line.left+line.width/3, line.bottom + 50
				local x3, y3 = line.right-line.width/3, line.top - 50
				local x4, y4 = line.right + 30, line.bottom
				
				for s, e, i, n in utils.frames(line.start_time-250, line.end_time+250, max_frame) do
					
					l.layer = math.random(4,7)
					
					l.start_time = s
					l.end_time = line.end_time+250
					
					local step = i / n
					
					local point = math.bezier(step,
					{
					{x1, y1},
					{x2, y2},
					{x3, y3},
					{x4, y4}
					}
					)
					x, y = point[1] , point[2]
					
					local chain = chain_dist:get()
					
					l.text = string.format("{\\p1\\an5\\blur3\\bord1\\shad0\\fscx100\\fscy100\\1c&HCAD1D3&\\3c&HABE8A5&\\pos(%.3f, %.3f)}%s"
					,x,y,chain)
					
					io.write_line(l)
				end
			end
		end
	end
	
	if line.style == "CFX_Gon" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" and char.text~=" " then
				--Gon text fx
				local max_frame = 23.976
				
				local u_in, u_out = 0, 0
				
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-150, line.end_time+150, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local infad, outfad = 150, 150
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					local a = 0
					
					if i < math.ceil(infad/max_frame) then
						l.layer = 5
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						scx, scy = 90, 80
						sx, sy = utils.interpolate(u_in/inmax, char.center + math.randomsteps(-20, 20, 5), char.center), utils.interpolate(u_in/inmax, char.middle + math.randomsteps(-20, 20, 5), char.middle)
						u_in = u_in + 1
					elseif s > (line.start_time+char.start_time) and s < (line.start_time + char.start_time + char.duration) then
						l.layer = 6
						scx, scy = 120 + 30*math.sin(math.rad(a)) + math.randomsteps(-10, 10, 5), 120 + 30*math.sin(math.rad(a)) + math.randomsteps(-10, 10, 2.5)
						sx, sy = char.center + math.random(-3, 3), char.middle + math.random(-3, 3)
						a = a + 90
					elseif i > (n-math.ceil(outfad/max_frame)) then
						l.layer = 5
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						scx, scy = 90, 80
						sx, sy = utils.interpolate(u_out/outmax, char.center, char.center + math.randomsteps(-20, 20, 5)), utils.interpolate(u_out/outmax, char.middle, char.middle + math.randomsteps(-20, 20, 5))
						u_out = u_out + 1
					else
						l.layer = 5
						scx, scy = 90, 80
						sx, sy = char.center, char.middle
						alpha="&H00&"
					end
					
					l.text = string.format("{\\an5\\blur0.8\\bord3\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&H3F7637&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
					,scx,scy,alpha,sx,sy,char.text)
					
					io.write_line(l)
				end
				
			end
		end
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" and syl.text~=" " then
				--Gon aura fx
				
				local max_frame = 23.976
				
				local u_in, u_out = 0, 0
				
				local a = 0
				
				local infad, outfad = 100, 150
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local aura = shape.star(math.random(20,30), syl.width/2 + 10 + math.random(-3,3), syl.width/2 + 10 + math.random(-2,2))
					
					local sc = 100 + 5*math.sin(math.rad(a))
					
					local x, y = syl.center, syl.middle
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						u_out = u_out + 1
					else
						alpha="&H00&"
					end
					
					local deform = shape.filter(aura,
					function(x,y)
						local xdef, ydef = math.random(-3,3), math.random(-3, 3)
						return x+xdef, y+ydef
					end)
					
					l.text = string.format("{\\p1\\an5\\blur4\\bord5\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&HFFFFFF&\\3c&H9DFFFA&\\pos(%.3f, %.3f)}%s"
					,sc,sc,alpha,x,y,deform)
					
					io.write_line(l)
					
					a = a + 15
				end
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	cfx( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end