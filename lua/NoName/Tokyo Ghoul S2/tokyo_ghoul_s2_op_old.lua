--Tokyo Ghoul S2 OP
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--placeholder
			
			l.layer = 5
			
			l.start_time = line.start_time-line.infade
			l.end_time = line.end_time+line.outfade
			
			l.text = string.format("{\\an5\\bord1\\blur3\\fscx100\\fscy100\\fad(250,250)\\1c&HFFFFFF&\\3c&H4B4DE2&\\pos(%.3f, %.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" and syl.i == 1 and line.actor == "hb" then
			
			local rsc = math.randomsteps(50,150,10)
			
			--horizontal bezier fx
			maxj = line.width*0.75
			for j = 1, maxj, 1 do
				
				local max_frame = 50
				local u_in, u_out = 0, 0
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, lines[6].end_time+line.outfade, max_frame) do
					
					l.layer = 3
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					if line.i == 1 then
						bx1, by1 = utils.interpolate(step, line.left, line.left + 15), utils.interpolate(step, line.top - 15, line.middle + 25)
						bx2, by2 = utils.interpolate(step, line.left + 35, line.left - 20), utils.interpolate(step, line.middle - 25, line.middle - 35)
						bx3, by3 = utils.interpolate(step, line.left + 50, line.left) + 10, utils.interpolate(step, line.top - 40, line.bottom + 55)
						bx4, by4 = utils.interpolate(step, line.right - 20, line.right + 10), utils.interpolate(step, line.top - 35, line.middle - 60)
						bx5, by5 = utils.interpolate(step, line.right - 60, line.right - 40), utils.interpolate(step, line.middle -20, line.bottom + 30)
						bx6, by6 = utils.interpolate(step, line.right, line.right + 20), utils.interpolate(step, line.top - 30, line.bottom + 10)
					elseif line.i == 2 then
						bx1, by1 = utils.interpolate(step, line.left + 10, line.left - 25), utils.interpolate(step, line.top + 15, line.middle - 15)
						bx2, by2 = utils.interpolate(step, line.left - 35, line.left + 15), utils.interpolate(step, line.middle + 30, line.middle + 35)
						bx3, by3 = utils.interpolate(step, line.left + 20, line.left + 15), utils.interpolate(step, line.top + 20, line.bottom - 55)
						bx4, by4 = utils.interpolate(step, line.right + 20, line.center - 15), utils.interpolate(step, line.top - 15, line.middle + 40)
						bx5, by5 = utils.interpolate(step, line.right - 30, line.right + 20), utils.interpolate(step, line.middle - 10, line.bottom + 15)
						bx6, by6 = utils.interpolate(step, line.right + 15, line.right - 20), utils.interpolate(step, line.top + 10, line.bottom - 25)
					elseif line.i == 3 then
						bx1, by1 = utils.interpolate(step, line.left - 18, line.left - 25), utils.interpolate(step, line.top - 10, line.middle + 15)
						bx2, by2 = utils.interpolate(step, line.left + 25, line.left + 10), utils.interpolate(step, line.middle + 20, line.middle - 15)
						bx3, by3 = utils.interpolate(step, line.left + 30, line.left - 25), utils.interpolate(step, line.top + 25, line.bottom - 25)
						bx4, by4 = utils.interpolate(step, line.right + 20, line.center - 15), utils.interpolate(step, line.top + 15, line.middle - 20)
						bx5, by5 = utils.interpolate(step, line.right - 30, line.right + 5), utils.interpolate(step, line.middle + 15, line.bottom - 35)
						bx6, by6 = utils.interpolate(step, line.right + 15, line.right - 20), utils.interpolate(step, line.top - 20, line.bottom + 40)
					elseif line.i == 4 then
						bx1, by1 = utils.interpolate(step, line.left + 25, line.left + 40), utils.interpolate(step, line.top - 20, line.middle + 25)
						bx2, by2 = utils.interpolate(step, line.left - 10, line.left + 20), utils.interpolate(step, line.middle + 10, line.middle - 45)
						bx3, by3 = utils.interpolate(step, line.left + 40, line.left - 15), utils.interpolate(step, line.top + 45, line.bottom + 5)
						bx4, by4 = utils.interpolate(step, line.right - 10, line.center + 35), utils.interpolate(step, line.top - 15, line.middle + 20)
						bx5, by5 = utils.interpolate(step, line.right - 30, line.right + 25), utils.interpolate(step, line.middle + 25, line.bottom + 15)
						bx6, by6 = utils.interpolate(step, line.right - 15, line.right + 30), utils.interpolate(step, line.top - 35, line.bottom - 60)
					elseif line.i == 5 then
						bx1, by1 = utils.interpolate(step, line.left - 35, line.left + 60), utils.interpolate(step, line.top + 40, line.middle - 25)
						bx2, by2 = utils.interpolate(step, line.left - 15, line.left - 40), utils.interpolate(step, line.middle + 20, line.middle - 15)
						bx3, by3 = utils.interpolate(step, line.left - 20, line.left + 75), utils.interpolate(step, line.top - 45, line.bottom - 25)
						bx4, by4 = utils.interpolate(step, line.right - 25, line.center - 45), utils.interpolate(step, line.top + 35, line.middle - 10)
						bx5, by5 = utils.interpolate(step, line.right - 60, line.right - 25), utils.interpolate(step, line.middle + 65, line.bottom - 20)
						bx6, by6 = utils.interpolate(step, line.right - 55, line.right + 35), utils.interpolate(step, line.top - 15, line.bottom + 30)
					else
						bx1, by1 = utils.interpolate(step, line.left - 15, line.left + 10), utils.interpolate(step, line.top + 40, line.middle - 15)
						bx2, by2 = utils.interpolate(step, line.left + 25, line.left - 10), utils.interpolate(step, line.middle - 20, line.middle + 10)
						bx3, by3 = utils.interpolate(step, line.left + 25, line.left - 15), utils.interpolate(step, line.top + 15, line.bottom - 15)
						bx4, by4 = utils.interpolate(step, line.right + 35, line.center + 25), utils.interpolate(step, line.top - 25, line.middle + 5)
						bx5, by5 = utils.interpolate(step, line.right - 20, line.right + 5), utils.interpolate(step, line.middle - 10, line.bottom + 10)
						bx6, by6 = utils.interpolate(step, line.right + 35, line.right - 15), utils.interpolate(step, line.top + 25, line.bottom - 15)
					end
					
					local bpoint = math.bezier(1/(maxj/j),
					{
					{bx1, by1},
					{bx2, by2},
					{bx3, by3},
					{bx4, by4},
					{bx5, by5},
					{bx6, by6}
					}
					)
					
					local x0, y0 = bpoint[1], bpoint[2]
					
					local infad, outfad = 1500, 1500
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H96&")
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H96&", "&HFF&")
						u_out = u_out + 1
					else
						alpha="&H00&"
					end
					
					local sc = 100 + rsc*math.sin(math.rad(utils.interpolate(1/(maxj/j), 0, 180)))
					
					local x, y = x0, y0 + 50
					
					l.text = string.format("{\\p1\\an5\\blur3\\bord0\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&H4B4DE2&\\pos(%.3f,%.3f)}m 0 0 l 1 0 1 1 0 1"
					,sc,sc,alpha,x,y)
					
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