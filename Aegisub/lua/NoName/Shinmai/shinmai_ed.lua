--Shinmai Maou no Testament ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 250 then
		line.infade = 250
	end
	if line.outfade > 250 then
		line.outfade = 250
	end
	if line.style == "Shinmai_ED_romaji" or line.style == "Shinmai_ED_kanji" then
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--placeholder
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.start_time+syl.start_time
				
				l.text = string.format("{\\an5\\blur4\\bord0.3\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HFFFFFF&\\fad(250,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx
				
				local maxj = syl.width + 10
				for j = 1, maxj, 1 do
					
					l.layer = 6
					
					l.start_time = line.start_time+syl.start_time
					l.end_time = line.start_time+syl.end_time
					
					local clip_src = shape.rectangle(1,syl.height+40)
					local clip = shape.move(clip_src,syl.left-5+j,syl.top-20)
					
					local alpha = utils.interpolate(j/maxj, "&HFF&", "&H00&")
					
					l.text = string.format("{\\an5\\blur4\\bord0.3\\shad0\\fscx100\\fscy100\\alpha&H00&\\t(\\alpha%s)\\1c&HFFFFFF&\\3c&HFFFFFF&\\fad(0,%d)\\clip(%s)\\pos(%.3f, %.3f)}%s"
					,alpha,syl.duration/3,clip,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
			end
		end
	end
	
	if line.style == "Shinmai_ED_TL" then
		
		l.layer = 5
		
		l.start_time = line.start_time-line.infade
		l.end_time = line.end_time+line.outfade
		
		l.text = string.format("{\\an5\\blur4\\bord0.3\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HFFFFFF&\\fad(250,250)\\pos(%.3f, %.3f)}%s"
		,line.center,line.middle,line.text)
		
		io.write_line(l)
	end
	
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end