--Hunter X Hunter: Last Mission ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.infade < 150 then
		line.infade = 50
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	if line.outfade < 150 then
		line.outfade = 50
	end
	
	for ci,char in ipairs(line.chars) do
		
		if char.text~="" then
			--text fx
			
			local max_frame = 23.976
			
			local u_in, u_out, u_fx = 0, 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade+50*char.i-50, line.end_time+line.outfade+50*char.i-50, max_frame) do
				
				l.layer = 5
				
				l.start_time = s
				l.end_time = e
				
				step = i / n
				
				local infad, outfad = 250, 250
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				local fx_max = math.ceil((char.end_time-char.start_time)/max_frame)
				
				if i < math.ceil(infad/max_frame) then
					alpha = "&H00&"
					sc = 100
					x, y = utils.interpolate(u_in/inmax, char.left, char.center), char.middle - 15*math.sin(math.rad(utils.interpolate(u_in/inmax, 0, 360)))
					u_in = u_in + 1
				elseif s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
					sc = 100+utils.interpolate(math.sin((s - (line.start_time + char.start_time))/char.duration*math.pi), 0, 35)
					x, y = char.center, char.middle + math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration*math.pi), 1,45)))*5
				elseif s > (line.start_time + char.start_time + char.duration) and i <= (n-math.ceil(outfad/max_frame)) then
					sc = 100
					x, y = char.center, char.middle + math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration*math.pi), 1,45)))*0.5
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
				
				l.text = string.format("{\\b1\\an5\\blur0.6\\bord0\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,sc,sc,alpha,x,y,char.text)
				
				io.write_line(l)
			end
		end
	end
	
	for si,syl in ipairs(line.syls) do
		
		local text_to_shape = convert.text_to_shape(syl.text, line.styleref)
		local split_shape = shape.split(text_to_shape, 1)
		local shape_outline = shape.tooutline(split_shape, 1)
		
		if syl.text~="" then
			
			for pi, pixel in ipairs(convert.shape_to_pixels(shape_outline)) do
				
				l.layer = 4
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\b1\\an5\\blur0.6\\bord0\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\pos(%.3f, %.3f)}m 0 0 l 1 0 1 1 0 1"
				,syl.center,syl.middle)
				
				io.write_line(l)
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara(line, table.copy(line) )
	
	io.progressbar(li / #lines)
end