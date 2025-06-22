--Fate Project - First & Next Order ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 2500
	line.outfade = 250
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--text fx
			
			local max_frame = 23.976
			local u_in, u_out, u_fx = 0, 0, 0
			local rd_start = math.randomsteps(-500, 500, 25)
			local rd_if_fx = math.randomsteps (0, syl.start_time, 100)
			local frx_start, fry_start, frz_start = math.randomsteps(-360, 360, 30), math.randomsteps(-360, 360, 30), math.randomsteps(-360, 360, 30)
			local y_start = syl.middle + math.random(-50,50)
			if line.actor == "red" then
				bord_col = "&H090ABE&"
			end
			if line.actor == "blue" then
				bord_col = "&HFFCE85&"
			end
			
			for s, e, i, n in utils.frames(line.start_time-line.infade+rd_start, line.end_time+line.outfade+25*syl.i-25, max_frame) do
				
				l.start_time = s
				
				step = i / n
				
				local infad, outfad = 2500, 500
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				local fx_max = math.ceil((syl.end_time-syl.start_time)/max_frame)
				
				if i < math.ceil(infad/max_frame) and s < (line.start_time+syl.start_time-rd_if_fx) then
					l.layer = 5
					l.end_time = e + 100
					fad = 100
					alpha = "&H00&"
					sc = 100
					blur, bord = 3, 1
					frx, fry, frz = utils.interpolate(u_in/inmax, frx_start, 0), utils.interpolate(u_in/inmax, fry_start, 0), utils.interpolate(u_in/inmax, frz_start, 0)
					x, y = utils.interpolate(u_in/inmax, syl.left-250, syl.center), utils.interpolate(u_in/inmax, y_start, syl.middle)
					u_in = u_in + 1
				elseif s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
					l.layer = 9
					l.end_time = e + 500
					fad = 500
					sc = 100 + utils.interpolate(math.sin((s - (line.start_time + syl.start_time))/syl.duration*math.pi), 0, 25)
					blur, bord = 3, 1
					frx, fry, frz = 0, 0, 0
					x = syl.center + math.sin(math.rad(utils.interpolate((s - (line.start_time + syl.start_time)/syl.duration*math.pi), 1,90)))*3
					y = syl.middle + math.sin(math.rad(utils.interpolate((s - (line.start_time + syl.start_time)/syl.duration*math.pi), 1,45)))*5
				elseif i > (n-math.ceil(outfad/max_frame)) then
					l.layer = 4
					l.end_time = e + 250
					fad = 250
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					sc = 100
					blur, bord = utils.interpolate(u_out/outmax, 3, 6), utils.interpolate(u_out/outmax, 1, 3)
					frx, fry, frz = 0, 0, 0
					x, y = utils.interpolate(u_out/outmax, syl.center, syl.right), syl.middle - 15*math.sin(math.rad(utils.interpolate(u_out/outmax, 0, 360)))
					u_out = u_out + 1
				else
					l.layer = 6
					l.end_time = e + 100
					fad = 100
					sc = 100
					blur, bord = 3, 1
					frx, fry, frz = 0, 0, 0
					x, y = syl.center + math.randomsteps(-0.2, 0.2, 0.01), syl.middle + math.randomsteps(-0.2, 0.2, 0.01)
					alpha="&H00&"
				end
				
				l.text = string.format("{\\b1\\an5\\blur%.3f\\bord%.3f\\shad0\\fscx%d\\fscy%d\\frx%d\\fry%d\\frz%d\\alpha%s\\1c&HFFFFFF&\\3c%s\\fad(0,%d)\\pos(%.3f, %.3f)}%s"
				,blur,bord,sc,sc,frx,fry,frz,alpha,bord_col,fad,x,y,syl.text)
				
				io.write_line(l)
			end
		end
		
	end
	
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end