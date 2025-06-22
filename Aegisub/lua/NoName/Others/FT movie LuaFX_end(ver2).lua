

--# NyuFX1.5 ver.
--# ALKOON 


function roumaji(line, l)
	for si, syl in ipairs(l.syls) do
	local x = syl.left
	local y = syl.top

                  l.start_time = line.start_time  -250 + si * 40
	l.end_time = line.start_time  + syl.start_time  
	l.text = string.format("{\\an7\\fad(100,0)\\1c&Hffffff&\\3c&H000000&\\bord1\\be1\\shad0\\pos("..x..","..y..")}") ..syl.text
	io.write_line(l)

                  syl.c, syl.m = syl.center, syl.middle

		local text_shape = convert.text_to_shape(syl.text, line.styleref)
		local text_outline_shape = shape.tooutline(shape.split(text_shape), line.styleref.outline*8)
		local text_outline_pixels = convert.shape_to_pixels(text_outline_shape, true)

		for pi, pixel in ipairs(text_outline_pixels) do
		local a = pixel.a == 255 and "" or "\\1a" .. convert.a_to_ass(pixel.a)
		local x, y = pixel.x + math.floor(syl.left), pixel.y + math.round(syl.top)

		local orgx, orgy = math.round(syl.c), math.round(syl.m) 
		local p_orgx, p_orgy =  syl.width/2  , syl.height/2 +1
		local distance = math.distance(p_orgx, p_orgy)

		local p_distance = math.distance( pixel.x - p_orgx,  pixel.y - p_orgy )
		local p_pct =  p_distance/distance   
		local timex =  p_pct * (syl.duration)  + 200
		local timx =  p_pct * (syl.duration) 
                                    l.layer = 2
                          	l.start_time = line.start_time + syl.start_time 
		l.end_time = line.start_time + syl.start_time + syl.duration +200  
		l.text = string.format("{\\an7\\org(%.3f,%.3f)\\fscx90\\fscy90\\t(10,"..timex..",\\frz360)\\move(%d,%d,%d,%d,0,"..timex..")\\1c&H000000&\\3c&H000000&\\bord0\\%s\\p1}%s", orgx, orgy, x,y, x, y, a,"m 0 0 l 1 0 1 1 0 1")
		io.write_line(l)

                          	l.start_time = line.start_time + syl.start_time + syl.duration +200 
		l.end_time = line.end_time +150
                                    dur = l.end_time  - l.start_time
		l.text = string.format("{\\an7\\org(%.3f,%.3f)\\fscx90\\fscy90\\frz360\\fad(0,".. timx..")\\move(%d,%d,%d,%d)\\1c&H000000&\\3c&H000000&\\bord0\\%s\\p1}%s", orgx, orgy, x,y, x, y, a,"m 0 0 l 1 0 1 1 0 1")
		io.write_line(l)
		end

		for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do

		local a = pixel.a == 255 and "" or "\\1a" .. convert.a_to_ass(pixel.a)
		local x, y = pixel.x + math.floor(syl.left), pixel.y + math.round(syl.top)
		local orgx, orgy = math.round(syl.c), math.round(syl.m) 
		local p_orgx, p_orgy =  syl.width/2  , syl.height/2 +1
		local distance = math.distance(p_orgx, p_orgy)

		local p_distance = math.distance( pixel.x - p_orgx,  pixel.y - p_orgy )
		local p_pct =  p_distance/distance   
		local timex =  p_pct * (syl.duration)  + 200
		local timx =  p_pct * (syl.duration) 
 
                          	l.start_time = line.start_time + syl.start_time 
		l.end_time = line.start_time + syl.start_time + syl.duration +200  
		l.text = string.format("{"..a.."\\an7\\bord0\\shad0\\org(%.3f,%.3f)\\t(10,"..timex..",\\frz360)\\move(%d,%d,%d,%d,0,"..timex..")}"
                                    , orgx, orgy, x,y,  x,y ) .. "{\\p1}m 0 0 l 1 0 l 1 1 l 0 1 "                             
	 	io.write_line(l)

                  	l.start_time = line.start_time + syl.start_time + syl.duration+200
		l.end_time = line.end_time  +150
		l.text = string.format("{"..a.."\\an7\\bord0\\shad0\\org(%.3f,%.3f)\\fad(0,".. timx..")\\frz360\\move(%.3f,%.3f,%.3f,%.3f)}"
                                    , orgx, orgy, x,y,  x,y ) .. "{\\p1}m 0 0 l 1 0 l 1 1 l 0 1 "
	 	io.write_line(l)

		end

	end
end
 

for li, line in ipairs(lines) do
	 if not line.comment then
		roumaji( line, table.copy(line) )
	 end
	io.progressbar(li / #lines)
end

