 function roumaji(line, l)


 	  for si, syl in ipairs(line.syls) do

                    local m = -18
                    local x, y = math.round(syl.left), math.round(line.top)
  +m
                    c1 = "\\1c&HF5F3F2&\\4c&H47403D&\\shad1.5"

                    sp = "{\\clip(1,m 115 35 l 115 35 l 115 35 l 115 35 b 115 35 147 44 179 35 b 179 35 211 20 242 34 b 242 34 286 44 313 35 b 313 35 353 23 386 35 b 386 35 421 43 452 35 b 452 35 487 21 520 35 b 520 35 553 42 586 34 b 586 34 619 23 658 34 b 658 34 685 46 727 32 b 727 32 761 22 796 32 b 796 32 828 44 863 36 b 898 23 931 36 931 36 b 931 36 964 47 996 35 b 996 35 1034 22 1066 35 b 1066 35 1066 35 1066 35 b 1103 46 1138 35 1138 35 l 1135 146 l 1135 146 l 116 146 l 115 35)}"
                    l.text = string.format("{\\an7\\pos(%d,%d)\\fad(70,0)"..c1.."\\bord0}%s",x,y,syl.text) ..sp
                    l.start_time = line.start_time - 100
                    l.end_time = line.start_time + syl.start_time
                    l.layer=3
                    io.write_line(l)


                    sp1 = "{\\iclip(1,m 115 35 l 115 35 l 115 35 l 115 35 b 115 35 147 44 179 35 b 179 35 211 20 242 34 b 242 34 286 44 313 35 b 313 35 353 23 386 35 b 386 35 421 43 452 35 b 452 35 487 21 520 35 b 520 35 553 42 586 34 b 586 34 619 23 658 34 b 658 34 685 46 727 32 b 727 32 761 22 796 32 b 796 32 828 44 863 36 b 898 23 931 36 931 36 b 931 36 964 47 996 35 b 996 35 1034 22 1066 35 b 1066 35 1066 35 1066 35 b 1103 46 1138 35 1138 35 l 1135 146 l 1135 146 l 116 146 l 115 35)}"
	
                    l.text = string.format("{\\an7\\pos(%d,%d)\\fad(70,70)"..c1.."\\bord0}%s",x,y,syl.text) .. sp1
                    l.start_time = line.start_time - 100
                    l.end_time = line.end_time + 100
                    l.layer=3
                    io.write_line(l)
 

	for i, pixel in ipairs( convert.text_to_pixels(syl.text, line.styleref) ) do


		local x, y = math.round(syl.left + pixel.x), math.round(line.top + pixel.y)
 +m
		local a =  convert.a_to_ass(pixel.a)


 		l.start_time = line.start_time + syl.start_time 
		l.end_time = line.start_time + syl.start_time  + (pixel.x / syl.width )* syl.duration  
    	                  l.text = string.format("{"..c1.."\\an7\\bord0\\pos(%d,%d)\\1a"..a.."\\4a"..a.."\\p1}m 0 0 l 1 0 1 1 0 1" , x,y) ..sp
                                    l.layer=3
	                  io.write_line(l)

 		l.start_time = line.start_time + syl.start_time  + (pixel.x / syl.width )* syl.duration
		l.end_time = line.start_time + syl.start_time  + (pixel.x / syl.width )* syl.duration + 200
    	                  l.text = string.format("{\\shad1"..c1.."\\an7\\shad1\\bord0\\fad(0,"..math.random(150,220)..")\\move(%d,%d,%d,%d)\\1a"..a.."\\4a"..a.."\\t(0,"..(syl.duration/2)..",\\1c&HFFFFFF&)\\p1}m 0 0 l 1 0 1 1 0 1" ,
 	                  x,y,x+math.random(-10,10),y+math.random(45,60)) ..sp
                                    l.layer=3
	                  io.write_line(l)


	end

                  end
	
end




for li, line in ipairs(lines) do

 if not line.comment then 
		roumaji(line, table.copy(line))

 	io.progressbar(li / #lines)

  end
end
