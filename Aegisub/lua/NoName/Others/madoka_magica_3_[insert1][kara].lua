--Gekijouban Mahou Shoujo Madoka Magica 3 Insert 1
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	if line.infade > 250 then
		line.infade = 250
	end
	if line.outfade > 250 then
		line.outfade = 250
	end
	
	for si, syl in ipairs(line.syls) do
		if syl.text~="" then
			--bord if
			l.layer = 5
			
			l.start_time = line.start_time-line.infade
			l.end_time = line.start_time+syl.start_time
			
			l.text = string.format("{\\an5\\blur2\\bord2\\shad0\\fscx100\\fscy100\\fad(250,0)\\1a&HFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--bord of
			l.layer = 5
			
			l.start_time = line.start_time+syl.end_time
			l.end_time = line.end_time+line.outfade
			
			l.text = string.format("{\\an5\\blur2\\bord2\\shad0\\fscx100\\fscy100\\fad(0,250)\\1a&HFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
	end
	
	local dist1 = utils.distributor({"&H0000FF&", "&H00FF00&", "&HFF0000&", "&HFFFF00&", "&H00FFFF&", "&HFF00FF&"})
	local dist2 = utils.distributor({"&HFF00FF&", "&H00FFFF&", "&HFFFF00&", "&HFF0000&", "&H00FF00&", "&H0000FF&"})
	
	for ci, char in ipairs(line.chars) do
		
		if char.text~="" then
			--infade
			
			inf_char_col = dist1:get()
			
			l.layer = 4
			
			l.start_time = line.start_time-line.infade
			l.end_time = line.start_time+char.start_time
			
			l.text = string.format("{\\an5\\blur0\\bord0\\shad0\\fscx100\\fscy100\\fad(250,0)\\1c%s\\pos(%.3f, %.3f)}%s"
			,inf_char_col,char.center,char.middle,char.text)
			
			io.write_line(l)
		end
		
		if char.text~=" " then
			--bord char effect
			
			max_frame = 25
			
			local start_col_dist = utils.distributor({"&HFF00FF&", "&H00FFFF&", "&HFFFF00&", "&HFF0000&", "&H00FF00&", "&H0000FF&"})
			
			for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
				
				local star = shape.star(4, 2, 6)
				
				star_col = start_col_dist:get()
				
				rs = math.randomsteps(0,250,50)
				
				l.start_time = s + rs
				l.end_time = e + rs + 250
				
				l.layer = 2
				
				step = i / n
				
				bord = 3*math.sin(math.rad(utils.interpolate(step, 90, 180)))
				sc = utils.interpolate(step, 80, 60)
				
				x = math.random(char.left+3, char.right)
				y = math.random(char.top+3, char.bottom-3)
				
				of_start = l.end_time-l.start_time-100
				of_end = l.end_time-l.start_time
				
				l.text = string.format("{\\an5\\p1\\blur3\\bord%d\\shad0\\fscx%d\\fscy%d\\fad(0,100)\\3a&H64&\\1c&HFFFFFF&\\3c%s\\t(%d,%d,\\1c%s)\\pos(%.3f, %.3f)}%s"
				,bord,sc,sc,star_col,of_start,of_end,star_col,x,y,star)
				
				io.write_line(l)
			end
		end
		
		if char.text~="" then
			--outfade
			
			of_char_col = dist2:get()
			
			l.layer = 4
			
			l.start_time = line.start_time+char.end_time
			l.end_time = line.end_time+line.outfade
			
			l.text = string.format("{\\an5\blur0\\bord0\\shad0\\fscx100\\fscy100\\fad(0,250)\\1c%s\\pos(%.3f, %.3f)}%s"
			,of_char_col,char.center,char.middle,char.text)
			
			io.write_line(l)
		end
		
		if char.text~="" then
			--char effect 1
			max_frame = 25
			
			color3_array = {"&H0000FF&", "&H00FF00&", "&HFF0000&", "&HFFFF00&", "&H00FFFF&", "&HFF00FF&"}
			color3 = color3_array[math.random(1,table.getn(color3_array))]
			color4_array = {"&HFF00FF&", "&H00FFFF&", "&HFFFF00&", "&HFF0000&", "&H00FF00&", "&H0000FF&"}
			color4 = color4_array[math.random(1,table.getn(color4_array))]
			
			for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
				
				for pi, pixel in ipairs(convert.text_to_pixels(char.text, line.styleref)) do
					
					l.layer = 4
					
					step = i / n
					
					l.start_time = s
					l.end_time = e
					
					x = char.left + pixel.x
					y = char.top + pixel.y
					
					pct = math.sin(math.rad(utils.interpolate(step, 0, 90)))
					
					ang1 = math.sin(math.atan2(pixel.x,pixel.y))
					ang2 = math.sin(math.atan2(pixel.y,pixel.x))
					
					trans1 = utils.interpolate(ang1, color3, "&HFFFFFF&")
					trans2 = utils.interpolate(ang2,"&HFFFFFF&", color4)
					
					color = utils.interpolate(step, utils.interpolate(pct, inf_char_col, trans1), utils.interpolate(pct, trans2, of_char_col))
					
					l.text = string.format("{\\an7\\p1\\blur0\\bord0\\shad0.5\\fscx100\\fscy100\\1c%s\\4c%s\\pos(%.3f, %.3f)}m 0 0 l 1 0 1 1 0 1"
					,color,color,x,y)
					
					io.write_line(l)
				end
			end
			
		end
		
		if char.text~="" then
			--char effect 2
			max_frame = 25
			a = 0
			b = 0
			c = 0
			u_in = 0
			u_out = 0
			
			for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
				
				l.layer = 5
				
				step = i / n
				
				l.start_time = s
				l.end_time = e
				
				fad = char.duration/4
				max=math.ceil(fad/max_frame)
				if i<math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
					u_in=u_in+1
				elseif i>(n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					u_out=u_out+1
				else
					alpha="&H00&"
				end
				
				if char.i%2 == 0 then
					
					sc = 100 + 20*math.sin(math.rad(a))
					a = a + 90
					
					blur = 2 + math.sin(math.rad(b))
					b = b + 45
					
					bord = 2 + math.sin(math.rad(c))
					c = c + 30
					
				end
				
				if char.i%2 == 1 then
					
					sc = 100 + 20*math.cos(math.rad(a))
					a = a + 90
					
					blur = 2 + math.cos(math.rad(b))
					b = b + 45
					
					bord = 2 + math.cos(math.rad(c))
					c = c + 30
					
				end
				
				bord_col = utils.interpolate(step, inf_char_col, of_char_col)
				
				l.text = string.format("{\\an5\\blur%d\\bord%d\\shad0.5\\fscx%d\\fscy%d\\1a&HFF&\\3a%s\\3c%s\\pos(%.3f, %.3f)}%s"
				
				,blur,bord,sc,sc,alpha,bord_col,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
		
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end