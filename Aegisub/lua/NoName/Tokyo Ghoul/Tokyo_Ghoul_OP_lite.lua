--Tokyo Ghoul Opening
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	
	if line.infade > 250 then
		line.infade = 250
	end
	if line.outfade > 250 then
		line.outfade = 250
	end
	
	local of_x_dist = utils.distributor({15, 25})
	local of_y_dist = utils.distributor({14, -18})
	
	if line.actor == "fx1_gray" then
				main_color = "&H969696&"
				bord_color = "&H0D09A8"
				shad_color = "&H000000"
			end
			if line.actor == "fx1_blue" then
				main_color = "&HAB3918&"
				bord_color = "&HFFFFFF&"
				shad_color = "&H772334&"
			end
	
	if line.style == "OP_romanji" or line.style == "OP_romanji2" or line.style == "OP_romanji_L" or line.style == "OP_romanji_R" or line.style == "OP_kanji" or line.style == "OP_kanji_L" or line.style == "OP_kanji_R" or line.style == "OP_kanji2" then
		
		if line.actor == "fx1_gray" or line.actor == "fx1_blue" then
			
			for si, syl in pairs(line.syls) do
				
				if syl.text~="" or syl.text~=" " then
					--fx1 infade
					
					max_frame = 100
					u_in = 0
					
					for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time+syl.start_time, max_frame) do
						
						l.layer = 5
						
						l.start_time=s
						l.end_time=e
						
						local rx = syl.center + math.randomsteps(-0.5,0.5,0.1)
						local ry = syl.middle + math.randomsteps(-0.6,0.6,0.2)
						
						fad = 250
						max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
							u_in=u_in+1
						else
							alpha_array = {"&H00&" , "&H00&" , "&H00&" , "&H00&" ,"&H00&" , "&H32&" , "&H00&" }
							alpha=alpha_array[math.random(1,table.getn(alpha_array))]
						end
						
						l.text=string.format("{\\an5\\bord0\shad1\\blur0.6\\alpha%s\\1c%s\\4c%s\\pos(%.3f,%.3f)}%s"
						,alpha,main_color,shad_color,rx,ry,syl.text)
						
						io.write_line(l)
					end
				end
				if syl.text~="" or syl.text~=" " then
					--fx1 infade bord
					
					max_frame = 100
					u_in = 0
					
					for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time+syl.start_time, max_frame) do
						
						l.layer = 4
						
						l.start_time=s
						l.end_time=e
						
						local rx = syl.center + math.randomsteps(-0.5,0.5,0.1)
						local ry = syl.middle + math.randomsteps(-0.6,0.6,0.2)
						
						fad = 250
						max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
							u_in=u_in+1
						else
							alpha_array = {"&H00&" , "&H00&" , "&H00&" , "&H00&" ,"&H00&" , "&H32&" , "&H00&" }
							alpha=alpha_array[math.random(1,table.getn(alpha_array))]
						end
						
						l.text=string.format("{\\an5\\bord2\\blur5\\1a&HFF&\\3a%s\\3c%s\\pos(%.3f,%.3f)}%s"
						,alpha,bord_color,syl.center,syl.middle,syl.text)
						
						io.write_line(l)
					end
				end
				
				if syl.text~="" or syl.text~=" " then
					--fx1 syl fx
					
					max_frame = 25
					a = 0
					b = 0
					
					for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
						
						l.layer = 5
						
						l.start_time=s
						
						if i%8 == 0 then
							distort = 5*math.sin(math.rad(a))
							l.end_time=e + 250
							fad = 250
							mov = math.cos(math.rad(a))
							a = a + 60
							b = b + 180
							alpha = "&H64&"
						else
							distort = 0
							l.end_time=e
							fad = 0
							mov = 0
							alpha = "&H00&"
						end
						
						local step = i / n
						
						local sc = 100 + 30*math.sin(math.rad(utils.interpolate(step, 0, 180)))
						
						local x1, y1 = syl.center + distort, syl.middle + distort
						local x2, y2 = x1 + mov, y1 + mov
						
						l.text=string.format("{\\an5\\bord0\\shad1\\blur0.6\\fad(0,%d)\\fscx%.3f\\fscy%.3f\\alpha%s\\1c%s\\4c%s\\move(%.3f,%.3f,%.3f,%.3f)}%s"
						,fad,sc,sc,alpha,main_color,shad_color,x2,y2,x1,y1,syl.text)
						
						io.write_line(l)
					end
				end
				
				if syl.text~="" or syl.text~=" " then
					--fx1 bord syl fx
					
					max_frame = 25
					a = 0
					b = 0
					
					for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
						
						l.layer = 4
						
						l.start_time=s
						
						if i%8 == 0 then
							distort = 5*math.sin(math.rad(a))
							l.end_time = e + 250
							fad = 250
							mov = math.cos(math.rad(b))
							a = a + 60
							b = b + 180
							alpha = "&H96&"
						else
							distort = 0
							l.end_time = e
							fad = 0
							mov = 0
							alpha = "&H00&"
						end
						
						local step = i / n
						
						local sc = 100 + 30*math.sin(math.rad(utils.interpolate(step, 0, 180)))
						
						local x1, y1 = syl.center + distort, syl.middle + distort
						local x2, y2 = x1 + mov, y1 + mov
						
						l.text=string.format("{\\an5\\bord2\\blur5\\fad(0,%d)\\fscx%.3f\\fscy%.3f\\1a&HFF&\\3a%s\\3c%s\\move(%.3f,%.3f,%.3f,%.3f)}%s"
						,fad,sc,sc,alpha,bord_color,x2,y2,x1,y1,syl.text)
						
						io.write_line(l)
					end
				end
				
				if syl.text~="" or syl.text~=" " then
					--fx1 outfade
					
					max_frame = 100
					u_out = 0
					
					for s, e, i, n in utils.frames(line.start_time+syl.end_time, line.end_time+line.outfade, max_frame) do
						
						l.layer = 5
						
						l.start_time=s
						l.end_time=e
						
						fad = 250
						max=math.ceil(fad/max_frame)
						if i>(n-math.ceil(fad/max_frame)) then
							alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
							x1 = syl.center + math.randomsteps(-0.5,0.5,0.1)
							y1 = syl.middle + math.randomsteps(-0.6,0.6,0.2)
							x2 = syl.center+of_x_dist:get()+math.randomsteps(-6,6,2)
							y2 = syl.middle+of_y_dist:get()+math.randomsteps(-6,6,3)
							x = utils.interpolate(u_out/max, x1, x2)
							y = utils.interpolate(u_out/max, y1, y2)
							u_out=u_out+1
						else
							alpha_array = {"&H00&" , "&H00&" , "&H00&" , "&H00&" ,"&H00&" , "&H32&" , "&H00&" }
							alpha=alpha_array[math.random(1,table.getn(alpha_array))]
							x = syl.center + math.randomsteps(-0.5,0.5,0.1)
							y = syl.middle + math.randomsteps(-0.6,0.6,0.2)
						end
						
						l.text=string.format("{\\an5\\bord0\\shad1\\blur0.6\\alpha%s\\1c%s\\4c%s\\pos(%.3f,%.3f)}%s"
						,alpha,main_color,shad_color,x,y,syl.text)
						
						io.write_line(l)
					end
				end
				
				if syl.text~="" or syl.text~=" " then
					--fx1 outfade bord
					
					max_frame = 100
					u_out = 0
					
					for s, e, i, n in utils.frames(line.start_time+syl.end_time, line.end_time+line.outfade, max_frame) do
						
						l.layer = 4
						
						l.start_time=s
						l.end_time=e
						
						local rx = syl.center + math.randomsteps(-0.5,0.5,0.1)
						local ry = syl.middle + math.randomsteps(-0.6,0.6,0.2)
						
						ffad = 250
						max=math.ceil(fad/max_frame)
						if i>(n-math.ceil(fad/max_frame)) then
							alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
							x1 = syl.center + math.randomsteps(-0.5,0.5,0.1)
							y1 = syl.middle + math.randomsteps(-0.6,0.6,0.2)
							x2 = syl.center+of_x_dist:get()+math.randomsteps(-6,6,2)
							y2 = syl.middle+of_y_dist:get()+math.randomsteps(-6,6,3)
							x = utils.interpolate(u_out/max, x1, x2)
							y = utils.interpolate(u_out/max, y1, y2)
							u_out=u_out+1
						else
							alpha_array = {"&H00&" , "&H00&" , "&H00&" , "&H00&" ,"&H00&" , "&H32&" , "&H00&" }
							alpha=alpha_array[math.random(1,table.getn(alpha_array))]
							x = syl.center + math.randomsteps(-0.5,0.5,0.1)
							y = syl.middle + math.randomsteps(-0.6,0.6,0.2)
						end
						
						l.text=string.format("{\\an5\\bord2\\blur5\\1a&HFF&\\3a%s\\3c%s\\pos(%.3f,%.3f)}%s"
						,alpha,bord_color,x,y,syl.text)
						
						io.write_line(l)
					end
				end
			end
			
			if line.text~="" then
				--fx1 background infade
				max_frame = 65
				
				local rx = line.center + 6*math.randomsteps(-1,1,0.5)
				local ry = line.middle + 6*math.random(-1,1)
				
				if line.actor == "fx1_gray" then
					color_dist = utils.distributor({"&H969696&", "&H0D09A8&", "&H969696&", "&H0D09A8&"})
				end
				if line.actor == "fx1_blue" then
					color_dist = utils.distributor({"&HAB3918&", "&HFFFFFF&", "&HAB3918&", "&HFFFFFF&"})
				end
				
				local pos_dist = utils.distributor({-20, 20, -10, 10})
				local sc_dist = utils.distributor({180, 140, 160, 120})
				
				for s, e, i, n in utils.frames(line.start_time-260, line.start_time, max_frame) do
					
					l.layer = 1
					
					l.start_time=s
					l.end_time=e + 100
					
					local color = color_dist:get()
					local pos = pos_dist:get()
					local sc = sc_dist:get()
					
					local x, y = line.center + pos, line.middle + pos
					
					l.text=string.format("{\\an5\\bord0.5\\shad0\\blur5\\fscx%d\\fscy%d\\fad(0,100)\\1a&HFF&\\3a&H32&\\3c%s\\pos(%.3f,%.3f)}%s"
					,sc,sc,color,x,y,line.text)
					
					io.write_line(l)
				end
			end
			
			if line.text~="" then
				--fx1 background fx
				max_frame = math.randomsteps(200,1000,100)
				
				local rx = line.center + 8*math.randomsteps(-1,1,0.5)
				local ry = line.middle + 10*math.randomsteps(-1.2, 1.2, 0.3)
				
				for s, e, i, n in utils.frames(line.start_time, line.end_time, max_frame) do
					
					l.layer = 1
					
					l.start_time=s
					l.end_time=e + math.randomsteps(50,250,50)
					
					alpha_array = {"&H32&" , "&HFF&" , "&HFF&" , "&H32&" ,"&HFF&" , "&HFF&" , "&H32&" }
					random_alpha=alpha_array[math.random(1,table.getn(alpha_array))]
					
					l.text=string.format("{\\an5\\bord0.2\\shad0\\blur8\\fscx105\\fscy105\\1a&HFF&\\3a%s\\3c%s\\pos(%.3f,%.3f)}%s"
					,random_alpha,bord_color,rx,ry,line.text)
					
					io.write_line(l)
				end
			end
		end
		
		if line.actor == "fx2" then
			
			for si, syl in ipairs(line.syls) do
				
				if syl.text~="" then
					--fx2 infade
					
					maxj = syl.height
					for j = 1,maxj,4 do
						
						l.layer = 9
						
						local rs = math.randomsteps(0, line.infade, line.infade/maxj)
						
						l.start_time=line.start_time+rs
						l.end_time=line.start_time+syl.start_time
						
						local clip_src = shape.rectangle(syl.width+50,4)
						local clip = shape.move(clip_src,syl.left-25,syl.top+j)
						
						local x, y = syl.center, syl.middle
						
						l.text=string.format("{\\an5\\bord2\shad1\\blur2\\1a&HFF&\\3c&H0D10C1&\\clip(%s)\\pos(%.3f,%.3f)}%s"
						,clip,x,y,syl.text)
						
						io.write_line(l)
						
					end
				end
				
				if syl.text~="" then
					--fx2 syl fx 2
					
					local text_shape = convert.text_to_shape(syl.text, line.styleref)
					local split_shape = shape.split(text_shape, 5)
					local shape_outline = shape.tooutline(split_shape, 3)
					local color_array = {"&H1115D9&", "&HDC16E0&,", "&HAB1613&", "&HD8159A&", "&HFFFFFC&", "&H100B8B&", "&H26C5DD&", "&HCD1E1E&", "&H190FD3&", "&H660607&", "&HFFFFFE&", "&HA61DC5&"}
					local max_frame = 25
					u_out = 0
					
					for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
						
						l.layer = 10
						
						l.start_time=s
						l.end_time=e
						
						local x, y = syl.left, syl.top
						
						l.start_time = s
						l.end_time = e + 250
						
						local step = i / n
						
						l.layer = 3
						
						text_deform_x = 30*math.sin(math.rad(utils.interpolate(step, 0, 90)))
						text_deform_y = 30*math.sin(math.rad(utils.interpolate(step, 0, 90)))
						
						local deform = shape.filter(split_shape,
						function(x,y)
							local xdef = text_deform_x + math.random(-10,10) + 20*math.sin(math.rad(utils.interpolate(step, 0, 180)))
							local ydef = text_deform_y + math.random(-10,10) + 20*math.sin(math.rad(utils.interpolate(step, 0, 180)))
							return x+xdef, y+ydef
						end)
						
						local c1, c2 = "&H0D10C1&", color_array[math.random(1,table.getn(color_array))]
						local color = utils.interpolate(step, c1, c2)
						
						fad = 250
						max=math.ceil(fad/max_frame)
						if i>(n-math.ceil(fad/max_frame)) then
							alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
							u_out=u_out+1
						else
							alpha="&H00&"
						end
						
						l.text=string.format("{\\p4\\an7\\bord1\shad0\\fscx100\\fscy100\\blur0.4\\1a&HFF&\\3a%s\\3c%s\\pos(%.3f,%.3f)}%s"
						,alpha,color,x,y,deform)
						
						io.write_line(l)
					end
				end
				
				if syl.text~="" then
					--fx2 outfade
					
					maxj = syl.height
					for j = 1,maxj,4 do
						
						l.layer = 9
						
						local re = math.randomsteps(0, line.outfade, line.outfade/maxj)
						
						l.start_time=line.start_time+syl.end_time
						l.end_time=line.end_time+re
						
						local clip_src = shape.rectangle(syl.width+50,4)
						local clip = shape.move(clip_src,syl.left-25,syl.top+j)
						
						local x, y = syl.center, syl.middle
						
						l.text=string.format("{\\an5\\bord2\shad1\\blur2\\1a&HFF&\\3c&H0D10C1&\\clip(%s)\\pos(%.3f,%.3f)}%s"
						,clip,x,y,syl.text)
						
						io.write_line(l)
						
					end
				end
			end
		end
	end
	
	if line.style == "OP_TL" then
		
		if line.actor == "fx1_gray" or line.actor == "fx1_blue" then
			
			for si, syl in pairs(line.syls) do
				
				if syl.text~="" or syl.text~=" " then
					--TL fx1 infade
					
					max_frame = 100
					u_in = 0
					
					for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time+syl.start_time, max_frame) do
						
						l.layer = 5
						
						l.start_time=s
						l.end_time=e
						
						local rx = syl.center + math.randomsteps(-0.5,0.5,0.1)
						local ry = syl.middle + math.randomsteps(-0.6,0.6,0.2)
						
						fad = 250
						max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
							u_in=u_in+1
						else
							alpha_array = {"&H00&" , "&H00&" , "&H00&" , "&H00&" ,"&H00&" , "&H32&" , "&H00&" }
							alpha=alpha_array[math.random(1,table.getn(alpha_array))]
						end
						
						l.text=string.format("{\\an5\\bord0\shad1\\blur0.6\\alpha%s\\1c%s\\4c%s\\pos(%.3f,%.3f)}%s"
						,alpha,main_color,shad_color,rx,ry,syl.text)
						
						io.write_line(l)
					end
				end
				if syl.text~="" or syl.text~=" " then
					--fx1 infade bord
					
					max_frame = 100
					u_in = 0
					
					for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time+syl.start_time, max_frame) do
						
						l.layer = 4
						
						l.start_time=s
						l.end_time=e
						
						local rx = syl.center + math.randomsteps(-0.5,0.5,0.1)
						local ry = syl.middle + math.randomsteps(-0.6,0.6,0.2)
						
						fad = 250
						max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
							u_in=u_in+1
						else
							alpha_array = {"&H00&" , "&H00&" , "&H00&" , "&H00&" ,"&H00&" , "&H32&" , "&H00&" }
							alpha=alpha_array[math.random(1,table.getn(alpha_array))]
						end
						
						l.text=string.format("{\\an5\\bord2\\blur5\\1a&HFF&\\3a%s\\3c%s\\pos(%.3f,%.3f)}%s"
						,alpha,bord_color,syl.center,syl.middle,syl.text)
						
						io.write_line(l)
					end
				end
				
				if syl.text~="" or syl.text~=" " then
					--fx1 outfade
					
					max_frame = 100
					u_out = 0
					
					for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.end_time+line.outfade, max_frame) do
						
						l.layer = 5
						
						l.start_time=s
						l.end_time=e
						
						fad = 250
						max=math.ceil(fad/max_frame)
						if i>(n-math.ceil(fad/max_frame)) then
							alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
							x1 = syl.center + math.randomsteps(-0.5,0.5,0.1)
							y1 = syl.middle + math.randomsteps(-0.6,0.6,0.2)
							x2 = syl.center+of_x_dist:get()+math.randomsteps(-6,6,2)
							y2 = syl.middle+of_y_dist:get()+math.randomsteps(-6,6,3)
							x = utils.interpolate(u_out/max, x1, x2)
							y = utils.interpolate(u_out/max, y1, y2)
							u_out=u_out+1
						else
							alpha_array = {"&H00&" , "&H00&" , "&H00&" , "&H00&" ,"&H00&" , "&H32&" , "&H00&" }
							alpha=alpha_array[math.random(1,table.getn(alpha_array))]
							x = syl.center + math.randomsteps(-0.5,0.5,0.1)
							y = syl.middle + math.randomsteps(-0.6,0.6,0.2)
						end
						
						l.text=string.format("{\\an5\\bord0\\shad1\\blur0.6\\alpha%s\\1c%s\\4c%s\\pos(%.3f,%.3f)}%s"
						,alpha,main_color,shad_color,x,y,syl.text)
						
						io.write_line(l)
					end
				end
				
				if syl.text~="" or syl.text~=" " then
					--fx1 outfade bord
					
					max_frame = 100
					u_out = 0
					
					for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.end_time+line.outfade, max_frame) do
						
						l.layer = 4
						
						l.start_time=s
						l.end_time=e
						
						local rx = syl.center + math.randomsteps(-0.5,0.5,0.1)
						local ry = syl.middle + math.randomsteps(-0.6,0.6,0.2)
						
						ffad = 250
						max=math.ceil(fad/max_frame)
						if i>(n-math.ceil(fad/max_frame)) then
							alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
							x1 = syl.center + math.randomsteps(-0.5,0.5,0.1)
							y1 = syl.middle + math.randomsteps(-0.6,0.6,0.2)
							x2 = syl.center+of_x_dist:get()+math.randomsteps(-6,6,2)
							y2 = syl.middle+of_y_dist:get()+math.randomsteps(-6,6,3)
							x = utils.interpolate(u_out/max, x1, x2)
							y = utils.interpolate(u_out/max, y1, y2)
							u_out=u_out+1
						else
							alpha_array = {"&H00&" , "&H00&" , "&H00&" , "&H00&" ,"&H00&" , "&H32&" , "&H00&" }
							alpha=alpha_array[math.random(1,table.getn(alpha_array))]
							x = syl.center + math.randomsteps(-0.5,0.5,0.1)
							y = syl.middle + math.randomsteps(-0.6,0.6,0.2)
						end
						
						l.text=string.format("{\\an5\\bord2\\blur5\\1a&HFF&\\3a%s\\3c%s\\pos(%.3f,%.3f)}%s"
						,alpha,bord_color,x,y,syl.text)
						
						io.write_line(l)
					end
				end
			end
			
			if line.text~="" then
				--fx1 background infade
				max_frame = 65
				
				local rx = line.center + 6*math.randomsteps(-1,1,0.5)
				local ry = line.middle + 6*math.random(-1,1)
				
				if line.actor == "fx1_gray" then
					color_dist = utils.distributor({"&H969696&", "&H0D09A8&", "&H969696&", "&H0D09A8&"})
				end
				if line.actor == "fx1_blue" then
					color_dist = utils.distributor({"&HAB3918&", "&HFFFFFF&", "&HAB3918&", "&HFFFFFF&"})
				end
				
				local pos_dist = utils.distributor({-20, 20, -10, 10})
				local sc_dist = utils.distributor({180, 140, 160, 120})
				
				for s, e, i, n in utils.frames(line.start_time-260, line.start_time, max_frame) do
					
					l.layer = 1
					
					l.start_time=s
					l.end_time=e + 100
					
					local color = color_dist:get()
					local pos = pos_dist:get()
					local sc = sc_dist:get()
					
					local x, y = line.center + pos, line.middle + pos
					
					l.text=string.format("{\\an5\\bord0.5\\shad0\\blur5\\fscx%d\\fscy%d\\fad(0,100)\\1a&HFF&\\3a&H32&\\3c%s\\pos(%.3f,%.3f)}%s"
					,sc,sc,color,x,y,line.text)
					
					io.write_line(l)
				end
			end
			
			if line.text~="" then
				--fx1 background fx
				max_frame = math.randomsteps(200,1000,100)
				
				local rx = line.center + 8*math.randomsteps(-1,1,0.5)
				local ry = line.middle + 10*math.randomsteps(-1.2, 1.2, 0.3)
				
				for s, e, i, n in utils.frames(line.start_time, line.end_time, max_frame) do
					
					l.layer = 1
					
					l.start_time=s
					l.end_time=e + math.randomsteps(50,250,50)
					
					alpha_array = {"&H32&" , "&HFF&" , "&HFF&" , "&H32&" ,"&HFF&" , "&HFF&" , "&H32&" }
					random_alpha=alpha_array[math.random(1,table.getn(alpha_array))]
					
					l.text=string.format("{\\an5\\bord0.2\\shad0\\blur8\\fscx105\\fscy105\\1a&HFF&\\3a%s\\3c%s\\pos(%.3f,%.3f)}%s"
					,random_alpha,bord_color,rx,ry,line.text)
					
					io.write_line(l)
				end
			end
		end
		
		if line.actor == "fx2" then
			
			for si, syl in ipairs(line.syls) do
				
				if syl.text~="" then
					--fx2 infade
					
					maxj = syl.height
					for j = 1,maxj,4 do
						
						l.layer = 9
						
						local rs = math.randomsteps(0, line.infade, line.infade/maxj)
						
						l.start_time=line.start_time+rs
						l.end_time=line.start_time+syl.start_time
						
						local clip_src = shape.rectangle(syl.width+50,4)
						local clip = shape.move(clip_src,syl.left-25,syl.top+j)
						
						local x, y = syl.center, syl.middle
						
						l.text=string.format("{\\an5\\bord2\shad1\\blur2\\1a&HFF&\\3c&H0D10C1&\\clip(%s)\\pos(%.3f,%.3f)}%s"
						,clip,x,y,syl.text)
						
						io.write_line(l)
						
					end
				end
				
				if syl.text~="" then
					--fx2 outfade
					
					maxj = syl.height
					for j = 1,maxj,4 do
						
						l.layer = 9
						
						local re = math.randomsteps(0, line.outfade, line.outfade/maxj)
						
						l.start_time=line.start_time+syl.start_time
						l.end_time=line.end_time+re
						
						local clip_src = shape.rectangle(syl.width+50,4)
						local clip = shape.move(clip_src,syl.left-25,syl.top+j)
						
						local x, y = syl.center, syl.middle
						
						l.text=string.format("{\\an5\\bord2\shad1\\blur2\\1a&HFF&\\3c&H0D10C1&\\clip(%s)\\pos(%.3f,%.3f)}%s"
						,clip,x,y,syl.text)
						
						io.write_line(l)
						
					end
				end
			end
		end
		
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end