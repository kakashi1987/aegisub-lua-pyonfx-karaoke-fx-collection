function kara(line, l)
	--Kara no Kyoukai 1 ED
	--Karaoke by Amberdrake
	--VSFilterMod
	
	if line.infade>=251 then
		line.infade=250
	end
	
	if line.outfade>=251 then
		line.outfade=250
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			if line.style=="ed_romanji" or line.style=="ed_kanji" then
				--standard line write
				
				l.layer=5
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.end_time-200
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord0\\fscx120\\fscy100\\1vc(&H636F1A&,&H636F1A&,&H95A426&,&H95A426&)\\fad(250,50)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_romanji" or line.style=="ed_kanji" then
				--standard line bord write
				
				l.layer=5
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.end_time-200
				
				l.text=string.format("{\\b1\\an5\\blur1.2\\bord2.5\\1a&HFF&\\fscx120\\fscy100\\3c&HFFFFFF&\\fad(250,50)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
		end
	end
	
	for ci,char in ipairs(line.chars) do
		if char.text~="" then
			--standart line outfade
			
			if line.style=="ed_romanji" or line.style=="ed_kanji" then
				
				local l = table.copy(line)
				
				for pi, pixel in ipairs(convert.text_to_pixels(char.text, line.styleref) ) do
					
					l.layer=6
					
					l.start_time=line.end_time-250
					l.end_time=line.end_time+line.outfade
					
					x = char.left + pixel.x
					y = char.top + pixel.y
					
					random_curve_xmove_value=(math.random(-5,5)+math.random((-1*#line.chars),#line.chars))/2
					random_curve_xmove_amplifier=(math.random(1,3))
					random_curve_xmove=random_curve_xmove_value*random_curve_xmove_amplifier
					random_curve_ymove=(math.random(-30,30)+math.random((-1*#line.chars),#line.chars))/2
					random_curve_angle1=(char.i-10)*(math.random(-17,-8))
					random_curve_angle2=(char.i-10)math.random(-7,-1)
					random_curve_radius1=math.random(1,3)
					random_curve_radius2=math.random(2,4)
					
					l.text=string.format("{\\an7\\bord0\\blur0.4\\fscx100\\fscy100\\1c&H636F1A&\\fad(0,%d)\\mover(%.3f,%.3f,%.3f,%.3f,%d,%d,%d,%d)\\p1}m 0 0 l 1 0 1 1 0 1"
					,3*char.duration/4,x,y,x+random_curve_xmove,y+random_curve_ymove,random_curve_angle1,random_curve_angle2,random_curve_radius1,random_curve_radius2)
					
					io.write_line(l)
				end
				
			end
			
		end
		
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			--standart line bord outfade
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local text_outline_shape = shape.tooutline(shape.split(text_shape), line.styleref.outline*8)
			local text_outline_pixels = convert.shape_to_pixels(text_outline_shape, true)
			
			if line.style=="ed_romanji" or line.style=="ed_kanji" then
				
				local l = table.copy(line)
				
				for pi, pixel in ipairs(text_outline_pixels) do
					
					l.layer=6
					
					l.start_time=line.end_time-250
					l.end_time=line.end_time+line.outfade
					
					x = syl.left + pixel.x
					y = syl.top + pixel.y
					
					random_curve_xmove_value=(math.random(-10,10)+math.random((-1*#line.syls),#line.syls))/2
					random_curve_xmove_amplifier=(math.random(2,4))
					random_curve_xmove=random_curve_xmove_value*random_curve_xmove_amplifier
					random_curve_ymove=(math.random(-45,45)+math.random((-1*#line.syls),#line.syls))/2
					random_curve_angle1=(syl.i-5)*(math.random(-10,-2))
					random_curve_angle2=(syl.i-5)math.random(1,5)
					random_curve_radius1=math.random(2,4)
					random_curve_radius2=math.random(3,5)
					
					alpha_array = {"&HFF&" , "&H00&" , "&HFF&" , "&HFF&" ,"&HFF&" , "&HFF&" , "&H00&" , "&HFF&"}
					random_alpha=alpha_array[math.random(1,table.getn(alpha_array))]
					
					l.text=string.format("{\\an7\\bord0\\blur0.8\\fscx100\\fscy100\\1c&HFFFFFF&\\alpha%s\\fad(0,%d)\\mover(%.3f,%.3f,%.3f,%.3f,%d,%d,%d,%d)\\p1}m 0 0 l 1 0 1 1 0 1"
					,random_alpha,3*syl.duration/4,x,y,x+random_curve_xmove,y+random_curve_ymove,random_curve_angle1,random_curve_angle2,random_curve_radius1,random_curve_radius2)
					
					io.write_line(l)
				end
				
			end
			
		end
		
	end
	
	for ci,char in ipairs(line.chars) do
		if char.text~="" then
			if line.style=="ed_romanji" or line.style=="ed_kanji" then
				--standard line bord effect
				
				local getshape = convert.text_to_shape(char.text, line.styleref)
				
				max_frame=25
				u_in=0
				u_out=0
				
				for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 7
					
					if char.i==#line.chars or char.i==#line.chars-1 then
						fad=250
					else
						fad=50
					end
					
					max=math.ceil(fad/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H32&")
						u_in=u_in+1
					elseif i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H32&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H32&"
					end
					
					local step = i / n
					local deform = shape.filter(getshape,
					function(x,y)
						local xdef = math.sin(y/(line.width/4)+step*50)*15
						local ydef = math.sin(x/(line.height/4)+step*50)*15
						return x+xdef, y+ydef
					end)
					
					if line.style=="ed_romanji" then
						xcomp=-1
						ycomp=-20
					end
					if line.style=="ed_kanji" then
						xcomp=-3
						ycomp=-12
					end
					
					l.text = string.format("{\\an8\\b1\\blur3\\bord4\\alpha%s\\fscx120\\fscy110\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)\\p4}%s"
					,alpha,char.center+xcomp,char.middle+ycomp,deform)
					
					io.write_line(l)
					
				end
			end
		end
		
	end
	
	for ci,char in ipairs(line.chars) do
		if char.text~="" then
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng write
				
				l.layer=3
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.end_time+line.outfade
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord0\\fscx120\\fscy100\\1vc(&H636F1A&,&H636F1A&,&H95A426&,&H95A426&)\\fad(250,750)\\pos(%.3f,%.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng bord write
				
				l.layer=3
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.end_time+line.outfade
				
				l.text=string.format("{\\b1\\an5\\blur1.2\\bord2.5\\1a&HFF&\\fscx120\\fscy100\\3c&HFFFFFF&\\fad(250,750)\\pos(%.3f,%.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng effect
				
				l.layer=2
				
				l.start_time=line.start_time+char.start_time
				l.end_time=line.start_time+char.end_time+500
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord1\\fscx120\\fscy100\\1a&HFF&\\t(\\fscx160\\fscy110)\\3c&HFFFFFF&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
				,3*char.duration/4,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng effect 2
				
				l.layer=2
				
				l.start_time=line.start_time+char.start_time
				l.end_time=line.start_time+char.end_time+500
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord1\\fscx120\\fscy100\\1a&HFF&\\t(\\fscx190\\fscy140)\\3c&HFFFFFF&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
				,3*char.duration/4,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng effect 3
				
				l.layer=2
				
				l.start_time=line.start_time+char.start_time
				l.end_time=line.start_time+char.end_time+500
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord1\\fscx120\\fscy100\\1a&HFF&\\t(\\fscx210\\fscy170)\\3c&HFFFFFF&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
				,3*char.duration/4,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng effect 4
				
				l.layer=2
				
				l.start_time=line.start_time+char.start_time
				l.end_time=line.start_time+char.end_time+500
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord1\\fscx120\\fscy100\\1a&HFF&\\t(\\fscx240\\fscy200)\\3c&HFFFFFF&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
				,3*char.duration/4,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng effect 5
				
				l.layer=2
				
				l.start_time=line.start_time+char.start_time
				l.end_time=line.start_time+char.end_time+500
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord1\\fscx120\\fscy100\\1a&HFF&\\t(\\fscx270\\fscy230)\\3c&HFFFFFF&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
				,3*char.duration/4,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng effect 6
				
				l.layer=2
				
				l.start_time=line.start_time+char.start_time
				l.end_time=line.start_time+char.end_time+500
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord1\\fscx120\\fscy100\\1a&HFF&\\t(\\fscx300\\fscy260)\\3c&HFFFFFF&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
				,3*char.duration/4,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng effect 7
				
				l.layer=2
				
				l.start_time=line.start_time+char.start_time
				l.end_time=line.start_time+char.end_time+500
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord1\\fscx120\\fscy100\\1a&HFF&\\t(\\fscx330\\fscy290)\\3c&HFFFFFF&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
				,3*char.duration/4,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng effect 8
				
				l.layer=2
				
				l.start_time=line.start_time+char.start_time
				l.end_time=line.start_time+char.end_time+500
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord1\\fscx120\\fscy100\\1a&HFF&\\t(\\fscx360\\fscy310)\\3c&HFFFFFF&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
				,3*char.duration/4,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng effect 9
				
				l.layer=2
				
				l.start_time=line.start_time+char.start_time
				l.end_time=line.start_time+char.end_time+500
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord1\\fscx120\\fscy100\\1a&HFF&\\t(\\fscx390\\fscy340)\\3c&HFFFFFF&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
				,3*char.duration/4,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_eng" or line.style=="ed_eng_overlap" then
				--eng effect 10
				
				l.layer=2
				
				l.start_time=line.start_time+char.start_time
				l.end_time=line.start_time+char.end_time+500
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord1\\fscx120\\fscy100\\1a&HFF&\\t(\\fscx410\\fscy370)\\3c&HFFFFFF&\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
				,3*char.duration/4,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			if line.style=="ed_alt" or line.style=="ed_kanji_alt" or line.style=="ed_overlap" or line.style=="ed_kanji_overlap" then
				--alt line write
				
				l.layer=2
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.end_time
				
				l.text=string.format("{\\b1\\an5\\blur0.6\\bord0\\fscx120\\fscy100\\1vc(&H636F1A&,&H636F1A&,&H95A426&,&H95A426&)\\fad(250,250)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if line.style=="ed_alt" or line.style=="ed_kanji_alt" or line.style=="ed_overlap" or line.style=="ed_kanji_overlap" then
				--alt bord write
				
				l.layer=2
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.end_time
				
				l.text=string.format("{\\b1\\an5\\blur1.2\\bord2.5\\1a&HFF&\\fscx120\\fscy100\\3c&HFFFFFF&\\fad(250,250)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
		end
	end
	
	for si, syl in ipairs(line.syls) do
		if syl.text~="" then
			
			if line.style=="ed_alt" or line.style=="ed_kanji_alt" or line.style=="ed_overlap" or line.style=="ed_kanji_overlap" then
				--alt effect 1
				
				local l = table.copy(line)
				
				for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do
					
					l.layer=3
					
					l.start_time=line.start_time+syl.start_time
					l.end_time=line.start_time+syl.end_time+1000
					
					xpos = syl.left + pixel.x
					ypos = syl.top + pixel.y
					
					rad=line.height*2
					
					ang = math.randomsteps(1, 360, 1)
					local x,y = math.ellipse(syl.center,syl.middle,rad,rad,ang)
					
					xmove=x
					ymove=y
					
					l.text=string.format("{\\an7\\bord0\\blur0.4\\shad0.5\\fscx100\\fscy100\\1c&H636F1A&\\t(\\1c&HFFFFFF&)\\fad(%d,%d)\\move(%.3f,%.3f,%.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
					,syl.duration/4,syl.duration/2,xpos,ypos,xmove,ymove)
					
					io.write_line(l)
				end
				
			end
		end
		
		if syl.text~="" then
			
			if line.style=="ed_alt" or line.style=="ed_kanji_alt" or line.style=="ed_overlap" or line.style=="ed_kanji_overlap" then
				
				l.layer=4
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\b1\\an5\\blur1\\bord0\\fscx120\\fscy100\\1c&HFFFFFF&\\fad(50,50)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
	end
	
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end