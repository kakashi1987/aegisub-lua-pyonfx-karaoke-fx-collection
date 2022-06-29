--Trinity Seven ED4
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	for ci,char in ipairs(line.chars) do
		
		if char.text~="" then
			
			local max_frame = 23.976
			
			local u_in, u_out, u_fx = 0, 0, 0
			
			if line.style == "Trinity_ED4_Romaji_L" or line.style == "Trinity_ED4_Kanji_L" then
				line.infade = 25*#line.chars
				line.outfade = 25*#line.chars + 525
				mod = -1
			end
			if line.style == "Trinity_ED4_Romaji_R" or line.style == "Trinity_ED4_Kanji_R" then
				line.infade = 25*#line.chars
				line.outfade = 25*#line.chars
				mod = 1
			end
			
			local rsx, rsy = math.randomsteps(-15, 15, 2.5), math.randomsteps(-15, 15, 2.5)
			
			for s, e, i, n in utils.frames(line.start_time - line.infade + mod*25*char.i + mod*25, line.end_time + line.outfade + mod*25*char.i + mod*25, max_frame) do
				
				l.layer = 5
				
				step = i / n
				
				local infad, outfad = 500, 500
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				local fx_max = math.ceil((char.end_time-char.start_time)/max_frame)
				
				if s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
					x, y = char.center, char.middle
					xm, ym = x + math.random(-10,10), y + math.random(-10,10)
					l.start_time = s
					l.end_time = s + 250
					fad = 250
				elseif i < math.ceil(infad/max_frame) then
					alpha = "&H00&"
					local x1, y1 = char.center, char.middle
					local x2, y2 = char.center + rsx, char.middle + rsy
					x, y = utils.interpolate(u_in/inmax, x2, x1), utils.interpolate(u_in/inmax, y2, y1)
					xm, ym = x, y
					fad = 0
					l.start_time = s
					l.end_time = e
					u_in = u_in + 1
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					local x1, y1 = char.center, char.middle
					local x2, y2 = char.center + rsx, char.middle + rsy
					x, y = utils.interpolate(u_in/inmax, x1, x2), utils.interpolate(u_in/inmax, y1, y2)
					xm, ym = x, y
					fad = 0
					l.start_time = s
					l.end_time = e
					u_out = u_out + 1
				else
					alpha="&H00&"
					x, y = char.center, char.middle
					xm, ym = x, y
					fad = 0
					l.start_time = s
					l.end_time = e
				end
				
				l.text = string.format("{\\b1\\an5\\blur3\\bord1\\1c&HFFFFFF&\\3c&H000000&\\fscx100\\fscy100\\alpha%s\\fad(0,%d)\\move(%.3f, %.3f, %.3f, %.3f)}%s"
				,alpha,fad,x,y,xm,ym,char.text)
				
				io.write_line(l)
			end
		end
	end
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end