--Dragon Ball Kai (2014) ED3
--Effects by Amberdrake
--VSFilter

function kara(line, l)
	if line.style == "DBK_ED_Romaji" then
		
		if line.infade > 500 then
			line.infade = 500
		end
		if line.outfade > 500 then
			line.outfade = 500
		end
		
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				
				local max_frame = 23.976
				local u_in, u_out, u_fx = 0, 0, 0
				local a, b, c, d = 0, 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time+50*char.i-50-line.infade-500, line.end_time+50*char.i-50+line.outfade, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local infad, outfad = 500, 500
					local inmax, outmax, fxmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame), math.ceil((char.end_time-char.start_time)/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						x, y = utils.interpolate(u_in/inmax, line.right, char.center), char.middle+35*math.sin(math.rad(utils.interpolate(u_in/inmax, 0, 360)))
						orgx, orgy = char.center, char.middle
						frz = 0
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						x, y = utils.interpolate(u_out/outmax, char.center, line.left), char.middle+35*math.sin(math.rad(utils.interpolate(u_out/outmax, 0, 360)))
						orgx, orgy = char.center, char.middle
						frz = 0
						u_out = u_out + 1
					elseif s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
						alpha="&H00&"
						x, y = char.center, utils.interpolate(u_fx/fxmax ,char.middle-10, char.middle+10)
						orgx, orgy = char.center + 15*math.sin(math.rad(d)), char.middle + 15*math.sin(math.rad(d))
						frz = 0 + 15*math.sin(math.rad(b))
						u_fx = u_fx + 1
						b = b + 60
						d = d + math.random(1, 5)
					else
						alpha="&H00&"
						x, y = char.center, char.middle + math.sin(math.rad(a))
						frz = 0
						color = "&HFFFFFF&"
						orgx, orgy = char.center, char.middle
						a = a + 30
					end
					
					local pct = math.abs(math.sin(math.rad(c)))
					local color = utils.interpolate(pct, "&H0BA4ED&", "&H12FFF4&")
					c = c + 5
					
					l.text = string.format("{\\an5\\blur2\\bord3\\shad0\\fscx100\\fscy100\\frz%.3f\\1c%s\\3c&H000000&\\alpha%s\\pos(%.3f, %.3f)\\org(%.3f,%.3f)}%s"
					,frz,color,alpha,x,y,orgx,orgy,char.text)
					
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