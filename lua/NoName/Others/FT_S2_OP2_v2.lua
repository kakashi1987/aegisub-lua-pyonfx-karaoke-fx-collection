--Fairy Tail (2014) OP 2 v2
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	
	if line.infade > 500 then
		line.infade = 200
	end
	if line.infade < 150 then
		line.infade = 150
	end
	if line.outfade > 500 then
		line.outfade = 500
	end
	if line.outfade < 150 then
		line.outfade = 150
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--fx 1
			
			local max_frame = 23.976
			
			local u_in, u_out, u_fx = 0, 0, 0
			local a, b = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				l.layer = 10
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				if line.i%2 == 0 then
					xshift = utils.interpolate(step, 0, -50)
					yshift = utils.interpolate(step, 0, 25)
					mod = 1
				else
					xshift = utils.interpolate(step, 0, 50)
					yshift = utils.interpolate(step, 0, -25)
					mod = -1
				end
				
				local infad, outfad = line.infade, line.outfade
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				local fx_max = math.ceil((syl.end_time-syl.start_time)/max_frame)
				
				if i < math.ceil(infad/max_frame) then
					alpha = "&H00&"
					sc = 100 + math.random(-5,5)
					x, y = utils.interpolate(u_in/inmax, syl.left, syl.center) + xshift, syl.middle - 15*math.sin(math.rad(utils.interpolate(u_in/inmax, 0, 360))) + yshift
					blur = 1.5
					bord = 2
					frz = 0
					u_in = u_in + 1
				elseif i >= math.ceil(syl.start_time/max_frame) and i <= math.ceil(syl.end_time/max_frame) then
					if line.actor == "sing" then
						sc = 100+20*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 180)))
						if syl.i%2 == 0 then
							frz = 10*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 360)))
						else
							frz = -10*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 360)))
						end
						x, y = syl.center + xshift, syl.middle + mod*10*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 180))) + yshift
					end
					if line.actor == "rap" then
						sc = 130 - utils.interpolate(u_fx/fx_max, 0, 20) + 20*math.sin(math.rad(a)) + 8*math.sin(math.rad(b))
						x, y = syl.center + xshift, syl.middle + yshift
						frz = 0
					end
					blur = 1.5
					bord = 5*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 180))) + math.random(-3,3)
					a, b = a + 60, b + 90
					u_fx = u_fx + 1
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					sc = 100 + math.random(-5,5)
					x, y = utils.interpolate(u_out/outmax, syl.center, syl.right) + xshift, syl.middle - 15*math.sin(math.rad(utils.interpolate(u_out/outmax, 0, 360))) + yshift
					blur = 1.5
					bord = 2
					frz = 0
					u_out = u_out + 1
				else
					sc = 100 + math.random(-5,5)
					x, y = syl.center + xshift, syl.middle + yshift
					blur = 1.5
					bord = 2
					frz = 0
					alpha="&H00&"
				end
				
				l.text = string.format("{\\an5\\blur%.3f\\bord%.3f\\shad0\\fscx%d\\fscy%d\\frz%.3f\\alpha%s\\1c&HFFFDF6&\\3c&HFF0000&\\pos(%.3f, %.3f)}%s"
				,bord,blur,sc,sc,frz,alpha,x,y,syl.text)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--layer 1
			local L1 = shape.ellipse(70,70)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				l.layer=3
				
				l.start_time=s
				l.end_time=e
				
				local step = i / n
				
				if line.i%2 == 0 then
					xs = line.left - 30
					xshift = utils.interpolate(step, 0, -50)
					yshift = utils.interpolate(step, 0, 25)
					mod = 1
				else
					xs = line.right + 30
					xshift = utils.interpolate(step, 0, 50)
					yshift = utils.interpolate(step, 0, -25)
					mod = -1
				end
				
				local x, y = xs + xshift, line.middle - 5 + yshift
				
				local fad = 250
				local max = math.ceil(fad/max_frame)
				if i < math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H64&")
					color = utils.interpolate(u_in/max, "&HFFFFFF&", "&HFF0000&")
					u_in = u_in + 1
				elseif i > (n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H64&", "&HFF&")
					color = utils.interpolate(u_in/max, "&HFF0000&", "&H000000&")
					u_out = u_out + 1
				else
					alpha = "&H64&"
					color = "&HFF0000&"
				end
				l.text=string.format("{\\p1\\an5\\blur3\\bord0\\fscx50\\fscy50\\alpha%s\\1c%s\\pos(%.3f, %.3f)}%s"
				,alpha,color,x,y,L1)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--layer 2
			local L2 = shape.ellipse(60,60)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				l.layer=4
				
				l.start_time=s
				l.end_time=e
				
				local step = i / n
				
				if line.i%2 == 0 then
					xs = line.left - 30
					xshift = utils.interpolate(step, 0, -50)
					yshift = utils.interpolate(step, 0, 25)
					mod = 1
				else
					xs = line.right + 30
					xshift = utils.interpolate(step, 0, 50)
					yshift = utils.interpolate(step, 0, -25)
					mod = -1
				end
				
				local x, y = xs + xshift, line.middle - 5 + yshift
				
				local fad = 250
				local max = math.ceil(fad/max_frame)
				if i < math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
					u_in = u_in + 1
				elseif i > (n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					u_out = u_out + 1
				else
					alpha = "&H00&"
				end
				l.text=string.format("{\\p1\\an5\\blur0.8\\bord0\\fscx50\\fscy50\\alpha%s\\1c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,alpha,x,y,L2)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--layer 3
			local L3 = shape.ellipse(5,5)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				l.layer=5
				
				l.start_time=s
				l.end_time=e
				
				local step = i / n
				
				if line.i%2 == 0 then
					xs = line.left - 30
					xshift = utils.interpolate(step, 0, -50)
					yshift = utils.interpolate(step, 0, 25)
					mod = 1
				else
					xs = line.right + 30
					xshift = utils.interpolate(step, 0, 50)
					yshift = utils.interpolate(step, 0, -25)
					mod = -1
				end
				
				local x, y = xs + xshift, line.middle - 5 + yshift
				
				local fad = 250
				local max = math.ceil(fad/max_frame)
				if i < math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
					u_in = u_in + 1
				elseif i > (n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					u_out = u_out + 1
				else
					alpha = "&H00&"
				end
				l.text=string.format("{\\p1\\an5\\blur0.2\\bord0\\fscx50\\fscy50\\alpha%s\\1c&H000000&\\pos(%.3f, %.3f)}%s"
				,alpha,x,y,L3)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--hand 1
			
			local hand = shape.star(2, 5, 25)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			local rs = math.random(-720, -360)
			local re = rs + math.randomsteps(360, 720, 60)
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				l.layer=6
				
				l.start_time=s
				l.end_time=e
				
				local step = i / n
				
				if line.i%2 == 0 then
					xs = line.left - 30
					xshift = utils.interpolate(step, 0, -50)
					yshift = utils.interpolate(step, 0, 25)
					mod = 1
				else
					xs = line.right + 30
					xshift = utils.interpolate(step, 0, 50)
					yshift = utils.interpolate(step, 0, -25)
					mod = -1
				end
				
				local x, y = xs + xshift, line.middle - 5 + yshift
				
				local frz = utils.interpolate(step, rs, re)
				
				local fad = 250
				local max = math.ceil(fad/max_frame)
				if i < math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
					color = utils.interpolate(u_in/max, "&HFFFFFF&", "&HFF0000&")
					u_in = u_in + 1
				elseif i > (n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					color = utils.interpolate(u_in/max, "&HFF0000&", "&H000000&")
					u_out = u_out + 1
				else
					alpha = "&H00&"
					color = "&HFF0000&"
				end
				
				l.text=string.format("{\\p1\\an8\\blur0.2\\bord0\\fscx20\\fscy18\\frz%.3f\\alpha%s\\1c%s\\pos(%.3f, %.3f)\\org(%.3f, %.3f)}%s"
				,frz,alpha,color,x,y,x,y,hand)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--hand 2
			
			local hand = shape.star(2, 5, 25)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			local rs = math.randomsteps(-720, -360, 30)
			local re = rs + math.randomsteps(1440, 2880, 80)
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				l.layer=6
				
				l.start_time=s
				l.end_time=e
				
				local step = i / n
				
				if line.i%2 == 0 then
					xs = line.left - 30
					xshift = utils.interpolate(step, 0, -50)
					yshift = utils.interpolate(step, 0, 25)
					mod = 1
				else
					xs = line.right + 30
					xshift = utils.interpolate(step, 0, 50)
					yshift = utils.interpolate(step, 0, -25)
					mod = -1
				end
				
				local x, y = xs + xshift, line.middle - 5 + yshift
				
				local frz = utils.interpolate(step, rs, re)
				
				local fad = 250
				local max = math.ceil(fad/max_frame)
				if i < math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
					color = utils.interpolate(u_in/max, "&HFFFFFF&", "&HFF0000&")
					u_in = u_in + 1
				elseif i > (n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					color = utils.interpolate(u_in/max, "&HFF0000&", "&H000000&")
					u_out = u_out + 1
				else
					alpha = "&H00&"
					color = "&HFF0000&"
				end
				
				l.text=string.format("{\\p1\\an8\\blur0.2\\bord0\\fscx25\\fscy25\\frz%.3f\\alpha%s\\1c%s\\pos(%.3f, %.3f)\\org(%.3f, %.3f)}%s"
				,frz,alpha,color,x,y,x,y,hand)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--particle
			local shape_source = shape.ellipse(250,250)
			local source_split = shape.split(shape_source, 1)
			local source_outline = shape.tooutline(source_split, 1)
			local particle = shape.star(4,2,4)
			local tlx, tly, brx, bry = shape.bounding(source_outline)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				local fad = 250
				local max = math.ceil(fad/max_frame)
				if i < math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
					u_in = u_in + 1
				elseif i > (n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					u_out = u_out + 1
				else
					alpha = "&H00&"
				end
				
				for pi, pixel in ipairs(convert.shape_to_pixels(source_outline)) do
					
					l.layer=1
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					if line.i%2 == 0 then
						xs = line.left - 14
						xshift = utils.interpolate(step, 0, -50)
						yshift = utils.interpolate(step, 0, 25)
						mod = 1
					else
						xs = line.right + 46
						xshift = utils.interpolate(step, 0, 50)
						yshift = utils.interpolate(step, 0, -25)
						mod = -1
					end
					
					local width, height = (tlx+brx)/8, (tly+bry)/8
					
					local x, y = xs + pixel.x + xshift + math.randomsteps(-1, 1, 0.1) - width, line.middle + pixel.y + yshift + math.randomsteps(-1, 1, 0.1) - height + 11
					
					local sc = math.randomsteps(200, 300, 100)
					
					l.text=string.format("{\\p1\\an5\\blur3\\bord0.1\\fscx%d\\fscy%d\\alpha%s\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}m 0 0 l 1 0 1 1 0 1"
					,sc,sc,alpha,x,y)
					
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