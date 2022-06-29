--Date A Live II ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	if line.infade > 1000 then
		line.infade = 350
	end
	if line.outfade > 1000 then
		line.outfade = 350
	end
	if line.style == "ED_romanji" or line.style == "ED_kanji" then
		for si, syl in ipairs(line.syls) do
			if syl.text~="" then
				--infade
				
				max_frame = 25
				u_in = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+75*syl.i-75, line.start_time-line.infade+75*syl.i+350, max_frame) do
					
					l.layer=4
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					fad = 500
					max=math.ceil(fad/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						u_in=u_in+1
					else
						alpha="&H00&"
					end
					
					x = utils.interpolate(step, syl.center-50, syl.center)
					y = syl.middle+10*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					
					l.text=string.format("{\\an5\\bord0\\blur0.2\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\alpha%s\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,syl.text)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--infade bord
				
				max_frame = 25
				u_in = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+75*syl.i-75, line.start_time-line.infade+75*syl.i+350, max_frame) do
					
					l.layer=1
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					fad = 500
					max=math.ceil(fad/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						u_in=u_in+1
					else
						alpha="&H00&"
					end
					
					x = utils.interpolate(step, syl.center-50, syl.center)
					y = syl.middle+10*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					
					l.text=string.format("{\\an5\\bord3\\blur3\\1a&HFF&\\3c&HD17C1F&\\\shad0\\fscx100\\fscy100\\1c&HB34015&\\alpha%s\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,syl.text)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--infade bord 2
				
				max_frame = 25
				u_in = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+75*syl.i-75, line.start_time-line.infade+75*syl.i+350, max_frame) do
					
					l.layer=1
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					fad = 500
					max=math.ceil(fad/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						u_in=u_in+1
					else
						alpha="&H00&"
					end
					
					x = utils.interpolate(step, syl.center-50, syl.center)
					y = syl.middle+10*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					
					l.text=string.format("{\\an5\\bord1\\blur0.6\\1a&HFF&\\3c&HF0CD26&\\shad0\\fscx100\\fscy100\\1c&HB34015&\\alpha%s\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,syl.text)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--placeholder 1
				
				l.layer=4
				
				l.start_time=line.start_time-line.infade+75*syl.i+350
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.2\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--placeholder 1 bord
				
				l.layer=2
				
				l.start_time=line.start_time-line.infade+75*syl.i+350
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord3\\blur3\\1a&HFF&\\3c&HD17C1F&\\shad0\\fscx100\\fscy100\\1c&HB34015&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--placeholder 1 bord 2
				
				l.layer=3
				
				l.start_time=line.start_time-line.infade+75*syl.i+350
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord1\\blur0.6\\1a&HFF&\\3c&HF0CD26&\\shad0\\fscx100\\fscy100\\1c&HB34015&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl effect bord
				
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an2\\bord3\\blur3\\shad0\\fscx100\\fscy100\\1a&HFF&\\t(0,%d,\\fscy90\\bord5\\blur7)\\t(%d,%d,\\fscy100\\bord3\\blur3)\\1c&HB34015&\\3c&HD17C1F&\\pos(%.3f,%.3f)}%s"
				,syl.duration/2,syl.duration/2,syl.duration,syl.center,syl.middle+syl.height/2,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl effect bord2
				
				l.layer=3
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an2\\bord1\\blur0.6\\shad0\\fscx100\\fscy100\\1a&HFF&\\t(0,%d,\\fscy90\\bord1\\blur2)\\t(%d,%d,\\fscy100\\bord1\\blur0.6)\\1c&HB34015&\\3c&HF0CD26&\\pos(%.3f,%.3f)}%s"
				,syl.duration/2,syl.duration/2,syl.duration,syl.center,syl.middle+syl.height/2,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl effect pixels
				
				local l = table.copy(line)
				
				for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do
					
					l.layer=1
					
					l.start_time=line.start_time+syl.start_time
					l.end_time=line.start_time+syl.end_time+750
					
					px = syl.left + pixel.x
					py = syl.top + pixel.y
					
					x = syl.center+20*math.sin(math.rad(math.random(-90, 90)))
					y = syl.middle-20+5*math.sin(math.rad(math.randomsteps(0, 360, 15)))
					
					randomfad = math.randomsteps(syl.duration/2, syl.duration/2+375, 25)
					
					l.text=string.format("{\\an7\\p1\\bord0.2\\blur2\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HFFFFFF&\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f}m 0 0 l 1 0 1 1 0 1"
					,randomfad,px,py,x,y)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--placeholder 2 bord
				
				l.layer=2
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time+75*syl.i-575
				
				l.text=string.format("{\\an5\\bord3\\blur3\\1a&HFF&\\3c&HD17C1F&\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--placeholder 2 bord 2
				
				l.layer=3
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time+75*syl.i-575
				
				l.text=string.format("{\\an5\\bord1\\blur0.6\\1a&HFF&\\3c&HF0F588&\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade bord
				
				max_frame = 25
				u_out = 0
				
				for s, e, i, n in utils.frames(line.end_time+75*syl.i-575, line.end_time+line.outfade+75*syl.i-75, max_frame) do
					
					l.layer=1
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					fad = 500
					max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					x = utils.interpolate(step, syl.center, syl.center+50)
					y = syl.middle+10*math.sin(math.rad(utils.interpolate(step, 180, 360)))
					
					l.text=string.format("{\\an5\\bord3\\blur3\\1a&HFF&\\3c&HD17C1F&\\shad0\\fscx100\\fscy100\\1c&HB34015&\\3a%s\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,syl.text)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--outfade bord 2
				
				max_frame = 25
				u_out = 0
				
				for s, e, i, n in utils.frames(line.end_time+75*syl.i-575, line.end_time+line.outfade+75*syl.i-75, max_frame) do
					
					l.layer=2
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					fad = 500
					max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					x = utils.interpolate(step, syl.center, syl.center+50)
					y = syl.middle+10*math.sin(math.rad(utils.interpolate(step, 180, 360)))
					
					l.text=string.format("{\\an5\\bord1\\blur0.6\\1a&HFF&\\3c&HF0CD26&\\shad0\\fscx100\\fscy100\\1c&HB34015&\\3a%s\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,syl.text)
					
					io.write_line(l)
					
				end
				
			end
		end
	end
	
	if line.style == "ED_TL" then
		
		for si, syl in ipairs(line.syls) do
			if syl.text~="" then
				--infade
				
				max_frame = 25
				u_in = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+75*syl.i-75, line.start_time-line.infade+75*syl.i+350, max_frame) do
					
					l.layer=4
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					fad = 500
					max=math.ceil(fad/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						u_in=u_in+1
					else
						alpha="&H00&"
					end
					
					x = utils.interpolate(step, syl.center-50, syl.center)
					y = syl.middle+10*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					
					l.text=string.format("{\\an5\\bord0\\blur0.2\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\alpha%s\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,syl.text)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--infade bord
				
				max_frame = 25
				u_in = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+75*syl.i-75, line.start_time-line.infade+75*syl.i+350, max_frame) do
					
					l.layer=1
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					fad = 500
					max=math.ceil(fad/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						u_in=u_in+1
					else
						alpha="&H00&"
					end
					
					x = utils.interpolate(step, syl.center-50, syl.center)
					y = syl.middle+10*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					
					l.text=string.format("{\\an5\\bord3\\blur3\\1a&HFF&\\3c&HD17C1F&\\\shad0\\fscx100\\fscy100\\1c&HB34015&\\alpha%s\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,syl.text)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--infade bord 2
				
				max_frame = 25
				u_in = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+75*syl.i-75, line.start_time-line.infade+75*syl.i+350, max_frame) do
					
					l.layer=1
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					fad = 500
					max=math.ceil(fad/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						u_in=u_in+1
					else
						alpha="&H00&"
					end
					
					x = utils.interpolate(step, syl.center-50, syl.center)
					y = syl.middle+10*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					
					l.text=string.format("{\\an5\\bord1\\blur0.6\\1a&HFF&\\3c&HF0CD26&\\shad0\\fscx100\\fscy100\\1c&HB34015&\\alpha%s\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,syl.text)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--placeholder 1
				
				l.layer=4
				
				l.start_time=line.start_time-line.infade+75*syl.i+350
				l.end_time=line.end_time+75*syl.i-575
				
				l.text=string.format("{\\an5\\bord0\\blur0.2\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--placeholder 1 bord
				
				l.layer=2
				
				l.start_time=line.start_time-line.infade+75*syl.i+350
				l.end_time=line.end_time+75*syl.i-575
				
				l.text=string.format("{\\an5\\bord3\\blur3\\1a&HFF&\\3c&HD17C1F&\\shad0\\fscx100\\fscy100\\1c&HB34015&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--placeholder 1 bord 2
				
				l.layer=3
				
				l.start_time=line.start_time-line.infade+75*syl.i+350
				l.end_time=line.end_time+75*syl.i-575
				
				l.text=string.format("{\\an5\\bord1\\blur0.6\\1a&HFF&\\3c&HF0CD26&\\shad0\\fscx100\\fscy100\\1c&HB34015&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade
				
				max_frame = 25
				u_out = 0
				
				for s, e, i, n in utils.frames(line.end_time+75*syl.i-575, line.end_time+line.outfade+75*syl.i-75, max_frame) do
					
					l.layer=4
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					fad = 500
					max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					x = utils.interpolate(step, syl.center, syl.center+50)
					y = syl.middle+10*math.sin(math.rad(utils.interpolate(step, 180, 360)))
					
					l.text=string.format("{\\an5\\bord0\\blur0.2\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\alpha%s\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,syl.text)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--outfade bord
				
				max_frame = 25
				u_out = 0
				
				for s, e, i, n in utils.frames(line.end_time+75*syl.i-575, line.end_time+line.outfade+75*syl.i-75, max_frame) do
					
					l.layer=1
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					fad = 500
					max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					x = utils.interpolate(step, syl.center, syl.center+50)
					y = syl.middle+10*math.sin(math.rad(utils.interpolate(step, 180, 360)))
					
					l.text=string.format("{\\an5\\bord3\\blur3\\1a&HFF&\\shad0\\fscx100\\fscy100\\3c&HB34015&\\3a%s\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,syl.text)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--outfade bord 2
				
				max_frame = 25
				u_out = 0
				
				for s, e, i, n in utils.frames(line.end_time+75*syl.i-575, line.end_time+line.outfade+75*syl.i-75, max_frame) do
					
					l.layer=2
					
					l.start_time=s
					l.end_time=e
					
					step = i / n
					
					fad = 500
					max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					x = utils.interpolate(step, syl.center, syl.center+50)
					y = syl.middle+10*math.sin(math.rad(utils.interpolate(step, 180, 360)))
					
					l.text=string.format("{\\an5\\bord1\\blur0.6\\1a&HFF&\\3c&HF0CD26&\\shad0\\fscx100\\fscy100\\1c&HB34015&\\alpha%s\\pos(%.3f,%.3f)}%s"
					,alpha,x,y,syl.text)
					
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