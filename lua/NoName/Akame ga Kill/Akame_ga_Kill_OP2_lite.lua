function romaji(line, l)
	--Akame ga Kill OP2
	--Karaoke by Amberdrake
	--VSFilter
	
	line.infade = 250
	line.outfade = 250
	
	if line.style == "Akame_OP_Romaji" then
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--infade
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local max_frame = 100
				
				local u_in, u_out = 0, 0
				
				local xdist, ydist = utils.distributor({-30, 30}), utils.distributor({-60, 60})
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time, max_frame) do
					
					l.layer=5
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					alpha = utils.interpolate(step, "&H96&", "&H64&")
					local pct = math.cos(math.rad(utils.interpolate(step, 180, 360)))
					deform = shape.filter(text_shape,
					function(x,y)
						local sx, sy = xdist:get(), ydist:get()
						x, y = utils.interpolate(pct, x+sx, x), utils.interpolate(pct, y+sy, y)
						return x, y
					end)
					sc = utils.interpolate(step, 75, 100)
					xpos, ypos = syl.left, syl.top
					
					l.text=string.format("{\\p4\\an7\\blur5\\bord2\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,xpos,ypos,deform)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--placeholder 1
				
				l.layer=5
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an7\\blur5\\bord2\\fscx100\\fscy100\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
				,syl.left,syl.top,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--placeholder 2
				
				l.layer=5
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an7\\blur5\\bord2\\fscx100\\fscy100\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
				,syl.left,syl.top,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx
				local max_frame = 100
				
				local u_in, u_out = 0, 0
				
				local xdist, ydist = utils.distributor({-30, 30}), utils.distributor({-60, 60})
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer=5
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					alpha_array = {"&H16&" , "&H00&" , "&H32&" , "&H00&" , "&H19&" }
					alpha = alpha_array[math.random(1,table.getn(alpha_array))]
					deform = text_shape
					xpos, ypos = syl.left + math.randomsteps(-3, 1, 0.5), syl.top + math.randomsteps(-3, 1, 0.25)
					sc = 105 + math.randomsteps(-5, 5, 2.5)
					
					l.text=string.format("{\\an7\\blur5\\bord2\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,xpos,ypos,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--outfade
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local max_frame = 100
				
				local u_in, u_out = 0, 0
				
				local xdist, ydist = utils.distributor({-30, 30}), utils.distributor({-60, 60})
				
				for s, e, i, n in utils.frames(line.end_time, line.end_time+line.outfade, max_frame) do
					
					l.layer=5
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					alpha = utils.interpolate(step, "&H64&", "&H96&")
					local pct = math.cos(math.rad(utils.interpolate(step, 0, 180)))
					deform = shape.filter(text_shape,
					function(x,y)
						local sx, sy = xdist:get(), ydist:get()
						x, y = utils.interpolate(pct, x+sx, x), utils.interpolate(pct, y+sy, y)
						return x, y
					end)
					sc = utils.interpolate(step, 100, 75)
					xpos, ypos = syl.left, syl.top
					
					l.text=string.format("{\\p4\\an7\\blur5\\bord2\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,xpos,ypos,deform)
					
					io.write_line(l)
				end
			end
		end
	end
	if line.style == "Akame_OP_Kanji" then
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--infade
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local max_frame = 100
				
				local u_in, u_out = 0, 0
				
				local xdist, ydist = utils.distributor({-30, 30}), utils.distributor({-60, 60})
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time, max_frame) do
					
					l.layer=5
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					alpha = utils.interpolate(step, "&H96&", "&H64&")
					local pct = math.cos(math.rad(utils.interpolate(step, 180, 360)))
					deform = shape.filter(text_shape,
					function(x,y)
						local sx, sy = xdist:get(), ydist:get()
						x, y = utils.interpolate(pct, x+sx, x), utils.interpolate(pct, y+sy, y)
						return x, y
					end)
					sc = utils.interpolate(step, 75, 100)
					xpos, ypos = char.left, char.top
					u_in=u_in+1
					
					l.text=string.format("{\\p4\\an7\\blur5\\bord2\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,xpos,ypos,deform)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--placeholder 1
				
				l.layer=5
				
				l.start_time=line.start_time
				l.end_time=line.start_time+char.start_time
				
				l.text=string.format("{\\an7\\blur5\\bord2\\fscx100\\fscy100\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
				,char.left,char.top,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--placeholder 2
				
				l.layer=5
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an7\\blur5\\bord2\\fscx100\\fscy100\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
				,char.left,char.top,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--char fx
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local max_frame = 100
				
				local u_in, u_out = 0, 0
				
				local xdist, ydist = utils.distributor({-30, 30}), utils.distributor({-60, 60})
				
				for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
					
					l.layer=5
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					alpha_array = {"&H16&" , "&H00&" , "&H32&" , "&H00&" , "&H19&" }
					alpha = alpha_array[math.random(1,table.getn(alpha_array))]
					xpos, ypos = char.left + math.randomsteps(-3, 1, 0.5), char.top + math.randomsteps(-3, 1, 0.25)
					sc = 105 + math.randomsteps(-5, 5, 2.5)
					
					l.text=string.format("{\\an7\\blur5\\bord2\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,xpos,ypos,char.text)
					
					io.write_line(l)
				end
			end
			if char.text~="" then
				--outfade
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local max_frame = 100
				
				local u_in, u_out = 0, 0
				
				local xdist, ydist = utils.distributor({-30, 30}), utils.distributor({-60, 60})
				
				for s, e, i, n in utils.frames(line.end_time, line.end_time+line.outfade, max_frame) do
					
					l.layer=5
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					alpha = utils.interpolate(step, "&H64&", "&H96&")
					local pct = math.cos(math.rad(utils.interpolate(step, 0, 180)))
					deform = shape.filter(text_shape,
					function(x,y)
						local sx, sy = xdist:get(), ydist:get()
						x, y = utils.interpolate(pct, x+sx, x), utils.interpolate(pct, y+sy, y)
						return x, y
					end)
					sc = utils.interpolate(step, 100, 75)
					xpos, ypos = char.left, char.top
					
					l.text=string.format("{\\p4\\an7\\blur5\\bord2\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,xpos,ypos,deform)
					
					io.write_line(l)
				end
			end
		end
	end
	if line.style == "Akame_OP_TL" then
		for si,char in ipairs(line.chars) do
			
			if char.text~="" then
				--infade
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local max_frame = 100
				
				local u_in, u_out = 0, 0
				
				local xdist, ydist = utils.distributor({-30, 30}), utils.distributor({-60, 60})
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time, max_frame) do
					
					l.layer=5
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					alpha = utils.interpolate(step, "&H96&", "&H64&")
					local pct = math.cos(math.rad(utils.interpolate(step, 180, 360)))
					deform = shape.filter(text_shape,
					function(x,y)
						local sx, sy = xdist:get(), ydist:get()
						x, y = utils.interpolate(pct, x+sx, x), utils.interpolate(pct, y+sy, y)
						return x, y
					end)
					sc = utils.interpolate(step, 75, 100)
					xpos, ypos = char.left, char.top
					u_in=u_in+1
					
					l.text=string.format("{\\p4\\an7\\blur5\\bord2\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,xpos,ypos,deform)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--placeholder 1
				
				l.layer=5
				
				l.start_time=line.start_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an7\\blur5\\bord2\\fscx100\\fscy100\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
				,char.left,char.top,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--char fx
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local max_frame = 100
				
				local u_in, u_out = 0, 0
				
				local xdist, ydist = utils.distributor({-30, 30}), utils.distributor({-60, 60})
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time, max_frame) do
					
					l.layer=5
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					alpha_array = {"&H16&" , "&H00&" , "&H32&" , "&H00&" , "&H19&" }
					alpha = alpha_array[math.random(1,table.getn(alpha_array))]
					deform = text_shape
					xpos, ypos = char.left + math.randomsteps(-3, 1, 0.5), char.top + math.randomsteps(-3, 1, 0.25)
					sc = 105 + math.randomsteps(-5, 5, 2.5)
					
					l.text=string.format("{\\p4\\an7\\blur5\\bord2\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,xpos,ypos,deform)
					
					io.write_line(l)
				end
			end
			if char.text~="" then
				--outfade
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local max_frame = 100
				
				local u_in, u_out = 0, 0
				
				local xdist, ydist = utils.distributor({-30, 30}), utils.distributor({-60, 60})
				
				for s, e, i, n in utils.frames(line.end_time, line.end_time+line.outfade, max_frame) do
					
					l.layer=5
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					alpha = utils.interpolate(step, "&H64&", "&H96&")
					local pct = math.cos(math.rad(utils.interpolate(step, 0, 180)))
					deform = shape.filter(text_shape,
					function(x,y)
						local sx, sy = xdist:get(), ydist:get()
						x, y = utils.interpolate(pct, x+sx, x), utils.interpolate(pct, y+sy, y)
						return x, y
					end)
					sc = utils.interpolate(step, 100, 75)
					xpos, ypos = char.left, char.top
					
					l.text=string.format("{\\p4\\an7\\blur5\\bord2\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&HFFFFF4&\\3c&H926023&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,xpos,ypos,deform)
					
					io.write_line(l)
				end
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	romaji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end