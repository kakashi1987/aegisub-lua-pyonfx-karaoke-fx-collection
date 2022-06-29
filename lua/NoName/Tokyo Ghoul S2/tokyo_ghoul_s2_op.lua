--Tokyo Ghoul S2 OP
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	if line.style == "TGs2_OP_romaji" or line.style == "TGs2_OP_kanji" then
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--text outline
				
				l.layer = 4
				
				l.start_time = line.start_time-line.infade+50*syl.i-50
				l.end_time = line.end_time+line.outfade+50*syl.i-50
				
				local infad = 250
				local of_start = l.end_time-l.start_time-250
				local of_end = l.end_time-l.start_time
				
				l.text = string.format("{\\an5\\bord2\\blur8\\t(0,%d,\\blur3)\\t(%d,%d,\\blur8)\\fad(250,250)\\1a&HFF&\\3c&H4B4DE2&\\pos(%.3f, %.3f)}%s"
				,infad,of_start,of_end,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--text
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+50*syl.i-50
				l.end_time = line.end_time+line.outfade+50*syl.i-50
				
				local infad = 250
				local of_start = l.end_time-l.start_time-250
				local of_end = l.end_time-l.start_time
				
				l.text = string.format("{\\an5\\bord0\\blur10\\t(0,%d,\\blur0.8)\\t(%d,%d,\\blur10)\\fscx100\\fscy100\\fad(250,250)\\1c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,infad,of_start,of_end,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" and syl.text~=" " then
				
				--syl fx 1
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 15)
				local text_outline = shape.tooutline(split_shape, 15)
				local tlx, tly, brx, bry = shape.bounding(text_shape)
				
				local max_frame = 100
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				if line.effect == "red" then
					color = "&H4B4DE2&"
				end
				if line.effect == "col1" then
					color_array = {"&H39EEF3&" , "&HC70333&" , "&H1E11C5&", "&HC70333&" , "&H6B3FD6&", "&HC70333&" }
					color = color_array[math.random(1,table.getn(color_array))]
				end
				if line.effect == "col2" then
					color_array = {"&H600D18&" , "&H93A055&" , "&HBFFD7D&" , "&HBB5996&" ,"&H799754&" }
					color = color_array[math.random(1,table.getn(color_array))]
				end
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 3
					
					l.start_time = s
					l.end_time = e + 500
					
					local step = i / n
					
					local infad, outfad = syl.duration/4, syl.duration/4
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					local xc, yc = (tlx+brx)/2, (tly+bry)/2
					
					local a = 0
					
					local sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2
					local deform = shape.filter(text_outline,
					function(x,y)
						local vx, vy = x - xc, y - yc
						xdef = 30*math.sin(math.rad(a+10*x)) + math.randomsteps(-20, 20, 2.5)
						ydef = 30*math.sin(math.rad(a+10*y)) + math.randomsteps(-20, 20, 2.5)
						return x+xdef, y+ydef
					end)
					
					a = a + 15
					
					if line.effect == "yel" then
						color_array = {"&H51CBF9&", "&H4B4DE2&"}
						color = color_array[math.random(1,table.getn(color_array))]
					else
						color = color
					end
					
					l.text = string.format("{\\p4\\an7\\blur3\\bord0\\shad0\\fscx100\\fscy100\\1c%s\\fad(250,250)\\pos(%.3f, %.3f)}%s"
					,color,sx,sy,deform)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" and syl.text~=" " then
				
				--syl fx 2
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local tlx, tly, brx, bry = shape.bounding(text_shape)
				
				local max_frame = 100
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 8
					
					l.start_time = s
					l.end_time = e + 300
					
					local step = i / n
					
					local infad, outfad = syl.duration/4, syl.duration/4
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					local xc, yc = (tlx+brx)/2, (tly+bry)/2
					
					local a = 0
					
					local sx, sy = syl.center - syl.width/2, syl.middle - syl.height/2
					local deform = shape.filter(text_shape,
					function(x,y)
						local vx, vy = x - xc, y - yc
						xdef = 15*math.sin(math.rad(a+10*x)) + math.randomsteps(-20, 20, 2.5)
						ydef = 15*math.sin(math.rad(a+10*y)) + math.randomsteps(-20, 20, 2.5)
						return x+xdef, y+ydef
					end)
					
					a = a + 15
					
					l.text = string.format("{\\p4\\an7\\blur0.8\\bord0\\shad0\\fscx100\\fscy100\\alpha&H64&\\1c&HFFFFFF&\\fad(150,150)\\pos(%.3f, %.3f)}%s"
					,sx,sy,deform)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" and line.actor == "hb" then
				
				local rx1, ry1 = math.random(syl.left, syl.right), math.random(syl.top, syl.bottom)
				local rx2, ry2 = math.randomsteps(syl.left, syl.right, 3), math.randomsteps(syl.top, syl.bottom+20, 10)
				local rx3, ry3 = math.randomsteps(syl.left, syl.right, 5), math.randomsteps(syl.top, syl.bottom+10, 5)
				local rx4, ry4 = math.randomsteps(syl.left, syl.right, 2.5), math.randomsteps(syl.top, syl.bottom+25, 9)
				local rx5, ry5 = math.randomsteps(syl.left, syl.right, 3.5), math.randomsteps(syl.top, syl.bottom+35, 7)
				local rx6, ry6 = math.randomsteps(syl.left, syl.right, 4), math.randomsteps(syl.top, syl.bottom, 8)
				
				local clip_src = convert.text_to_shape(syl.text, line.styleref)
				local clip_fix = shape.filter(clip_src,
				function(x,y)
					x = x/8
					y = y/8
					return x, y
				end
				)
				
				local clip = shape.move(clip_fix, syl.left, syl.top)
				
				--horizontal bezier fx
				maxj = syl.width
				for j = 1, maxj, 1 do
					
					local max_frame = 50
					local u_in, u_out = 0, 0
					local a = 0
					
					for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
						
						l.layer = 6
						
						l.start_time = s
						l.end_time = e
						
						local step = i / n
						
						local bx1, by1 = syl.left, syl.middle
						local bx2, by2 = utils.interpolate(step, rx2, rx3), utils.interpolate(step, ry3, ry4)
						local bx3, by3 = utils.interpolate(step, rx3, rx4), utils.interpolate(step, ry3, ry4)
						local bx4, by4 = utils.interpolate(step, rx4, rx5), utils.interpolate(step, ry4, ry5)
						local bx5, by5 = utils.interpolate(step, rx5, rx6), utils.interpolate(step, ry5, ry6)
						local bx6, by6 = syl.right, syl.middle
						
						local bpoint = math.bezier(1/(maxj/j),
						{
						{bx1, by1},
						{bx2, by2},
						{bx3, by3},
						{bx4, by4},
						{bx5, by5},
						{bx6, by6}
						}
						)
						
						local x, y = bpoint[1], bpoint[2]
						
						local infad, outfad = line.infade, line.outfade
						local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
						
						if i < math.ceil(infad/max_frame) then
							alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
							u_in = u_in + 1
						elseif i > (n-math.ceil(outfad/max_frame)) then
							alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
							u_out = u_out + 1
						else
							alpha="&H00&"
						end
						
						l.text = string.format("{\\p1\\an7\\blur1.5\\bord0\\shad0\\fscx200\\fscy200\\alpha%s\\1c&H4B4DE2&\\pos(%.3f,%.3f)}m 0 0 l 1 0 1 1 0 1"
						,alpha,x,y)
						
						io.write_line(l)
					end
				end
			end
		end
	end
	
	if line.style == "TGs2_OP_TL" then
		for ci,char in ipairs(line.chars) do
			if char.text~="" then
				--text outline
				
				l.layer = 4
				
				l.start_time = line.start_time-line.infade+25*char.i-25
				l.end_time = line.end_time+line.outfade+25*char.i-25
				
				local infad = 250
				local of_start = l.end_time-l.start_time-250
				local of_end = l.end_time-l.start_time
				
				l.text = string.format("{\\an5\\bord2\\blur8\\t(0,%d,\\blur3)\\t(%d,%d,\\blur8)\\fad(250,250)\\1a&HFF&\\3c&H4B4DE2&\\pos(%.3f, %.3f)}%s"
				,infad,of_start,of_end,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--text
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade+25*char.i-25
				l.end_time = line.end_time+line.outfade+25*char.i-25
				
				local infad = 250
				local of_start = l.end_time-l.start_time-250
				local of_end = l.end_time-l.start_time
				
				l.text = string.format("{\\an5\\bord0\\blur10\\t(0,%d,\\blur0.8)\\t(%d,%d,\\blur10)\\fscx100\\fscy100\\fad(250,250)\\1c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,infad,of_start,of_end,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end