function kara(line, l)
	--Mahou Sensou ED
	--Karaoke by Amberdrake
	
	for si,syl in ipairs(line.syls) do
		
		if line.infade>250 then
			line.infade=250
		end
		
		if line. outfade>250 then
			line.outfade=250
		end
		
		if syl.text~="" then
			if line.style=="ED_yeah" then
				--first line
				
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				if syl.i==1 then
					move_x=20
					move_y=20
					rotation=5
					color_change="\\1vc(&H1717C6&,&H1717C6&,&HC2465C&,&HC2465C&)\\t(\\1vc(&HC2465C&,&HC2465C&,&H1717C6&,&H1717C6&))"
				end
				
				if syl.i==2 then
					move_x=-20
					move_y=20
					rotation=-5
					color_change="\\1vc(&HC2465C&,&HC2465C&,&H1717C6&,&H1717C6&)\\t(\\1vc(&H1717C6&,&H1717C6&,&HC2465C&,&HC2465C&))"
				end
				
				l.text=string.format("{\\an5\\blur2\\bord0.5\\shad2\\jitter(2,5,5,3,2)\\fscx100\\fscy100\\frz0\\t(\\fscx180\\fscy180\\frz%d)%s\\3c&HFFFFFF&\\4c&H000000&\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,rotation,color_change,syl.center,syl.middle,syl.center+move_y,syl.middle+move_y,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_bring_down" then
				--second line
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.end_time
				
				if syl.i==1 then
					syl_color="1c&H2F502C&"
					move_x=-60
				end
				
				if syl.i==2 then
					syl_color="1c&H4C3210&"
					move_x=-20
				end
				
				if syl.i==3 then
					syl_color="1c&H1A05B6&"
					move_x=20
				end
				
				if syl.i==4 then
					syl_color="1c&H71D1C8&"
					move_x=60
				end
				
				l.text=string.format("{\\an5\\blur2\\bord0.5\\shad2\\fscx100\\fscy100\\t(\\fscx130\\fscy130)\\%s\\3c&HFFFFFF&\\4c&H000000&\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl_color,syl.center,syl.middle,syl.center+move_x,syl.middle+10,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_stereotypical" then
				--stereotypical effect
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.end_time
				
				if syl.i==1 then
					syl_color="1c&HFFFFFF&"
					grow="fscx100\\fscy100"
					start_x=-50
					move_x=-90
				end
				
				if syl.i==2 then
					syl_color="1c&HFFFFFF&"
					grow="fscx100\\fscy100"
					start_x=-50
					move_x=-70
				end
				if syl.i==3 then
					syl_color="1c&HFFFFFF&"
					grow="fscx100\\fscy100"
					start_x=-50
					move_x=-60
				end
				
				if syl.i==4 then
					syl_color="1c&H171C87&"
					grow="fad(50,0)\\fscx30\\fscy30\\t(0,150,\\fscx160\\fscy160)"
					start_x=50
					move_x=50
				end
				if syl.i==5 then
					syl_color="1c&H171C87&"
					grow="fad(50,0)\\fscx30\\fscy30\\t(0,150,\\fscx160\\fscy160)"
					start_x=125
					move_x=175
				end
				
				l.text=string.format("{\\an5\\blur0.6\\bord0\\%s\\jitter(6,3,6,3,100,100)\\%s\\move(%.3f,%.3f,%.3f,%.3f,0,150)}%s"
				,grow,syl_color,syl.center+start_x,syl.middle,syl.center+move_x,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_playing" then
				--playing fadein
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\blur1.2\\bord0\\shad1\\fad(250,0)\\fscx200\\fscy200\\t(0,150,\\fscx100\\fscy100)\\1c&H110600&\\4c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_playing" then
				--playing effect
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur1.2\\bord0\\shad1\\fscx100\\fscy100\\1c&H110600&\\4c&HFFFFFF&\\jitter(5,3,5,6,75,75)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_playing" then
				--playing fadeout
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time+50*syl.i-line.outfade
				
				l.text=string.format("{\\an5\\blur1.2\\bord0\\shad1\\fscx100\\fscy100\\1c&H110600&\\4c&HFFFFFF&\\fad(0,250)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_grid" then
				--grid fadein
				l.layer=1
				
				l.start_time=line.start_time+50*syl.i+line.outfade
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0.5\\blur1\\be1\\fscx100\\fscy100\\1c&H3D2618&\\3c&H3D2618&\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.center+150,syl.middle,syl.center+25,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_grid" then
				--grid effect
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord2\\blur1\\be1\\fscx100\\fscy100\\1c&H3D2618&\\3c&HFFFFFF&\\jitter(3,5,3,5,100,100)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.center+25,syl.middle,syl.center-50,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_grid" then
				--grid fadeout
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time+50*syl.i-line.outfade
				
				l.text=string.format("{\\an5\\bord0.5\\blur1\\be1\\fscx100\\fscy100\\1c&H3D2618&\\3c&H3D2618&\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.center-50,syl.middle,syl.center-350,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_count" then
				--count fadein
				l.layer=1
				
				l.start_time=line.start_time+50*syl.i-line.outfade
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.6\\fscx100\\fscy100\\1c&HFFFFFF&\\fad(100,0)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_main_romanji" or line.style=="ED_main_kanji" then
				--main fadein
				l.layer=1
				
				l.start_time=line.start_time+50*syl.i-line.outfade
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0.5\\blur0.6\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&H000000&\\fad(100,0)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_count" or line.style=="ED_main_romanji" or line.style=="ED_main_kanji" then
				--count and main effect
				
				local l = table.copy(line)
				
				for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref) ) do
					
					l.layer=1
					
					random_jitter=math.random(1,10)
					
					l.start_time=line.start_time+syl.start_time
					l.end_time=line.start_time+syl.end_time
					
					x = syl.left + pixel.x
					y = syl.top + pixel.y
					
					l.text=string.format("{\\an5\\bord0\\shad2\\blur1\\fscx100\\fscy100\\jitter(%d,%d,%d,%d,%d,%d)\\1c&HFFFFFF&\\4c&H000000&\\pos(%.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
					,random_jitter,random_jitter,random_jitter,random_jitter,random_jitter,random_jitter,x,y)
					
					io.write_line(l)
				end
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_count" or line.style=="ED_main_romanji" or line.style=="ED_main_kanji" then
				--count and romanji effect 2
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord2\\blur2\\1a&HFF&\\3a&H32&\\3c&HFFFFFF&\\fscx90\\fscy90\\t(\\fscx110\\fscy110)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_count" then
				--count fadeout
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.6\\1c&HFFFFFF&\\jitter(1,1,1,1,.1,.1)\\fad(0,100)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			if line.style=="ED_main_romanji" or line.style=="ED_main_kanji" then
				--main fadeout
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time+50*syl.i-line.outfade
				
				l.text=string.format("{\\an5\\bord0.5\\blur0.6\\1c&HFFFFFF&\\3c&H000000&\\jitter(1,1,1,1,.1,.1)\\fad(0,100)\\pos(%.3f,%.3f)}%s"
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