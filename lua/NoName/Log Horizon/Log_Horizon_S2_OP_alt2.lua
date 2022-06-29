--Log Horizon
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	
	line.infade = 150
	
	line.outfade = 150
	
	
	for ci,char in ipairs(line.chars) do
		local sx1, sy1 = char.left - math.randomsteps(7, 14, 5)-100, math.random(char.top - 25, char.bottom + 5)
		local sx2, sy2 = math.random(char.left-20, char.right+20), math.random(char.top-20, char.bottom+5)
		local sx3, sy3 = char.center + math.random(-20, 20), char.middle + math.random(-20, 5)
		local sx4, sy4 = char.left, char.top
		
		local ex1, ey1 = char.left, char.top
		local ex2, ey2 = math.random(char.left-20, char.right+20), math.random(char.top-20, char.bottom+5)
		local ex3, ey3 = char.center + math.random(-20, 20), char.middle + math.random(-20, 10)
		local ex4, ey4 = char.right + math.randomsteps(7, 15, 5)+50, char.middle + math.randomsteps(-16, 4, 2)
		
		if line.style == "OP_Romanji" then
			
			if char.text~="" and char.text~=" " then
				--char fx 1
				
				max_frame = 100
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local text_split = shape.split(text_shape, 10)
				local u_in, u_out, a = 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+15*char.i, line.end_time+15*char.i-line.outfade, max_frame) do
					
					l.start_time = s
					l.end_time = e + 250
					
					l.layer = 2
					
					local step = i / n
					
					local sc = 100
					
					local dir = math.sin(math.rad(a))
					a = a + math.randomsteps(15,90,15)
					
					local deform = shape.filter(text_split,
					function(x,y)
						local xdef = math.randomsteps(-10,10,1)
						local ydef = math.randomsteps(-10,10,0.5)
						return x+xdef, y+ydef
					end)
					
					local infad, outfad = 250, 250
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						spoint = math.bezier(u_in/inmax,
						{
						{sx1, sy1},
						{sx2, sy2},
						{sx3, sy3},
						{sx4, sy4}
						}
						)
						x, y = spoint[1] , spoint[2]
						sc = 100
						u_in = u_in + 1
					elseif s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
						sc = 100 + 5*math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration*math.pi), 1,45)))
						x, y = char.left + math.random(-2, 2), char.top + math.random(-2, 2) + math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration*math.pi), 1,45)))*3
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						epoint = math.bezier(u_out/outmax,
						{
						{ex1, ey1},
						{ex2, ey2},
						{ex3, ey3},
						{ex4, ey4}
						}
						)
						x, y = epoint[1] , epoint[2]
						sc = 100
						u_out = u_out + 1
					else
						x, y = char.left, char.top
						sc = 100
						alpha="&H00&"
					end
					
					local xpos, ypos = x, y
					local xmov, ymov = xpos + dir, ypos + dir
					
					local primary_color_array = {"&HE82310&" , "&HF09873&"}
					local random_primary_color=primary_color_array[math.random(1,table.getn(primary_color_array))]
					
					local secondary_color_array = { "&HFCFCFC&" , "&HFFA688&"}
					local random_secondary_color=secondary_color_array[math.random(1,table.getn(secondary_color_array))]
					
					l.text = string.format("{\\an7\\p4\\blur1.2\\bord2\\fscx%d\\fscy%d\\1c&%s\\3c%s\\fad(0,250)\\1a&H96&\\3a&H32&\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,sc,sc,random_primary_color,random_secondary_color,xpos,ypos,xmov,ymov,deform)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" and char.text~=" " then
				--char fx 2
				
				max_frame = 25
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local text_outline = shape.tooutline(text_shape, 8)
				local text_split = shape.split(text_outline, 15)
				
				local u_in, u_out = 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+15*char.i, line.end_time+15*char.i-line.outfade, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 3
					
					local step = i / n
					
					local infad, outfad = 250, 250
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						deform = text_outline
						x, y = spoint[1] , spoint[2]
						sc = 100
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						deform = text_outline
						x, y = epoint[1] , epoint[2]
						sc = 100
						u_out = u_out + 1	
					elseif s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
						deform = shape.filter(text_split,
						function(x,y)
							local xdef = math.randomsteps(-5,5,2.5)
							local ydef = math.randomsteps(-5,5,1.25)
							return x+xdef, y+ydef
						end)
						sc = 100 + 5*math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration*math.pi), 1,45)))
						local shift1, shift2 = math.random(-2, 2), math.random(-2, 2)
						x, y = char.left + shift1, char.top + shift2 + math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration*math.pi), 1,45)))*3
						alpha="&H00&"
					else
						deform = text_outline
						alpha="&H00&"
						sc = 100
						x, y = char.left, char.top
					end
					
					l.text = string.format("{\\an7\\p4\\blur0.4\\bord0\\fscx%.3f\\fscy%.3f\\alpha&H32&\\1c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,sc,sc,x,y,deform)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" and char.text~=" " then
				--char fx 3
				
				max_frame = 25
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local text_outline = shape.tooutline(text_shape, 12)
				local text_split = shape.split(text_outline, 15)
				
				local u_in, u_out = 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+15*char.i, line.end_time+15*char.i-line.outfade, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 1
					
					local step = i / n
					
					local infad, outfad = 250, 250
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						deform = text_outline
						x, y = spoint[1] , spoint[2]
						sc = 100
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						deform = text_outline
						x, y = epoint[1] , epoint[2]
						sc = 100
						u_out = u_out + 1
					elseif s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
						deform = shape.filter(text_split,
						function(x,y)
							local xdef = math.randomsteps(-5,5,2.5)
							local ydef = math.randomsteps(-5,5,1.25)
							return x+xdef, y+ydef
						end)
						sc = 100 + 5*math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration*math.pi), 1,45)))
						local shift1, shift2 = math.random(-2, 2), math.random(-2, 2)
						x, y = char.left + shift1, char.top + shift2 + math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration*math.pi), 1,45)))*3
						alpha="&H00&"
					else
						sc = 100
						deform = text_outline
						alpha="&H00&"
						x, y = char.left, char.top
					end
					
					l.text = string.format("{\\an7\\p4\\blur0.4\\bord6\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&H000000&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
					,sc,sc,alpha,x,y,deform)
					
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