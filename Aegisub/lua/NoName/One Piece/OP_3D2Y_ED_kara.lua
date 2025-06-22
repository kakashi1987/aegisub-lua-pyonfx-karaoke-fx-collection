--One Piece Special: 3D2Y Ending
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	for ci,char in ipairs(line.chars) do
		
		if char.text~="" and char.text~=" " then
			--text fx1
			
			local text_shape = convert.text_to_shape(char.text, line.styleref)
			local tlx, tly, brx, bry = shape.bounding(text_shape)
			local shape_split = shape.split(text_shape, 1)
			
			local max_frame = 24
			local u_in, u_out = 0, 0
			local a, b, c, d = 0, 0, 0, 0
			
			for s, e, i, n in utils.frames(line.start_time+15*char.i-15-line.infade, line.end_time+15*char.i-15+line.outfade, max_frame) do
				
				l.layer = 5
				
				l.start_time = s
				l.end_time = e
				
				step = i / n
				
				local infad, outfad = 250, 250
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				
				local sx1, sy1 = char.left - 50, char.top + math.randomsteps(-40, 0, 5)
				local sx2, sy2 = char.left - 100, char.top + math.randomsteps(-30, 0, 10)
				local sx3, sy3 = char.left - 50, char.top + math.randomsteps(-20, 0, 10)
				local sx4, sy4 = char.left, char.top
				
				local ex1, ey1 = char.left, char.top
				local ex2, ey2 = char.left - 100, char.top + math.randomsteps(20, 50, 10)
				local ex3, ey3 = char.left - 50, char.top + math.randomsteps(0, 20, 10)
				local ex4, ey4 = char.left - 75, char.top + math.randomsteps(10, 30, 5)
				
				local rfrx, rfry, rfrz = math.randomsteps(-90, 90, 15), math.randomsteps(-90, 90, 10), math.randomsteps(-45, 45, 5)
				
				if i < math.ceil(infad/max_frame) then
					alpha = "&H00&"
					local spoint = math.bezier(u_in/inmax,
					{
					{sx1, sy1},
					{sx2, sy2},
					{sx3, sy3},
					{sx4, sy4}
					}
					)
					x, y = spoint[1] , spoint[2]
					frx, fry, frz = utils.interpolate(u_in/inmax, rfrx, 0), utils.interpolate(u_in/inmax, rfry, 0), utils.interpolate(u_in/inmax, rfrz, 0)
					deform = text_shape
					scx, scy = 100, 100
					u_in = u_in + 1
				elseif s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
					local rd_pos = math.randomsteps(0, 1, 0.1)
					
					local pct = math.abs(math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration), 1, 1440))))
					
					deform = shape.filter(shape_split,
					function(x,y)
						local cx, cy = (tlx+brx)/2, (tly+bry)/2
						local vx, vy = cx - x, cy - y
						
						local dx1, dy1 = 0, 0
						local dx2, dy2 = utils.interpolate(pct, x, vx+math.random(-10,10))+math.sin(math.rad(10*x+c)), utils.interpolate(pct, y, vy+math.random(-10,10))+math.sin(math.rad(10*y+d))
						local dx3, dy3 = utils.interpolate(pct, x, vx), utils.interpolate(pct, y, vy)
						local dx4, dy4 = 0, 0
						
						local dpoint = math.bezier(pct,
						{
						{dx1, dy1},
						{dx2, dy2},
						{dx3, dy3},
						{dx4, dy4}
						}
						)
						local xdef = dpoint[1]
						local ydef = dpoint[2]
						
						c, d = c + math.random(10, 15), d + math.randomsteps(9, 15, 3)
						
						return x+xdef, y+ydef
					end)
					--x = char.center + math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration*math.pi), 1,45)))*2
					--y = char.middle + math.sin(math.rad(utils.interpolate((s - (line.start_time + char.start_time)/char.duration*math.pi), 1,45)))*2
					x, y = char.center, char.middle
					frx, fry, frz = 0, 0, 0
					scx, scy = 100, 100
					alpha="&H00&"
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					local epoint = math.bezier(u_in/inmax,
					{
					{ex1, ey1},
					{ex2, ey2},
					{ex3, ey3},
					{ex4, ey4}
					}
					)
					x, y = epoint[1] , epoint[2]
					frx, fry, frz = utils.interpolate(u_out/outmax, 0, rfrx), utils.interpolate(u_out/outmax, 0, rfry), utils.interpolate(u_out/outmax, 0, rfrz)
					deform = text_shape
					scx, scy = 100, 100
					u_out = u_out + 1
				else
					deform = text_shape
					scx, scy = 100 + 5*math.sin(math.rad(a)), 100 + 5*math.sin(math.rad(b))
					x, y = char.center, char.middle
					frx, fry, frz = 0, 0, 0
					deform = text_shape
					alpha="&H00&"
					a,b = a + math.random(5, 10), b + math.randomsteps(6, 10 ,2)
				end
				
				l.text = string.format("{\\p4\\b1\\an7\\blur1\\bord2\\shad0\\fscx%d\\fscy%d\\frx%.3f\\fry%.3f\\frz%.3f\\alpha%s\\1c&H1ACD3D&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
				,scx,scy,frx,fry,frz,alpha,x,y,deform)
				
				io.write_line(l)
			end
		end
	end
end

for li, line in ipairs(lines) do
	
	kara(line, table.copy(line) )
	
	io.progressbar(li / #lines)
end