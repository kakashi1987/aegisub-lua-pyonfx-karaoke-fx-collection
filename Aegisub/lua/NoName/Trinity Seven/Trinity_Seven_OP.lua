--Trinity Seven OP
--Effects by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 250
	line.outfade = 250
	
	for ci,char in ipairs(line.chars) do
		
		if char.text~="" then
			
			if char.text~="" and char.text~=" " then
				--static text effect
				
				local ln = shape.rectangle(line.width, 1)
				
				local max_frame = 23.976
				local a, b = 0, 0
				local u_out = 0
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local tlx, tly, brx, bry = shape.bounding(text_shape)
				
				for s, e, i, n in utils.frames(line.start_time - line.infade, line.end_time + line.outfade, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					
					local step = i / n
					
					local fad = 150
					local max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						x, y = char.left, char.top
						sc = 100
						l.end_time = e
						fade = 0
						u_out=u_out+1
					elseif s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
						x, y = char.left + math.randomsteps(-1.5, 1.5, 0.25), char.top + math.randomsteps(-1.5, 1.5, 0.25)
						sc = 105 + 5*math.sin(math.rad(a))
						l.end_time = e + 100
						fade = 100
						a = a + math.randomsteps(30, 90, 15)
					else
						x, y = char.left, char.top
						sc = 100
						l.end_time = e
						fade = 0
					end
					
					if char.text == "T" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == brx then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "i" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local x = x + 0
							
							if y == bry then
								y = y + b
							else
								y = y
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "k" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local x = x + 0
							
							if y == tly then
								y = y + b
							else
								y = y
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "l" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local x = x + 0
							
							if y == tly then
								y = y + b
							else
								y = y
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "d" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local x = x + 0
							
							if y == tly then
								y = y + b
							else
								y = y
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "b" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local x = x + 0
							
							if y == tly then
								y = y + b
							else
								y = y
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "n" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local x = x + 0
							
							if y == bry and x > (tlx+brx)/2 then
								y = y + b
							else
								y = y
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "君" then
						if line.style == "OP_kanji_L" then
							deform = shape.filter(text_shape,
							function(x,y)
								
								local y = y + 0
								
								if x == brx and y < (tlx+brx)/2 then
									x = x + b
								else
									x = x
								end
								
								b = b + 0.03
								return x, y
							end)
						else
							deform = text_shape
						end
					elseif char.text == "音" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x >= brx - 4 then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "扉" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x >= brx - 2 and y < (tlx+brx)/2 then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "こ" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x <= tlx + 10 and y < (tlx+brx)/2 then
								x = x + b
							else
								x = x
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "僕" then
						if line.style == "OP_Kanji_L" then
							deform = shape.filter(text_shape,
							function(x,y)
								
								local y = y + 0
								
								if x >= brx - 8 and y < (tlx+brx)/2 then
									x = x + b
								else
									x = x
								end
								
								b = b + 0.03
								return x, y
							end)
						end
						if line.style == "OP_Kanji_R" then
							deform = text_shape
						end
					elseif char.text == "行" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x >= brx - 3 then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "実" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x <= tlx + 5 and y < bry - 10 then
								x = x + b
							else
								x = x
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "秩" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x >= brx - 15 and y < (tly+bry)/2 then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "可" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == brx then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "性" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == brx then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "雨" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == brx then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "奥" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x <= tlx + 2 and y < bry - 20 then
								x = x + b
							else
								x = x
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "真" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == tlx and y < bry - 10 then
								x = x + b
							else
								x = x
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "対" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == brx then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "手" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == tlx then
								x = x + b
							else
								x = x
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "敵" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == tlx then
								x = x + b
							else
								x = x
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "黒" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == brx and y < bry - 10 then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "太" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == brx - 5 and y < (tly+bry)/2 then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "陽" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == brx then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "世" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == tlx then
								x = x + b
							else
								x = x
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "す" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x == tlx then
								x = x + b
							else
								x = x
							end
							
							b = b - 0.03
							return x, y
						end)
					elseif char.text == "変" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x >= brx - 15 and y < tly + 30 then
								x = x + b
							else
								x = x
							end
							
							b = b + 0.03
							return x, y
						end)
					elseif char.text == "運" then
						deform = shape.filter(text_shape,
						function(x,y)
							
							local y = y + 0
							
							if x <= tlx + 8 and y < (tly+bry)/2 and y > tly + 20  then
								x = x + b
							else
								x = x
							end
							
							b = b - 0.03
							return x, y
						end)
					else
						deform = text_shape
					end
					
					l.text=string.format("{\\p4\\an7\\bord0.2\\shad0\\blur3\\fscx%.3f\\fscy%.3f\\1c&HFFFFFF&\\3c&H000000&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
					,sc,sc,fade,x,y,deform)
					
					io.write_line(l)
				end
			end
		end
		
		if line.style == "OP_Romaji_L" then
			if char.text~="" and char.i == 1 then
				--romaji L line effect
				
				local ln = shape.rectangle(line.width, 1)
				
				local max_frame = 23.976
				local a = 0
				local u_out = 0
				
				for s, e, i, n in utils.frames(line.start_time - line.infade, line.end_time + line.outfade, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local x, y = lines[line.i].chars[1].right-30, line.bottom + 3
					
					local scx = 100 + a
					a = a + 0.05
					
					l.text=string.format("{\\p1\\an7\\bord0.2\\shad0\\blur3\\fscx%.3f\\fscy100\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
					,scx,x,y,ln)
					
					io.write_line(l)
				end
			end
		end
		
		if line.style == "OP_Romaji_R" then
			if char.text~="" and char.i == 1 then
				--romaji R line effect
				
				local ln = shape.rectangle(line.width, 1)
				
				local max_frame = 23.976
				local a = 0
				local u_out = 0
				
				for s, e, i, n in utils.frames(line.start_time - line.infade, line.end_time + line.outfade, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local x, y = lines[line.i].chars[#line.chars].right+30, line.bottom + 3
					
					local scx = 100 + a
					a = a + 0.03
					
					l.text=string.format("{\\p1\\an9\\bord0.2\\shad0\\blur3\\fscx%.3f\\fscy100\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
					,scx,x,y,ln)
					
					io.write_line(l)
				end
			end
		end
		
		if line.style == "OP_Kanji_L" then
			if char.text~="" and char.i == 1 then
				--kanji L line effect
				
				local ln = shape.rectangle(1, line.width + (line.width/3) + 50)
				
				local max_frame = 23.976
				local a = 0
				local u_out = 0
				
				for s, e, i, n in utils.frames(line.start_time - line.infade, line.end_time + line.outfade, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local x, y = line.left + 30, lines[line.i].chars[#line.chars].bottom + 50
					
					local scy = 100 + a
					a = a + 0.03
					
					l.text=string.format("{\\p1\\an1\\bord0.2\\shad0\\blur3\\fscx100\\fscy%.3f\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
					,scy,x,y,ln)
					
					io.write_line(l)
				end
			end
		end
		
		if line.style == "OP_Kanji_R" then
			if char.text~="" and char.i == 1 then
				--kanji R line effect
				
				local ln = shape.rectangle(1, line.width + (line.width/3) + 50)
				
				local max_frame = 23.976
				local a = 0
				local u_out = 0
				
				for s, e, i, n in utils.frames(line.start_time - line.infade, line.end_time + line.outfade, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local x, y = line.right - 30, lines[line.i].chars[#line.chars].bottom + 50
					
					local scy = 100 + a
					a = a + 0.03
					
					l.text=string.format("{\\p1\\an3\\bord0.2\\shad0\\blur3\\fscx100\\fscy%.3f\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
					,scy,x,y,ln)
					
					io.write_line(l)
				end
			end
		end
		
		if line.style == "OP_Romaji_L" or line.style == "OP_Romaji_R" then
			if char.text~="" and char.i == 1 then
				--Left romaji rectangles effect
				
				local rw, rh = math.randomsteps(8, 12, 2), math.randomsteps(14, 20, 2)
				local rect = shape.rectangle(rw, rh)
				local align = math.randomsteps(2, 8, 6)
				local maxj = math.random(3,4)
				
				if line.style == "OP_Romaji_L" then
					if align == 2 then
						rp = line.left + 10
						mod = -1
					else
						thr1 = line.left
						thr2 = line.left + 50
						mod = math.randomsteps(-1, 1, 2)
						rp = math.randomsteps(thr1, thr2, 10)
					end
				end
				if line.style == "OP_Romaji_R" then
					if align == 2 then
						rp = line.left - 10
						mod = - 1
					else
						thr1 = line.left - 30
						thr2 = line.left
						rp = math.randomsteps(thr1, thr2, 10)
						mod = math.randomsteps(-1, 1, 2)
					end
				end
				
				local max_frame = 100
				local u_out = 0
				
				for j = 1, maxj, 1 do
					for s, e, i, n in utils.frames(line.start_time - line.infade + 100*j, line.end_time + line.outfade, max_frame) do
						
						l.layer = 2
						
						l.start_time = s
						l.end_time = e
						
						local fad = 200
						local max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							local alpha_dist = utils.distributor({"&HFF&" , "&H00&"})
							alpha = alpha_dist:get()
						else
							alpha="&H00&"
						end
						
						local x, y = rp +mod*(rw+(rw/3))*j, line.bottom + 4
						
						l.text=string.format("{\\p1\\an%d\\bord0.2\\shad0\\blur3\\fscx100\\fscy100\\alpha%s\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
						,align,alpha,x,y,rect)
						
						io.write_line(l)
					end
				end
			end
		end
		
		if line.style == "OP_Romaji_L" or line.style == "OP_Romaji_R" then
			if char.text~="" and char.i == 1 then
				--Right romaji rectangles effect
				
				local rw, rh = math.randomsteps(6, 10, 2), math.randomsteps(13, 16, 2)
				local rect = shape.rectangle(rw, rh)
				local align = math.randomsteps(2, 8, 6)
				local maxj = math.random(3,5)
				
				if line.style == "OP_Romaji_L" then
					if align == 2 then
						rp = line.right + 10
						mod = 1
					else
						thr1 = line.right
						thr2 = line.right + 30
						rp = math.randomsteps(thr1, thr2, 10)
						mod = math.randomsteps(-1, 1, 2)
					end
				end
				if line.style == "OP_Romaji_R" then
					if align == 2 then
						rp = line.right - 10
						mod = 1
					else
						thr1 = line.right - 60
						thr2 = line.right
						rp = math.randomsteps(thr1, thr2, 10)
						mod = 1
					end
				end
				
				local max_frame = 100
				local u_out = 0
				
				for j = 1, maxj, 1 do
					for s, e, i, n in utils.frames(line.start_time - line.infade + 100*j, line.end_time + line.outfade, max_frame) do
						
						l.layer = 2
						
						l.start_time = s
						l.end_time = e
						
						local fad = 200
						local max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							local alpha_dist = utils.distributor({"&HFF&" , "&H00&"})
							alpha = alpha_dist:get()
						else
							alpha="&H00&"
						end
						
						local x, y = rp +mod*(rw+(rw/3))*j, line.bottom + 4
						
						l.text=string.format("{\\p1\\an%d\\bord0.2\\shad0\\blur3\\fscx100\\fscy100\\alpha%s\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
						,align,alpha,x,y,rect)
						
						io.write_line(l)
					end
				end
			end
		end
		
		if line.style == "OP_Kanji_L" or line.style == "OP_Kanji_R" then
			if char.text~="" and char.i == 1 then
				--Top kanji rectangles effect
				
				local rw, rh = math.randomsteps(8, 14, 2), math.randomsteps(6, 10, 2)
				local rect = shape.rectangle(rw, rh)
				local align = math.randomsteps(4, 6, 2)
				local maxj = math.random(3,4)
				
				local max_frame = 100
				local u_out = 0
				
				if line.style == "OP_Kanji_L" then
					xpos = 50
				end
				if line.style == "OP_Kanji_R" then
					xpos = 1230
				end
				
				for j = 1, maxj, 1 do
					for s, e, i, n in utils.frames(line.start_time - line.infade + 100*j, line.end_time + line.outfade, max_frame) do
						
						l.layer = 2
						
						l.start_time = s
						l.end_time = e
						
						local fad = 200
						local max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							local alpha_dist = utils.distributor({"&HFF&" , "&H00&"})
							alpha = alpha_dist:get()
						else
							alpha="&H00&"
						end
						
						local x, y = xpos, lines[line.i].chars[1].top - (rh+(rh/3))*j
						
						l.text=string.format("{\\p1\\an%d\\bord0.2\\shad0\\blur3\\fscx100\\fscy100\\alpha%s\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
						,align,alpha,x,y,rect)
						
						io.write_line(l)
					end
				end
			end
		end
		
		if line.style == "OP_Kanji_L" or line.style == "OP_Kanji_R" then
			if char.text~="" and char.i == 1 then
				--Bottom kanji rectangles effect
				
				local rw, rh = math.randomsteps(14, 20, 2), math.randomsteps(8, 12, 2)
				local rect = shape.rectangle(rw, rh)
				local align = math.randomsteps(4, 6, 2)
				local maxj = math.random(3,4)
				
				local max_frame = 100
				local u_out = 0
				
				if line.style == "OP_Kanji_L" then
					xpos = 50
				end
				if line.style == "OP_Kanji_R" then
					xpos = 1230
				end
				
				for j = 1, maxj, 1 do
					for s, e, i, n in utils.frames(line.start_time - line.infade + 100*j, line.end_time + line.outfade, max_frame) do
						
						l.layer = 2
						
						l.start_time = s
						l.end_time = e
						
						local fad = 200
						local max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							local alpha_dist = utils.distributor({"&HFF&" , "&H00&"})
							alpha = alpha_dist:get()
						else
							alpha="&H00&"
						end
						
						local x, y = xpos, lines[line.i].chars[#line.chars].bottom + (rh+(rh/3))*j
						
						l.text=string.format("{\\p1\\an%d\\bord0.2\\shad0\\blur3\\fscx100\\fscy100\\alpha%s\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
						,align,alpha,x,y,rect)
						
						io.write_line(l)
					end
				end
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara(line, table.copy(line) )
	
	io.progressbar(li / #lines)
end