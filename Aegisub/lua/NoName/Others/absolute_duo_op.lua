--Fate Project - First & Next Order ED
--Karaoke by Amberdrake
--VSFilterM

function kara(line, l)
	
	line.infade = 250
	line.outfade = 250
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--text fx
			
			local max_frame = 23.976
			
			local u_in, u_out, u_fx = 0, 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade+25*syl.i-25, line.end_time+line.outfade+25*syl.i-25, max_frame) do
				
				l.layer = 5
				
				l.start_time = s
				l.end_time = e
				
				step = i / n
				
				local infad, outfad = 250, 250
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				local fx_max = math.ceil((syl.end_time-syl.start_time)/max_frame)
				
				if i < math.ceil(infad/max_frame) then
					alpha = "&H00&"
					sc = 100
					x, y = utils.interpolate(u_in/inmax, syl.left, syl.center), syl.middle - 15*math.sin(math.rad(utils.interpolate(u_in/inmax, 0, 360)))
					u_in = u_in + 1
				elseif s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
					sc = 100+utils.interpolate(math.sin((s - (line.start_time + syl.start_time))/syl.duration*math.pi), 0, 35)
					x, y = syl.center, syl.middle + math.sin(math.rad(utils.interpolate((s - (line.start_time + syl.start_time)/syl.duration*math.pi), 1,45)))*5
				elseif s > (line.start_time + syl.start_time + syl.duration) and i <= (n-math.ceil(outfad/max_frame)) then
					sc = 100
					x, y = syl.center, syl.middle + math.sin(math.rad(utils.interpolate((s - (line.start_time + syl.start_time)/syl.duration*math.pi), 1,45)))*0.5
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					sc = 100
					x, y = utils.interpolate(u_out/outmax, syl.center, syl.right), syl.middle - 15*math.sin(math.rad(utils.interpolate(u_out/outmax, 0, 360)))
					u_out = u_out + 1
				else
					sc = 100
					x, y = syl.center, syl.middle
					alpha="&H00&"
				end
				
				l.text = string.format("{\\b1\\an5\\blur0.6\\bord3\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&HFFFFFF&\\3c%s\\pos(%.3f, %.3f)}%s"
				,sc,sc,alpha,bord_col,x,y,syl.text)
				
				io.write_line(l)
			end
		end
		
	end
	
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end