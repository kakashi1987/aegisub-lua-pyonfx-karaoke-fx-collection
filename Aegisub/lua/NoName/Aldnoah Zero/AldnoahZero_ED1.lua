--Aldnoah Zero ED1
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 1000
	line.outfade = 1000
	
	if line.style == "Aldnoah_ED1_Romaji" or line.style == "Aldnoah_ED1_Romaji_alt" then
		
		for ci,char in ipairs(line.chars) do
			
			local rrx1, rry1, rrz1 = math.randomsteps(-180, 180, 5), math.randomsteps(-180, 180, 5), math.randomsteps(-180, 180, 5)
			local rrx2, rry2, rrz2 = math.randomsteps(-180, 180, 5), math.randomsteps(-180, -180, 5), math.randomsteps(-180, -180, 5)
			
			if char.text~="" then
				--layer 1
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+25*char.i-25+12*char.i, line.end_time+line.outfade+25*char.i-25-12*#line.chars, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					step = i / n
					
					local infad, outfad = 1000, 1000
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fxmax = math.ceil((char.end_time-char.start_time)/max_frame)
					
					local xshift = char.center + n/4 - a
					a = a + 0.25
					
					if s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
						l.layer = 6
						x, y = xshift, char.middle
						frx, fry, frz = 0, 0, 0
						sc, bord, blur = utils.interpolate(u_fx/fxmax, 135, 100), 5+4*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180))), 3+3*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180)))
						u_fx = u_fx + 1
					elseif i < math.ceil(infad/max_frame) then
						l.layer = 4
						alpha = "&H00&"
						x, y = utils.interpolate(u_in/inmax, xshift + line.width/2, xshift), char.middle
						frx, fry, frz = utils.interpolate(u_in/inmax, rrx1, 0), utils.interpolate(u_in/inmax, rry1, 0), utils.interpolate(u_in/inmax, rrz1, 0)
						sc, bord, blur = 100, 5, 3
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						l.layer = 3
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						x, y = utils.interpolate(u_out/outmax, xshift, xshift - line.width/2), char.middle
						frx, fry, frz = utils.interpolate(u_out/outmax, 0, rrx2), utils.interpolate(u_out/outmax, 0, rry2), utils.interpolate(u_out/outmax, 0, rrz2)
						sc, bord, blur = 100, 5, 3
						u_out = u_out + 1
					else
						l.layer = 5
						x, y = xshift, char.middle
						alpha="&H00&"
						frx, fry, frz = 0, 0, 0
						sc, bord, blur = 100, 5, 3
					end
					
					l.text = string.format("{\\b1\\an5\\bord%.2f\\blur%.2f\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\alpha%s\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,bord,blur,sc,sc,frx,fry,frz,alpha,x,y,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--layer 2
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+25*char.i-25+12*char.i, line.end_time+line.outfade+25*char.i-25-12*#line.chars, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					step = i / n
					
					local infad, outfad = 1000, 1000
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fxmax = math.ceil((char.end_time-char.start_time)/max_frame)
					
					local xshift = char.center + n/4 - a
					
					if s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
						l.layer = 8
						x, y = xshift, char.middle
						frx, fry, frz = 0, 0, 0
						sc = utils.interpolate(u_fx/fxmax, 130, 100)
						u_fx = u_fx + 1
					elseif i < math.ceil(infad/max_frame) then
						l.layer = 4
						alpha = "&H00&"
						x, y = utils.interpolate(u_in/inmax, xshift + line.width/2, xshift), char.middle
						frx, fry, frz = utils.interpolate(u_in/inmax, rrx1, 0), utils.interpolate(u_in/inmax, rry1, 0), utils.interpolate(u_in/inmax, rrz1, 0)
						sc = 100
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						l.layer = 3
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						x, y = utils.interpolate(u_out/outmax, xshift, xshift - line.width/2), char.middle
						frx, fry, frz = utils.interpolate(u_out/outmax, 0, rrx2), utils.interpolate(u_out/outmax, 0, rry2), utils.interpolate(u_out/outmax, 0, rrz2)
						sc = 100
						u_out = u_out + 1
					else
						l.layer = 5
						x, y = xshift, char.middle
						alpha="&H00&"
						frx, fry, frz = 0, 0, 0
						sc = 100
					end
					
					a = a + 0.25
					
					l.text = string.format("{\\b1\\an5\\bord0\\blur1\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\alpha%s\\1c&HF88FBE&\\pos(%.3f, %.3f)}%s"
					,sc,sc,frx,fry,frz,alpha,x,y,char.text)
					
					io.write_line(l)
				end
			end
		end
	end
	
	if line.style == "Aldnoah_ED1_TL" or line.style == "Aldnoah_ED1_TL_alt" then
		
		for ci,char in ipairs(line.chars) do
			
			local rrx1, rry1, rrz1 = math.randomsteps(-180, 180, 5), math.randomsteps(-180, 180, 5), math.randomsteps(-180, 180, 5)
			local rrx2, rry2, rrz2 = math.randomsteps(-180, 180, 5), math.randomsteps(-180, -180, 5), math.randomsteps(-180, -180, 5)
			
			if char.text~="" then
				--layer 1
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+25*char.i-25+12*char.i, line.end_time+line.outfade+25*char.i-25-12*#line.chars, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					step = i / n
					
					local infad, outfad = 1000, 1000
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fxmax = math.ceil((char.end_time-char.start_time)/max_frame)
					
					local xshift = char.center + n/4 - a
					a = a + 0.25
					
					if i < math.ceil(infad/max_frame) then
						l.layer = 4
						alpha = "&H00&"
						x, y = utils.interpolate(u_in/inmax, xshift + line.width/4, xshift), char.middle
						frx, fry, frz = utils.interpolate(u_in/inmax, rrx1, 0), utils.interpolate(u_in/inmax, rry1, 0), utils.interpolate(u_in/inmax, rrz1, 0)
						sc, bord, blur = 100, 5, 3
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						l.layer = 3
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						x, y = utils.interpolate(u_out/outmax, xshift, xshift - line.width/4), char.middle
						frx, fry, frz = utils.interpolate(u_out/outmax, 0, rrx2), utils.interpolate(u_out/outmax, 0, rry2), utils.interpolate(u_out/outmax, 0, rrz2)
						sc, bord, blur = 100, 5, 3
						u_out = u_out + 1
					else
						l.layer = 5
						x, y = xshift, char.middle
						alpha="&H00&"
						frx, fry, frz = 0, 0, 0
						sc, bord, blur = 100, 5, 3
					end
					
					l.text = string.format("{\\b1\\an5\\bord%.2f\\blur%.2f\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\alpha%s\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,bord,blur,sc,sc,frx,fry,frz,alpha,x,y,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--layer 2
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+25*char.i-25+12*char.i, line.end_time+line.outfade+25*char.i-25-12*#line.chars, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					step = i / n
					
					local infad, outfad = 1000, 1000
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fxmax = math.ceil((char.end_time-char.start_time)/max_frame)
					
					local xshift = char.center + n/4 - a
					
					if i < math.ceil(infad/max_frame) then
						l.layer = 4
						alpha = "&H00&"
						x, y = utils.interpolate(u_in/inmax, xshift + line.width/4, xshift), char.middle
						frx, fry, frz = utils.interpolate(u_in/inmax, rrx1, 0), utils.interpolate(u_in/inmax, rry1, 0), utils.interpolate(u_in/inmax, rrz1, 0)
						sc = 100
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						l.layer = 3
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						x, y = utils.interpolate(u_out/outmax, xshift, xshift - line.width/4), char.middle
						frx, fry, frz = utils.interpolate(u_out/outmax, 0, rrx2), utils.interpolate(u_out/outmax, 0, rry2), utils.interpolate(u_out/outmax, 0, rrz2)
						sc = 100
						u_out = u_out + 1
					else
						l.layer = 5
						x, y = xshift, char.middle
						alpha="&H00&"
						frx, fry, frz = 0, 0, 0
						sc = 100
					end
					
					a = a + 0.25
					
					l.text = string.format("{\\b1\\an5\\bord0\\blur1\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\alpha%s\\1c&HF88FBE&\\pos(%.3f, %.3f)}%s"
					,sc,sc,frx,fry,frz,alpha,x,y,char.text)
					
					io.write_line(l)
				end
			end
		end
	end
end

for li, line in ipairs(lines) do
	
	kara(line, table.copy(line) )
	
	io.progressbar(li / #lines)
end