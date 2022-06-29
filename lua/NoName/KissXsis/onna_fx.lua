function ts(line, l)
	for si,syl in ipairs(line.syls) do
		
		local text_shape = convert.text_to_shape(syl.text, line.styleref)
		
		l.text = string.format("{\\p4\\an7\\blur0.5\\fry4\\shad0\\1c&H522D20&\\pos(%.3f, %.3f)}%s"
		,syl.center-syl.width/2,syl.middle-syl.height/2,text_shape)
		
		io.write_line(l)
	end
end

for li, line in ipairs(lines) do
	
	ts( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end