function noragami(line, l)
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=1
			
			l.start_time=line.start_time+100*syl.i-100
			l.end_time=line.end_time-50*syl.i+100
			
			outfade_start=(line.end_time-50*syl.i)-(line.start_time+syl.end_time)-50
			outfade_end=(line.end_time-50*syl.i)-(line.start_time+syl.end_time)
			
			
			l.text=string.format("{\\an5\\bord0\\blur0.5\\fscx150\\fscy150\\t(0,275,\\fscx100\\fscy100)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)}%s"
			,syl.center,syl.middle,syl.center+400,syl.middle,outfade_start,outfade_end,syl.text)
			
			
			io.write_line(l)
		end
	end	


end
for li, line in ipairs(lines) do
	
	noragami( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end