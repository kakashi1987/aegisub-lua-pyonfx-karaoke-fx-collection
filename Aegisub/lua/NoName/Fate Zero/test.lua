--Fate/kaleid liner PRISMA ILLYA Zwei! combat effects
--Effects by Amberdrake
--VSFilter

function cfx(line, l)
	
	line.infade = 0
	line.outfade = 0
	
	for ci,char in ipairs(line.chars) do
		
		if char.text~="" then
			--cfx trance text
			
			local max_frame = 23.976
			
			local u_in, u_out, u_fx = 0, 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade+50*char.i-50, line.end_time+line.outfade+50*char.i+50, max_frame) do
				
				l.layer = 5
				
				l.start_time = s
				l.end_time = e
				
				local infad, outfad = 100, 250
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				local fx_max = math.ceil((char.end_time-char.start_time)/max_frame)
				
				if i < math.ceil(infad/max_frame) then
					alpha = "&H00&"
					sc = 100
					x, y = utils.interpolate(u_in/inmax, char.left, char.center), char.middle - 15*math.sin(math.rad(utils.interpolate(u_in/inmax, 0, 360)))
					u_in = u_in + 1
				elseif s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
					sc = 100+utils.interpolate(math.sin((s - (line.start_time + char.start_time))/char.duration*math.pi), 0, 20)
					x, y = char.center, char.middle + math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration*math.pi), 1,90)))*10
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					sc = 100
					x, y = utils.interpolate(u_out/outmax, char.center, char.right), char.middle - 15*math.sin(math.rad(utils.interpolate(u_out/outmax, 0, 360)))
					u_out = u_out + 1
				else
					sc = 100
					x, y = char.center, char.middle
					alpha="&H00&"
				end
				
				l.text = string.format("{\\an5\\blur0.6\\bord1.5\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&HF5A0F5&\\3c&H000000&\\4c&H85D0EB&\\pos(%.3f, %.3f)}%s"
				,sc,sc,alpha,x,y,char.text)
				
				io.write_line(l)
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	cfx( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end