function romaji(line, l)
	--Akame ga Kill OP2
	--Karaoke by Amberdrake
	--VSFilter
	
	if line.infade > 150 then
		line.infade = 150
	end
	if line.outfade > 500 then
		line.outfade = 500
	end
	
	if line.style == "Akame_OP_TL" then

			if line.text~="" then
				--line fx
				
				l.layer=5
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.end_time+line.outfade
				
				local xpos, ypos = line.left, line.top
				
				l.text=string.format("{\\p4\\an7\\blur5\\bord2\\fscx100\\fscy100\\1c&HFFFFF4&\\3c&H926023&\\fad(250,250)\\pos(%.3f,%.3f)}%s"
				,xpos,ypos,line.text)
				
				io.write_line(l)
			end
	end
end
for li, line in ipairs(lines) do
	
	romaji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end