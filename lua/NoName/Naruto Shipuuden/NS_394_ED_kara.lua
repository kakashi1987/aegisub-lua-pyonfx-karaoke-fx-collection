--Naruto Shippuuden 394+ ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 500
	end
	if line.outfade > 500 then
		line.outfade = 500
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			local max_frame = 23.976
			
			local u_in, u_out, u_fx = 0, 0, 0
			
			local a = 0
			
			for s, e, i, n in utils.frames(line.start_time-250+50*syl.i, line.end_time+250+50*syl.i, max_frame) do
				
				l.start_time = s
				l.end_time = e
				
				local infad, outfad = 250, 250
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				local fx_max = math.ceil((syl.end_time-syl.start_time)/max_frame)
				
				if s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
					l.layer = 9
					scx, scy = utils.interpolate(u_fx/fx_max, 150, 100), utils.interpolate(u_fx/fx_max, 170, 120)
					x, y = syl.center, syl.middle + 7*math.sin(math.rad(utils.interpolate(u_fx/fx_max, 0, 360)))
					frz = 10*math.sin(math.rad(a))
					u_fx = u_fx + 1
					a = a + 90
				elseif i < math.ceil(infad/max_frame) then
					l.layer = 8
					alpha = "&H00&"
					scx, scy = 100, 120
					x, y = syl.center + (utils.interpolate(u_in/inmax, 30*math.sin(math.rad(45*syl.i)), 0)), syl.middle + (utils.interpolate(u_in/inmax, 30*math.sin(math.rad(90*syl.i)), 0))
					frz = utils.interpolate(u_in/inmax, math.randomsteps(-45, 45, 15), 0)
					u_in = u_in + 1
				elseif i > (n-math.ceil(outfad/max_frame)) then
					l.layer = 8
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					scx, scy = 100, 120
					x, y = syl.center + (utils.interpolate(u_out/outmax, 0, 30*math.sin(math.rad(45*syl.i)))), syl.middle + (utils.interpolate(u_out/outmax, 0, 30*math.sin(math.rad(90*syl.i))))
					frz = utils.interpolate(u_out/outmax, 0, math.randomsteps(-45, 45, 15))
					u_out = u_out + 1
				else
					l.layer = 8
					scx, scy = 100, 120
					x, y = syl.center, syl.middle
					frz = 0
					alpha="&H00&"
				end
				
				local maxj = 2
				for j = 1, 1, 2 do
					
					if j == 1 then
						blur = 3
						bord = 1
					end
					if j == 2 then
						blur = 0.4
						bord = 1
					end
					
					l.text = string.format("{\\an5\\blur%d\\bord%d\\shad0\\fscx%d\\fscy%d\\frz%d\\alpha%s\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
					,blur,bord,scx,scy,frz,alpha,x,y,syl.text)
					
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