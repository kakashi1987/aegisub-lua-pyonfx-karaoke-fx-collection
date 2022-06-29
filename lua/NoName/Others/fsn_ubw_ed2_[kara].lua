--Fate/stay night: Unlimited Blade Works ED2
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 500
	end
	if line.outfade > 500 then
		line.outfade = 500
	end
	
	for si, syl in ipairs(line.syls) do
		if syl.text~="" and syl.text~=" " and syl.text~="　" then
			
			local l = table.copy(line)
			
			local cx, cy = math.random(syl.x - syl.width/2, syl.x + syl.width/2), math.random(syl.y - syl.height/2, syl.y + syl.height/2)
			
			local bx1, by1 = syl.right + math.random(5,10), math.random(syl.top-5, syl.bottom+5)
			local bx2, by2 = syl.center + math.randomsteps(-5,5,1), syl.middle + math.randomsteps(-8,8,2)
			local bx3, by3 = syl.center + math.randomsteps(-5,5,2.5), syl.middle + math.randomsteps(-4,4,0.5)
			local bx4, by4 = syl.right+math.random(2,8), math.random(syl.top-3, syl.bottom+3)
			
			for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do
				
				l.layer = 5
				
				l.start_time=line.start_time+50*syl.i-line.infade-50
				l.end_time=line.start_time+syl.start_time
				
				local x, y = syl.center, syl.middle
				
				local px, py = syl.left + pixel.x, syl.top + pixel.y
				
				local bpoint = math.bezier(math.randomsteps(0, 1, 0.01),
				{
				{bx1, by1},
				{bx2, by2},
				{bx3, by3},
				{bx4, by4}
				}
				)
				
				local mx, my = bpoint[1] + math.random(31,32), bpoint[2] + math.random(-1,1)
				
				local cd1, cd2 = math.abs(cx-px), math.abs(cy-py)
				
				local color1 = convert.rgb_to_ass(3 + cd1, 36 + cd2 , 93 + (cd1+cd2)/2)
				
				local shad = math.randomsteps(1, 1.5, 0.1)
				
				local fad = math.randomsteps(150,500,50)
				local ifs = math.randomsteps(0,250,50)
				
				l.text=string.format("{\\an7\\bord0\\blur0.1\\shad%.2f\\fscx100\\fscy100\\fad(%d,0)\\1c%s\\4c&HFFFFFF&\\4a&H64&\\move(%.3f,%.3f,%.3f,%.3f, %.3f,500)\\p1}m 0 0 l 1 0 1 1 0 1"
				,shad,fad,color1,px+math.random(5,10),py,px,py,ifs)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.text~=" " and syl.text~="　" then
			
			local l = table.copy(line)
			
			local cx, cy = math.random(syl.x - syl.width/2, syl.x + syl.width/2), math.random(syl.y - syl.height/2, syl.y + syl.height/2)
			
			local bx1, by1 = syl.left + math.randomsteps(-50,-10,25), syl.top + math.randomsteps(-30,30,10)
			local bx2, by2 = syl.left + math.randomsteps(-55,-15,5), syl.top + math.randomsteps(-45,45,15)
			local bx3, by3 = syl.left + math.randomsteps(-30,-5,5), syl.bottom + math.randomsteps(-55,55,10)
			local bx4, by4 = syl.left + math.randomsteps(-40,-10,5), syl.bottom + math.randomsteps(-20,20,5)
			
			for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do
				
				l.layer = 5
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time + 1000
				
				local x, y = syl.center, syl.middle
				
				local px, py = syl.left + pixel.x, syl.top + pixel.y
				
				local bpoint = math.bezier(math.randomsteps(0, 1, 0.01),
				{
				{bx1, by1},
				{bx2, by2},
				{bx3, by3},
				{bx4, by4}
				}
				)
				
				local mx, my = bpoint[1] + math.random(-1,1), bpoint[2] + math.random(-1,1)
				
				local ms, me = math.randomsteps(0, 1000, 50), l.end_time-l.start_time
				
				local fad = math.random(syl.duration+500, syl.duration+1000)
				
				local cd1, cd2 = math.abs(cx-px), math.abs(cy-py)
				
				local color1 = convert.rgb_to_ass(3 + cd1, 36 + cd2 , 93 + (cd1+cd2)/2)
				
				l.text=string.format("{\\an7\\bord0\\blur0.1\\shad1\\fscx100\\fscy100\\fad(0,%d)\\1c%s\\4c&HFFFFFF&\\4a&H64&\\move(%.3f,%.3f,%.3f,%.3f, %.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
				,fad,color1,px,py,mx,my,ms,me)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.text~=" " and syl.text~="　" then
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local tlx, tly, brx, bry = shape.bounding(text_shape)
			local cx, cy = (tlx+brx)/2, (tly+bry)/2
			
			local u_in, u_out= 0, 0
			
			local max_frame = 75
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				l.layer = 6
				
				l.start_time=s
				l.end_time=e
				
				local step = i / n
				
				local infad, outfad = syl.duration/4, syl.duration/4
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				
				if i < math.ceil(infad/max_frame) then
					alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
					u_in = u_in + 1
					
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					u_out = u_out + 1
				else
					alpha="&H00&"
				end
				
				local deform = shape.filter(text_shape,
				function(x,y)
					local rx, ry = math.random(tlx-5,brx+5), math.random(tly-5,bry+5)
					local x, y = utils.interpolate(step,x,rx), utils.interpolate(step,y,ry)
					return x, y
				end)
				
				l.text=string.format("{\\an7\\bord1\\blur0.9\\p4\\1a&HFF&\\3c&HE4F890&\\3a%s\\fscx100\\fscy100\\pos(%.3f,%.3f)}%s"
				,alpha,syl.center-syl.width/2,syl.middle-syl.height/2,deform)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			
			l.layer = 7
			
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time
			
			local fad1, fad2 = syl.duration/4, syl.duration/2
			
			l.text=string.format("{\\an5\\bord1\\blur1\\shad0\\fscx100\\fscy100\\1a&HFF&\\3c&HEAFCA9&\\fad(%d,%d)\\pos(%.3f,%.3f)}%s"
			,fad1,fad2,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end