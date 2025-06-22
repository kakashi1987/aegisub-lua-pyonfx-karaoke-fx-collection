function romaji(line, l)
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=1
			
			l.start_time=line.start_time+75*syl.i
			l.end_time=line.end_time
			l.text=string.format("{\\an5\\bord0\\blur0.5\\fscx100\\fscy100\\pos(%.3f,%.3f)\\fad(175,0)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end	


end
for li, line in ipairs(lines) do
	
	romaji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end