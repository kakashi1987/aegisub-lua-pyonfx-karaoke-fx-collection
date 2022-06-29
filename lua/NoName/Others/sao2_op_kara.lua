--Sword Art Online II opening
--Karaoke by Amberdrake
--VSFilterMod

function kara(line, l)
	line.infade=250
	line.outfade=250
	
	for si, syl in pairs(line.syls) do
		if syl.text~="" then
			--infade1
			l = table.copy(line)
			
			for pi, pixel in ipairs( convert.text_to_pixels(syl.text, line.styleref) ) do
				
				l.layer=4
				
				local x = syl.left + pixel.x
				local y = syl.top + pixel.y
				
				local color_array = {"&HCDB85C&" , "&HEDF4F3&" , "&HFAB050&" , "&HFFE5AB&" , "&HE6BEB5&" , "&HF4FF99&"}
				local random_color=color_array[math.random(1,table.getn(color_array))]
				
				l.start_time=line.start_time+50*syl.i-line.infade-50
				l.end_time=line.start_time+75*syl.i-line.infade
				
				l.text = string.format("{\\an7\\bord0\\blur0.4\\1c%s\\fscx10\\fscy10\\jitter(1,1,1,1)\\alpha&H00&\\t(\\1c&HE9DB95&\\alpha&HFF&)\\pos(%.3f,%.3f)\\p1}m 0 0 l 10 0 l 10 -10 l 0 -10 "
				,random_color,x,y+1)
				
				io.write_line(l)
			end
		end
		if syl.text~="" then
			--infade2
			l.layer=3
			
			l.start_time=line.start_time+50*syl.i-line.infade
			l.end_time=line.start_time+syl.start_time+50
			
			l.text=string.format("{\\an5\\bord0.5\\blur0.6\\1c&HE9DB95&\\3c&H693F18&\\fad(100,0)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
			
		end
		
		if syl.text~="" then
			--syl fx1
			l.layer=3
			
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time
			
			l.text=string.format("{\\an5\\bord0.5\\blur0.6\\fscx100\\fscy100\\1c&HE9DB95&\\3c&H693F18&\\jitter(1,1,1,1)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
			
		end
		
		if syl.text~="" then
			--syl fx2
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local tlx, tly, brx, bry = shape.bounding(text_shape)
			local cx, cy = (tlx+brx)/2, (tly+bry)/2
			
			max_frame = 100
			
			u_out=0
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				l.layer=4
				
				l.start_time=s
				l.end_time=e
				
				local step = i / n
				
				local deform = shape.filter(text_shape,
				function(x,y)
					local rx, ry = math.random(tlx,brx), math.random(tly,bry)
					local x, y = utils.interpolate(step,x,rx), utils.interpolate(step,y,ry)
					return x, y
				end)
				
				l.text=string.format("{\\an7\\bord0.6\\blur0.8\\p4\\1a&HFF&\\3a&H32&\\3c&HF9FBCF&\\fscx100\\fscy100\\pos(%.3f,%.3f)}%s"
				,syl.center-syl.width/2,syl.middle-syl.height/2,deform)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			--outfade1
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			local tlx, tly, brx, bry = shape.bounding(split_shape)
			local cx, cy = (tlx+brx)/2, (tly+bry)/2
			
			max_frame = 25
			
			u_out=0
			
			for s, e, i, n in utils.frames(line.start_time+syl.end_time, line.start_time+syl.end_time+750, max_frame) do
				l.layer=8
				
				l.start_time=s
				l.end_time=e
				
				local step = i / n
				
				local deform = shape.filter(split_shape,
				function(x,y)
					local vx, vy = x - cx, y - cy
					local x, y = utils.interpolate(step,x,cx)+math.random(-5,5), utils.interpolate(step,y,cy)+math.random(-5,5)
					return x, y
				end)
				
				fad=750
				max=math.ceil(fad/max_frame)
				if i>(n-math.ceil(fad/max_frame)) then
					blur = utils.interpolate(u_out/max, 0.6, 10)
					bord = utils.interpolate(u_out/max, 0.2, 2)
					u_out=u_out+1
				else
					blur=0.6
					bord=0.2
				end
				
				l.text=string.format("{\\an7\\p4\\blur%d\\bord%d\\1c&HF1DF76&\\3c&HF6B96C&\\pos(%.3f,%.3f)}%s"
				,blur,bord,syl.center-syl.width/2,syl.middle-syl.height/2,deform)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			--outfade2
			l.layer=10
			
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.start_time+syl.end_time+250
			
			l.text=string.format("{\\an5\\bord2\\blur3\\1a&HFF&\\3c&HF9FBFF&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
			,syl.duration,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
			
		end
		
		if syl.text~="" then
			--outfade3
			l = table.copy(line)
			
			for pi, pixel in ipairs( convert.text_to_pixels(syl.text, line.styleref) ) do
				
				l.layer=math.random(7,9)
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.start_time+syl.end_time+750+math.randomsteps(-50,50,25)
				
				local random_move = math.random(-3,3)
				
				local cx = syl.center
				local cy = syl.middle
				
				local px = syl.left + pixel.x
				local py = syl.top + pixel.y
				
				local vx, vy = px - cx, py - cy
				
				local angle = math.deg(math.atan2(vx, vy))
				
				local x_move,y_move = math.ellipse(cx,cy,10,12,angle)
				
				local random_rotation = math.random(-360,360)
				
				local rf = math.random(-3,3)
				
				local rsc = math.randomsteps(15,25,5)
				
				local randomfad = math.randomsteps(30,60,10)
				
				local color_array = {"&HCDB85C&" , "&HEDF4F3&" , "&HFAB050&" , "&HFFE5AB&" , "&HE6BEB5&" , "&HF4FF99&"}
				local random_color=color_array[math.random(1,table.getn(color_array))]
				
				l.text = string.format("{\\an7\\bord0\\blur0.5\\1c&HE9DB95&\\alpha&H64&\\fscx%d\\fscy%d\\frx%d\\fry%d\\frx0\\fry0\\t(\\1c%s\\frx%d\\fry%d\\fscx%d\\fscy%d)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f)\\p1}m 0 0 l 10 0 l 5 -8 "
				,rsc,rsc,random_rotation,random_rotation,random_color,random_rotation,random_rotation,rsc,rsc,randomfad,px,py+1,x_move+rf,y_move+rf)
				
				io.write_line(l)
			end
			
		end
		
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end