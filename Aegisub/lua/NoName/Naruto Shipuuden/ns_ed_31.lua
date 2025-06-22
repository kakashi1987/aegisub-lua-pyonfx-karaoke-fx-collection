function romaji(line, l)
	--Naruto Shippuuden ED 31
	--Karaoke by Amberdrake
	
	if line.infade > 150 then
		line.infade = 150
	end
	if line.outfade > 500 then
		line.outfade = 500
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			
			local max_frame = 24
			local u_in, u_fx ,u_out = 0, 0, 0
			
			for s, e, i, n in utils.frames(line.start_time+20*syl.i-line.infade, line.end_time+20*syl.i+line.outfade, max_frame) do
				
				local step = i / n
				
				if line.i%2 == 0 then
					shift = utils.interpolate(step, 0, -25)
				else
					shift = utils.interpolate(step, 0, 25)
				end
				
				l.layer = 3
				
				l.start_time=s
				l.end_time=e
				
				local fad = 500
				local max=math.ceil(fad/max_frame)
				local fx_max = math.ceil((syl.end_time-syl.start_time)/max_frame)
				if i<math.ceil(fad/max_frame) then
					frx = utils.interpolate(u_in/max, 90, 0)
					alpha = "&H00&"
					sc = 100
					u_in=u_in+1
				elseif i>(n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					frx = 0
					sc = 100
					u_out=u_out+1
				elseif s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
					frx = 0
					alpha = "&H00&"
					sc = 100 + 20*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 180)))
					u_fx = u_fx + 1
				else
					alpha = "&H00&"
					sc = 100
					frx = 0
				end
				
				local x, y = syl.center + shift, syl.middle
				
				l.text=string.format("{\\an5\\blur0.6\\bord1.5\\fscx%.3f\\fscy%.3f\\1c&H3B3130&\\3c&HFFFFFF&\\frx%.3f\\alpha%s\\pos(%.3f,%.3f)}%s"
				,sc,sc,frx,alpha,x,y,syl.text)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			
			local max_frame = 24
			local u_fx1, u_fx2, u_fx3, u_fx4, u_out = 0, 0, 0, 0, 0
			
			for s, e, i, n in utils.frames(line.start_time+20*syl.i-line.infade, line.end_time+20*syl.i+line.outfade, max_frame) do
				
				local step = i / n
				
				if line.i%2 == 0 then
					shift = utils.interpolate(step, 0, -25)
				else
					shift = utils.interpolate(step, 0, 25)
				end
				
				l.layer = 2
				
				l.start_time=s
				l.end_time=e + 100
				
				local fad = 500
				
				local max=math.ceil(fad/max_frame)
				
				local fx1_max = math.ceil(((line.start_time + syl.start_time + syl.duration/4)-(line.start_time+syl.start_time))/max_frame)
				local fx2_max = math.ceil(((line.start_time + syl.start_time + 3*syl.duration/4)-(line.start_time+syl.start_time + syl.duration/4))/max_frame)
				local fx3_max = math.ceil(((line.start_time + syl.start_time + syl.duration)-(line.start_time+syl.start_time + 3*syl.duration/4))/max_frame)
				local fx4_max = math.ceil(((line.end_time - 50*syl.i) - (line.start_time + syl.start_time + syl.duration))/max_frame)
				
				if s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration/4) then
					alpha = "&H00&"
					sc = utils.interpolate(u_fx1/fx1_max, 100, 120)
					u_fx1 = u_fx1 + 1
				elseif s > (line.start_time+syl.start_time + syl.duration/4) and s <= (line.start_time + syl.start_time + 3*syl.duration/4) then
					alpha = "&H00&"
					sc = 120 + 20*math.sin(math.rad(utils.interpolate(u_fx2/fx2_max, 0, 180)))
					u_fx2 = u_fx2 + 1
				elseif s > (line.start_time+syl.start_time + 3*syl.duration/4) and s <= (line.start_time + syl.start_time + syl.duration) then
					alpha = "&H00&"
					sc = utils.interpolate(u_fx3/fx3_max, 120, 100)
					u_fx3 = u_fx3 + 1
				elseif s >= (line.start_time + syl.start_time + syl.duration) and s <= (line.end_time - 50*syl.i) then
					alpha = utils.interpolate(u_fx4/fx4_max, "&H00&", "&HFF&")
					sc = 100
					u_fx4 = u_fx4 + 1
				else
					alpha = "&HFF&"
					sc = 100
				end
				
				local x, y = syl.center + shift, syl.middle
				
				l.text=string.format("{\\an5\\blur0.6\\bord1.5\\fscx%.3f\\fscy%.3f\\1a&HFF&\\3c&HFFFFFF&\\1a&HFF&\\3a%s\\fad(0,100)\\pos(%.3f,%.3f)}%s"
				,sc,sc,alpha,x,y,syl.text)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			
			local max_frame = 24
			local u_in, u_fx, u_out = 0, 0, 0
			
			for s, e, i, n in utils.frames(line.start_time+20*syl.i-line.infade, line.end_time+20*syl.i+line.outfade, max_frame) do
				
				local step = i / n
				
				if line.i%2 == 0 then
					shift = utils.interpolate(step, 0, -25)
				else
					shift = utils.interpolate(step, 0, 25)
				end
				
				l.layer = 1
				
				l.start_time=s
				l.end_time=e
				
				local fad = 500
				local max=math.ceil(fad/max_frame)
				local fx_max = math.ceil((syl.end_time-syl.start_time)/max_frame)
				if i<math.ceil(fad/max_frame) then
					frx = utils.interpolate(u_in/max, 90, 0)
					alpha = "&H00&"
					sc = 100
					u_in=u_in+1
				elseif s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
					frx = 0
					alpha = "&H00&"
					sc = 100 + 20*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 180)))
					u_fx = u_fx + 1
				elseif i>(n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					frx = 0
					sc = 100
					u_out=u_out+1
				else
					alpha = "&H00&"
					frx = 0
					sc = 100
				end
				
				local x, y = syl.center + shift, syl.middle
				
				l.text=string.format("{\\an5\\blur8\\bord0.2\\fscx%.3f\\fscy%.3f\\1c&H3B3130&\\3c&HFFFFFF&\\frx%.3f\\1a&HFF&\\3a%s\\pos(%.3f,%.3f)}%s"
				,sc,sc,frx,alpha,x,y,syl.text)
				
				io.write_line(l)
			end
		end
	end
	
end

for li, line in ipairs(lines) do
	
	romaji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end