--Kara no Kyoukai 3 ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade>=501 then
		line.infade=500
	end
	
	if line.outfade>=501 then
		line.outfade=500
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--fadein, fadeout
			
			l.layer = 1
			
			l.start_time=line.start_time+25*syl.i-line.infade-50
			l.end_time=line.end_time+25*syl.i+line.outfade-50
			
			of_start=l.end_time-l.start_time-350
			of_end=l.end_time-l.start_time
			
			l.text = string.format("{\\an5\\blur10\\be30\\bord0\\fscx100\\fscy100\\t(0,350,\\be0\\blur0.6)\\t(%d,%d,\\be30\\blur10)\\1c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
			,of_start,of_end,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--sinus effect
			
			local circle = shape.ring(60,40)
			
			max_frame=25
			u_in=0
			u_out=0
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 3
				
				local step = i / n
				shift = step
				
				if syl.i==1 then
					infad=250
					outfad=0
				elseif syl.i==#line.syls then
					infad=0
					outfad=250
				else
					infad=0
					outfad=0
				end
				
				inmax=math.ceil(infad/max_frame)
				outmax=math.ceil(outfad/max_frame)
				if i<math.ceil(infad/max_frame) then
					alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
					u_in=u_in+1
				elseif i>(n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					u_out=u_out+1
				else
					alpha="&H00&"
				end
				
				if syl.i==1 then
					left = syl.left-50
				else
					left = syl.left
				end
				
				if syl.i==#line.syls then
					right = syl.right+20
				else
					right = syl.right
				end
				
				x=utils.interpolate(shift, left, right)
				shift = shift+step
				y=syl.middle+(math.sin(syl.middle/(line.height)+step)*150)
				
				l.text = string.format("{\\an7\\blur0.6\\bord0\\fscx100\\fscy100\\alpha%s\\1c&HFFFFFF&\\pos(%.3f, %.3f)\\p4}%s"
				,alpha,x,y-148,circle)
				
				io.write_line(l)
				
			end
			
		end
		
		if syl.text~="" then
			--dispersion effect
			
			local circle = shape.ring(60,40)
			
			max_frame=50
			u_in=0
			u_out=0
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				l.start_time = s
				l.end_time = e+500
				
				local step = i / n
				shift = step
				
				if syl.i==1 then
					infad=250
					outfad=0
				elseif syl.i==#line.syls then
					infad=0
					outfad=250
				else
					infad=0
					outfad=0
				end
				
				inmax=math.ceil(infad/max_frame)
				outmax=math.ceil(outfad/max_frame)
				if i<math.ceil(infad/max_frame) then
					alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H32&")
					u_in=u_in+1
				elseif i>(n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H32&", "&HFF&")
					u_out=u_out+1
				else
					alpha="&H32&"
				end
				
				if syl.i==1 then
					left = syl.left-50
				else
					left = syl.left
				end
				
				if syl.i==#line.syls then
					right = syl.right+20
				else
					right = syl.right
				end
				
				x=utils.interpolate(shift, left, right)
				shift = shift+step
				y=syl.middle+(math.sin(syl.middle/(line.height)+step)*150)
				
				for pi, pixel in ipairs(convert.shape_to_pixels(circle, true)) do
					
					l.layer=2
					
					xpos = x + pixel.x
					ypos = y + pixel.y
					
					rad=syl.right-syl.left
					
					ang = math.randomsteps(1, 360, 1)
					local x1,y2 = math.ellipse(syl.center,syl.middle,rad,rad,ang)
					
					randomfad=math.randomsteps(250,500, 25)
					
					l.text=string.format("{\\an5\\bord0\\blur0.4\\shad0\\fscx100\\fscy100\\fad(0,%d)\\alpha%s\\1c&HFFFFFF&\\move(%.3f,%.3f,%.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
					,randomfad,alpha,xpos,ypos-148,x1,y2)
					
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