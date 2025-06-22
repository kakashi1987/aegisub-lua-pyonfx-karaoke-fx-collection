--Fate/Apocrypha ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.actor == "fx1" then
		
		line.infade = 500
		line.outfade = 500
		
		for si,syl in ipairs(line.syls) do
			
			local rx_dist, ry_dist = utils.distributor({-0.2, 0.1, 0.15, -0.75, 0.3, 0.1, -0.2, 0, 0.75, -1, 0.5, -0.3, -0.1, 0.2}), utils.distributor({0.1, -0.25, 0.3, 0, -0.5, -1, 0.25, -0.3, 0.1, -0.25})
			
			if syl.text~="" then
				
				local max_frame = 100
				
				local u_in, u_out = 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+math.randomsteps(-350, -150, 50), line.end_time+line.outfade-math.randomsteps(150, 350, 50), max_frame) do
					
					local step = i / n
					
					local fad = 500
					local max=math.ceil(fad/max_frame)
					
					if i<math.ceil(fad/max_frame) then
						l.start_time = s
						l.end_time = e
						l.layer = 8
						alpha_array = {"&HFF&" , "&HFF&" , "&H32&" , "&H64&" , "&HFF&" }
						alpha = alpha_array[math.random(1,table.getn(alpha_array))]
						blur, bord = 5, 2
						sc = 100
						x, y = syl.center, syl.middle
						orgx, orgy = line.center, line.middle
						fad = 0
						u_in=u_in+1
					elseif i>(n-math.ceil(fad/max_frame)) then
						l.start_time = s
						l.end_time = e
						l.layer = 5
						alpha_array = {"&H96&" , "&HFF&" , "&H32&" , "&H64&" , "&HFF&" }
						alpha = alpha_array[math.random(1,table.getn(alpha_array))]
						blur, bord = 5, 2
						sc = 100
						x, y = syl.center, syl.middle
						orgx, orgy = line.center, line.middle
						fad = 0
						u_out=u_out+1
					elseif s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
						l.start_time = s
						l.end_time = e + 250
						l.layer = 10
						alpha = "&H00&"
						blur, bord = 5 + math.random(-1, 3), 2 + math.random(-1, 3)
						x, y = syl.center + math.randomsteps(-3, 1, 0.5), syl.middle + math.randomsteps(-3, 1, 0.25)
						orgx, orgy = line.center + math.random(-2, 2), line.middle + math.random(-2, 2)
						sc = 125 + math.randomsteps(-5, 5, 2.5)
						fad = 250
					else
						l.start_time = s
						l.end_time = e
						l.layer = 6
						alpha_array = {"&H16&" , "&H00&" , "&H00&" , "&H16&" , "&H00&", "&H16&" }
						alpha = alpha_array[math.random(1,table.getn(alpha_array))]
						blur, bord = 5, 2
						sc = 100
						orgx, orgy = line.center, line.middle
						fad = 0
					end
					
					local rx, ry = rx_dist:get(), ry_dist:get()
					
					l.text=string.format("{\\an5\\blur%d\\bord%d\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&HFFFFF4&\\3c&H3535B3&\\fad(0,%d)\\org(%.3f,%.3f)\\pos(%.3f,%.3f)}%s"
					,blur,bord,sc,sc,alpha,fad,orgx,orgy,x+rx,y+ry,syl.text)
					
					io.write_line(l)
				end
			end
		end
	end
	
	if line.actor == "fx2" then
		
		line.infade = 1000
		line.outfade = 1000
		
		for ci,char in ipairs(line.chars) do
			
			local rd_frz = math.randomsteps(-15, 15, 5)
			
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
						frx, fry, frz = 0, 0, utils.interpolate(u_fx/fxmax, rd_frz, 0)
						sc, bord, blur = utils.interpolate(u_fx/fxmax, 135, 100), 1+2*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180))), 1.5+2*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180)))
						u_fx = u_fx + 1
					elseif i < math.ceil(infad/max_frame) then
						l.layer = 4
						alpha = "&H00&"
						x, y = utils.interpolate(u_in/inmax, xshift + line.width/2, xshift), char.middle
						frx, fry, frz = utils.interpolate(u_in/inmax, rrx1, 0), utils.interpolate(u_in/inmax, rry1, 0), utils.interpolate(u_in/inmax, rrz1, 0)
						sc, bord, blur = 100, 1, 1.5
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						l.layer = 3
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						x, y = utils.interpolate(u_out/outmax, xshift, xshift - line.width/2), char.middle
						frx, fry, frz = utils.interpolate(u_out/outmax, 0, rrx2), utils.interpolate(u_out/outmax, 0, rry2), utils.interpolate(u_out/outmax, 0, rrz2)
						sc, bord, blur = 100, 1, 1.5
						u_out = u_out + 1
					else
						l.layer = 5
						x, y = xshift, char.middle
						alpha= "&H00&"
						frx, fry, frz = 0, 0, 0
						sc, bord, blur = 100, 1, 1.5
					end
					
					l.text = string.format("{\\b1\\an5\\bord%.2f\\blur%.2f\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\alpha%s\\1c&HFCA543&\\3c&HFCA543&\\pos(%.3f, %.3f)}%s"
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
						frx, fry, frz = 0, 0, utils.interpolate(u_fx/fxmax, rd_frz, 0)
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
					
					l.text = string.format("{\\b1\\an5\\bord0\\blur1\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\alpha%s\\1c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,sc,sc,frx,fry,frz,alpha,x,y,char.text)
					
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