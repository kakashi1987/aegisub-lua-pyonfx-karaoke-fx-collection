--Fate/kaleid liner PRISMA ILLYA Zwei Herz! OP
--Karaoke by Amberdrake
--VSFilter

function romanji(line, l)
	
	line.infade = 150
	line.outfade = 150
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" and syl.i == 1 then
			--infade fx
			
			local max_k = 35*#line.syls
			for k = 1, max_k, 1 do
				
				l.layer = math.random(7, 9)
				
				l.start_time = math.randomsteps(line.start_time - line.infade - 350, line.start_time + 100, 25)
				l.end_time = l.start_time + 150
				
				local shape = shape.ellipse(35, 35)
				
				local x, y = math.random(line.left, line.right), math.random(line.top, line.bottom)
				
				local color_array = {"&HF441D6&", "&HFFFFFF&", "&HFF8EEC&", "&HFFFFFF&"}
				local random_color = color_array[math.random(1,table.getn(color_array))]
				
				l.text = string.format("{\\p1\\an5\\blur2.7\\bord0\\shad0\\fscx100\\fscy100\\fad(50,50)\\alpha&H96&\\1c%s\\pos(%.3f, %.3f)}%s"
				,random_color,x,y,shape)
				
				io.write_line(l)
				
			end
		end
		
		if syl.text~="" then
			--text
			
			local start_time = line.start_time-line.infade
			local end_time = line.end_time+line.outfade
			
			local layer_dist = utils.distributor({2, 5, 6})
			local blur_dist = utils.distributor({5, 0.9, 0.6})
			local bord_dist = utils.distributor({5, 2.95, 0})
			local color_dist = utils.distributor({"&HF441D6&", "&HFFFFFF&", "&HF441D6&"})
			
			local max_j = 3
			for j = 1, max_j, 1 do
				
				local layer = layer_dist:get()
				
				local blur_norm = blur_dist:get()
				local bord = bord_dist:get()
				local color = color_dist:get()
				
				local max_frame = 25
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				local x_dist = utils.distributor({-4,1,5,-1,2,-1,4,3,2,-2,-3,4,-5,-1,0,4,-1,2,0,-1,1,-2})
				local y_dist = utils.distributor({-1,-2,1,5,0,3,-1,-2,-4,-2,3,-1,-2,-5,2,3,1,-1,0,-4,2})
				
				for s, e, i, n in utils.frames(start_time, end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local infad, outfad = line.infade, line.outfade
					local inmax, outmax, fxmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame), math.ceil((syl.end_time-syl.start_time)/max_frame)
					
					local pseudo_r_px, pseudo_r_py = x_dist:get(), y_dist:get()
					
					if s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
						if layer == 2 then
							l.layer = 2
						else
							l.layer = layer + 3
						end
						blur = blur_norm
						sc = 100 + 20*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180)))
						alpha = "&H00&"
						tx, ty = syl.center + pseudo_r_px, syl.middle + pseudo_r_py
						
						u_fx = u_fx + 1
					elseif i < math.ceil(infad/max_frame) then
						l.layer = layer
						blur = utils.interpolate(u_in/inmax, 12, blur_norm)
						sc = 100
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						tx, ty = syl.center, syl.middle
						
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						l.layer = layer
						blur = utils.interpolate(u_out/outmax, blur_norm, 12)
						sc = 100
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						tx, ty = syl.center, syl.middle
						
						u_out = u_out + 1
					else
						l.layer = layer
						blur = blur_norm
						sc = 100
						alpha="&H00&"
						tx, ty = syl.center, syl.middle
					end
					
					l.text = string.format("{\\an5\\blur%d\\bord%d\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c%s\\3c%s\\pos(%.3f, %.3f)}%s"
					,blur,bord,sc,sc,alpha,color,color,tx,ty,syl.text)
					
					io.write_line(l)
				end
			end
		end
		
		if syl.text~="" then
			--syl fx 2
			
			local start_time = line.start_time + syl.start_time
			local end_time = line.start_time + syl.end_time
			
			l.layer = math.random(1,9)
			
			max_frame = 50
			
			for s, e, i, n in utils.frames(start_time, end_time, max_frame) do
				
				l.start_time = math.randomsteps(start_time-250, end_time-250, 50)
				l.end_time = l.start_time + 500
				
				local shape = shape.star(4, 2, 10)
				
				local x, y = math.random(syl.left - 5, syl.right + 5), math.random(syl.top - 5, syl.bottom + 5)
				
				local color_array = {"&HFF0000", "&HFFFF00&", "&H00FF00&", "&H0000FF&", "&HFF00FF&"}
				local random_color = color_array[math.random(1,table.getn(color_array))]
				
				local rot1 = math.randomsteps(5, 85, 5)
				local rot2 = rot1 + math.random(-1,1)*math.randomsteps(180, 360, 90)
				
				l.text = string.format("{\\p3\\an5\\blur3\\bord0.1\\shad0\\fscx100\\fscy100\\t(0,250,\\fscx600\\fscy600)\\t(250,500,\\fscx100\\fscy100)\\frz%d\\t(\\frz%d)\\fad(150,150)\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(0,200,\\3c%s)\\pos(%.3f, %.3f)}%s"
				,rot1,rot2,random_color,x,y,shape)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--outfade fx
			
			local max_k = 25*#line.syls
			for k = 1, max_k, 1 do
				
				l.layer = math.random(8, 10)
				
				l.start_time = math.randomsteps(line.end_time - 100, line.end_time + line.outfade + 150, 25)
				l.end_time = l.start_time + 150
				
				local shape = shape.ellipse(35, 35)
				
				local x, y = math.random(line.left, line.right), math.random(line.top, line.bottom)
				
				local color_array = {"&HF441D6&", "&HFFFFFF&", "&HFF8EEC&", "&HFFFFFF&"}
				local random_color = color_array[math.random(1,table.getn(color_array))]
				
				l.text = string.format("{\\p1\\an5\\blur2.7\\bord0\\shad0\\fscx100\\fscy100\\fad(50,50)\\alpha&H96&\\1c%s\\pos(%.3f, %.3f)}%s"
				,random_color,x,y,shape)
				
				io.write_line(l)
				
			end
		end
	end
end

for li, line in ipairs(lines) do
	
	romanji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end