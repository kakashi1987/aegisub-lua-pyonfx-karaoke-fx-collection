--Fate/stay night: Unlimited Blade Works ED
--Effects by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 500
	line.outfade = 500
	
	if line.style == "UBW_ED_Romanji" or line.style == "UBW_ED_Kanji" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--text fx
				
				local max_frame = 25
				local u_in, u_out, u_fx = 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time+50*syl.i-line.infade, line.end_time+50*syl.i-line.outfade-100, max_frame) do
					
					l.layer = 6
					
					l.start_time = s
					l.end_time = e
					
					local fad = 250
					local max = math.ceil(fad/max_frame)
					local fx_max = math.ceil((syl.end_time-syl.start_time)/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						sc = 100
						u_in=u_in+1
					elseif i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						sc = 100
						u_out=u_out+1
					elseif s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
						alpha = "&H00&"
						sc = 100 + 20*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 180)))
						u_fx = u_fx + 1
					else
						alpha = "&H00&"
						sc = 100
					end
					
					l.text=string.format("{\\an5\\blur0.6\\bord0\\fscx%.3f\\fscy%.3f\\1c&HFFFFFF&\\3c&H000000&\\alpha%s\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--text bord fx
				
				local max_frame = 25
				local u_in, u_out, u_fx = 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time+50*syl.i-line.infade, line.end_time+50*syl.i-line.outfade-50, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local fad = 250
					local max = math.ceil(fad/max_frame)
					local fx_max = math.ceil((syl.end_time-syl.start_time)/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H64&")
						blur = utils.interpolate(u_in/max, 10, 3.5)
						sc = 100
						u_in=u_in+1
					elseif i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H64&", "&HFF&")
						blur = utils.interpolate(u_out/max, 3.5, 10)
						sc = 100
						u_out=u_out+1
					elseif s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
						alpha = "&H00&"
						sc = 100 + 20*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 180)))
						blur = 3.5
						u_fx = u_fx + 1
					else
						alpha = "&H00&"
						sc = 100
						blur = 3.5
					end
					
					l.text=string.format("{\\an5\\blur%.2f\\bord0.1\\fscx%.3f\\fscy%.3f\\1a&HFF&\\3a%s\\3c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
					,blur,sc,sc,alpha,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
			end
			if syl.text~="" then
				--text fx2
				
				local max_frame = 12
				local a, b = 0, 0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e+500
					
					local step = i / n
					
					local sc = 100 + a
					local be = 1 + b
					a, b = a + 7, b + 5
					
					local y = utils.interpolate(step, syl.middle+2, syl.middle-2)
					
					local color = "&H000000&"
					
					l.text=string.format("{\\an5\\blur3\\bord0\\be%d\\fscx%.3f\\fscy%.3f\\alpha&H96&\\1c%s\\3c&H000000&\\fad(0,250)\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,be,sc,sc,color,syl.center,y+3,syl.center,y-15,syl.text)
					
					io.write_line(l)
				end
			end
		end
	end
	if line.style == "UBW_ED_TL" then
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--text fx
				
				local max_frame = 25
				local u_in, u_out, u_fx = 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time+50*syl.i-line.infade, line.end_time+50*syl.i-line.outfade-100, max_frame) do
					
					l.layer = 6
					
					l.start_time = s
					l.end_time = e
					
					local fad = 250
					local max = math.ceil(fad/max_frame)
					local fx_max = math.ceil((syl.end_time-syl.start_time)/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						u_in=u_in+1
					elseif i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha = "&H00&"
					end
					
					l.text=string.format("{\\an5\\blur0.6\\bord0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&H000000&\\alpha%s\\pos(%.3f,%.3f)}%s"
					,alpha,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--text bord fx
				
				local max_frame = 25
				local u_in, u_out, u_fx = 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time+50*syl.i-line.infade, line.end_time+50*syl.i-line.outfade-50, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local fad = 250
					local max = math.ceil(fad/max_frame)
					local fx_max = math.ceil((syl.end_time-syl.start_time)/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H64&")
						blur = utils.interpolate(u_in/max, 10, 3.5)
						u_in=u_in+1
					elseif i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H64&", "&HFF&")
						blur = utils.interpolate(u_out/max, 3.5, 10)
						u_out=u_out+1
					else
						alpha = "&H00&"
						blur = 3.5
					end
					
					l.text=string.format("{\\an5\\blur%.2f\\bord0.1\\fscx100\\fscy100\\1a&HFF&\\3a%s\\3c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
					,blur,alpha,syl.center,syl.middle,syl.text)
					
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