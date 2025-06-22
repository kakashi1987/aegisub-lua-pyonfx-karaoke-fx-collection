
--ver 1.3

for li, line in ipairs(lines) do
local l = table.copy(line)
                     
           if line.text == " " then l.text = string.format("{ Hello World  XD }") else
	local function x_y_fix(x,y)
		return math.floor(line.left * 8 + x), math.floor(line.top * 8 + y)
	end

                     local sp = "m 5 0 b -2 0 -2 10 5 10 b 12 10 12 0 5 0"
	   local mask = BuildPath(GetPath(line.styleref,line.text),x_y_fix)

                     local max = line.height/2
                     for j = 0 , max do
                                 local randx = {"\\1c&H0400DF&","\\1c&H2391EE&"} 	       	
	               cc = randx[math.random(1,2)]
                                 local alfa = string.format("\\1a&H%02x&",math.random(60,100))
                                 local x, y = line.left, line.center
                                 l.start_time = line.start_time -870  
                                 l.end_time = line.end_time + 700
                                 local fs = math.random(150,220)
                                 --Drawx = string.format("{\\an5%s%s\\move(%3.f,%3.f,%3.f,%3.f)\\fad(100,150)\\bord0\\blur3\\fscx%s\\fscy%s\\p1}%s",cc,alfa,x+math.random(-line.width/2,line.width)+50,y+10+math.random(line.height/2,line.height/2),x+math.random(-line.width/2,line.width)+50,y-20+math.random(-line.height/2,line.height/2),fs,fs,sp)
                                 Drawx = string.format("{\\an5%s%s\\pos(%3.f,%3.f)\\fad(100,150)\\bord0\\blur3\\fscx%s\\fscy%s\\p1}%s",cc,alfa,x+math.random(-line.width,line.right),y+5+math.random(-line.height/2,line.height/2),fs,fs,sp)
                                 masks = string.format("{\\an5\\bord1\\3c&HFFFFFF&\\blur0\\shad0\\clip(4,%s)\\pos(%3.f,%3.f)}",mask,x,y) 	
               	               l.text = Drawx .. masks 
                                 l.effect = "movshap_FX"
                                 l.layer = 5
	               Output(l)      
                     end  
             end


       for ci, char in pairs(line.chars) do 
            if char.text == " " then l.text = string.format("{ Hello World  XD}") else
	   local function x_y_fix(x,y)
		return math.floor(char.left * 8 + x), math.floor(line.top * 8 + y)
	   end
	   local mask = BuildPath(GetPath(line.styleref, char.text), x_y_fix)

                                 local randx = {"\\1c&H6969AE&","\\1c&H0A3AD6&"}	       	
	               cc = randx[math.random(1,2)]
                                 local alfa = string.format("\\1a&H%02x&",math.random(60,60))

                     local x, y = char.left, line.top+15
                     local l = table.copy(line)  
                
                     local rd = "&Hffffff&"
                     l.start_time = line.start_time  -900
                     l.end_time = line.start_time  -100
                     l.effect = "Infad_FX"
                     l.layer = 1
                     local drawx = string.format("m 14 3 b 14 3 9 -1 4 3 b 4 3 0 8 4 13 b 4 13 9 17 14 13 b 14 13 18 8 14 3  ")     
               	   l.text = string.format("{\\1c"..rd.."\\blur5\\fad(100,0)\\bord0\\fscx450\\fscy450\\t(\\fscx600\\blur4\\fscy600)\\p1}%s{\\an5\\bord0\\clip(4,%s)\\move(%.3f,%.3f,%.3f,%.3f)}",drawx, mask,char.left, line.top+25+math.random(-line.height*5,line.height*5),char.left, line.top+25)   
	   Output(l) 
 
                     l.start_time = line.start_time  -100
                     l.end_time = line.end_time + 50
                     l.layer = 1
                     local drawx = string.format("m 14 3 b 14 3 9 -1 4 3 b 4 3 0 8 4 13 b 4 13 9 17 14 13 b 14 13 18 8 14 3  ")     
                 	   l.text = string.format("{\\1c"..rd.."\\\blur0\\bord0\\fscx700\\fscy700\\p1}%s{\\an5\\bord0\\clip(4,%s)\\pos(%.3f,%.3f)}",drawx, mask,char.left, line.top+25+math.random(-line.height/2,line.height/2))   
	   Output(l) 

                     l.start_time = line.end_time + 50
                     l.end_time = l.start_time + 800
                     local tt =  l.end_time - l.start_time 
                     l.effect = "Outfad_FX"
                     l.layer = 1
                     local drawx = string.format("m 14 3 b 14 3 9 -1 4 3 b 4 3 0 8 4 13 b 4 13 9 17 14 13 b 14 13 18 8 14 3  ")     
               	   l.text = string.format("{\\1c"..rd.."\\blur3\\bord0\\fad(0,170)\\fscx700\\fscy700\\t(%3.f,%3.f,\\fscx0\\fscy0\\blur4)\\p1}%s{\\an5\\bord0\\shad0\\clip(4,%s)\\pos(%.3f,%.3f)}",tt-800,tt+200,drawx, mask,char.left, line.top+25+math.random(-line.height/2,line.height/2))   
	   Output(l)   
            end
      end 

 
   for si, syl in pairs(line.syls) do

                     local x, y = syl.left, line.top-1
                     local l = table.copy(line)  
                     l.start_time = line.start_time -200
                     l.end_time = line.end_time +230
                     l.layer = 0
                	   l.text = string.format("{\\an7\\bord1\\fad(90,80)\\3c&H2B09AB&\\4c&H000000&\\1a&Hff&\\shad2\\blur2\\3a&H30&\\1c&HFFFFFF&\\pos(%.3f,%.3f)}%s",x,y,syl.text) 
	   Output(l)   

                     local dur = syl.duration
                     local x, y = syl.left, line.top
                     l.start_time = line.start_time  + syl.start_time
                     l.end_time = l.start_time  + syl.duration + 150
             	   l.text = string.format("{\\an7\\\pos(%3.f,%3.f)\\1a&HFF&\\3c&HFFFFFF&\\fad(50,80)\\bord0\\t(%3.f,%3.f,\\bord3.40\\blur5.50)\\t(%3.f,%3.f,\\bord0)}%s" , x,y,0,dur/2+60,dur/2+60,dur,syl.text)
	   Output(l)

             if syl.text == ""  then l.text = string.format (" Hello World  XD ")  else
 
	local function x_y_fix(x,y)
		return math.floor(syl.left * 8 + x), math.floor(line.top * 8 + y)
	end
 
                      local sp = "m 5 0 b -2 0 -2 10 5 10 b 12 10 12 0 5 0  "
                      local mask = BuildPath(GetPath(line.styleref,syl.text),x_y_fix)
                      local max = syl.height/2
                      for j = 0 , max do
                                 local randx = {"\\1c&H0400DF&","\\1c&H2391EE&"}	       	
	               cc = randx[math.random(1,2)]
                                 alfa = string.format("\\1a&H%02x&",math.random(20,60))
                                 x, y = syl.left, line.center
                                 l.start_time = line.start_time+syl.start_time  + syl.duration*(j/max) 
                                 l.end_time =  line.start_time+syl.start_time + syl.duration*(j/max)  + 300
                                 Drawx = string.format("{\\an5%s\\move(%3.f,%3.f,%3.f,%3.f)\\fad(100,100)\\bord0\\blur3\\fscx180\\fscy180\\p1}%s",cc,x+math.random(-syl.width/2,syl.width/2)+20,y+10+math.random(-syl.height/2,syl.height/2),x+math.random(-syl.width/2,syl.width),y-25+math.random(-syl.height/2,syl.height/2),sp)
                                 masks = string.format("{\\an5\\bord1\\3c&HFFFFFF&\\blur0\\shad0\\clip(4,%s)\\pos(%3.f,%3.f)}",mask,x,y) 	
               	               l.text = Drawx .. masks 
                                 l.effect = "Syllable_FX"
                                 l.layer = 5
	               Output(l)      
                     end  
             end    
    end 
ProgressStatus(li / #lines *100)
end
