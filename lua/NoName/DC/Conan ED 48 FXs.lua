 
script_name = "Apply script - Conan ED"
script_description = "Conan ED 48 FXs"
script_author = "alkoon"
script_version = "1.1.0"
 
include("karaskel.lua")
function doFX(subs, meta, line,config) 
                      
                      local l = table.copy(line)

                      if line.actor == "4" then 
                      local x, y =  line.center, line.middle

                                                     l.start_time = line.start_time -100
                                                     l.end_time =  line.end_time +100
                                                     l.layer = 1   
                                                     l.text = string.format("{\\an5\\shad0\\bord2\\be2.5\\1c&Hffffff&\\3c&H4D4555&\\pos(%d,%d)\\fad(100,100)}%s",x,y, l.text )
                                                     subs.append(l)

                      elseif line.actor == "5" then 
                      local x, y =  line.center, line.middle

                                                     l.start_time = line.start_time -100
                                                     l.end_time =  line.end_time 
                                                     l.layer = 1   
                                                     l.text = string.format("{\\an5\\shad0\\bord2\\be2.5\\1c&Hffffff&\\3c&H4D4555&\\pos(%d,%d)\\fad(100,400)}%s",x,y, l.text )
                                                     subs.append(l)

                      end

                      local posx = 0  
                      for c in unicode.chars(line.text_stripped) do 
                      posx = posx+ 1
                      end
                      local ps_t = 0  	

                      for i = 1, line.kara.n do
                      local syl = line.kara[i] 
                      local x, y =  line.left + syl.center, line.middle
                      local syllable = table.copy(syl)

                     if line.actor == "3" then 

                                                               posx, posy =  line.left + syl.center, line.middle+4
                                                               j =  syl.width + 10
                                                                for loop =1, j do 		              
		                                       poy = posy 
		                                       pos_x =  posx+(loop-syl.width/2)  
                                         	                     local alf =string.format("\\3a&H%02X&",200) 
		                                       l.start_time = line.start_time + syllable.start_time + (loop/j)*syl.duration  
		                                       l.end_time =   line.start_time + syllable.start_time + syl.duration + 500+ (loop/j)*syl.duration  
		                                       l.text = string.format("{\\an5\\bord1.5\\blur1.5"..alf.."\\fad(0,150)\\3c&Hffffff&\\3c&H000000&\\p1\\fscx45\\fscy45\\move(%d,%d,%d,%d)}", pos_x,posy,posx+math.random(-25,10),posy+math.random(-50,-40)) .. "m 0 0 l 4 0 l 4 3 l 0 3 l 0 0 "
		                                       l.layer=5
		                                      subs.append(l) 
                                                                end


	                        local charx = table.copy(syl) 
	                        local pos_x = 0
	                        for c in unicode.chars(syl.text_stripped) do 
	                        charx.text = c
	                        x_width = aegisub.text_extents(line.styleref, charx.text)
	                        local x, y = line.left+syl.left  + x_width /2 + pos_x, line.middle	
                                          if charx.text == " " or charx.text == "" then line.comment = false else

                                              ps_t = ps_t + 1 

                                                     local l = table.copy(line)
                                                     l.start_time = line.start_time -800 + math.floor ( ps_t*70)   
                                                     l.end_time =  line.start_time -200 + math.floor ( ps_t*70)   
                                                     l.layer = 1   
                                                     l.text = string.format("{\\an5\\bord1\\be2\\1c&Hffffff&\\3c&H5A5263&\\org(%d,%d)\\move(%d,%d,%d,%d)\\fad(150,0)\\frx90\\frz-30\\t(\\frx0\\frz0)}%s",x,y, x,y-syl.height,x,y,charx.text )
                                                     subs.append(l)

                                                     l.start_time = line.start_time -200 + math.floor( ps_t*70)   
                                                     l.end_time = line.start_time +syl.start_time  
                                                     l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\bord1\\be2\\1c&Hffffff&\\3c&H5A5263&}%s", x,y,x,y,charx.text )
                                                     l.layer = 1
                                                     subs.append(l)

                                                     pos_x=pos_x+x_width

                                             end
                                             end	


                                               if syl.text_stripped == " " or syl.text_stripped == ""  then line.comment = false else
                                               posx, posy =  line.left + syl.center, line.middle
 
                   
                                                               local dist = 1	--|| UP \ Unmove ||--
                                                               j = line.height  *dist + 20	 
                                                                for loop =1,  j do 	
		                                       pos_x =  posx  + (loop - syl.width/2 - 5)*dist 
		                                       l.start_time = line.start_time + syllable.start_time 
		                                       l.end_time =  line.start_time + syllable.end_time + ((loop/j)-1)*syl.duration  
		                                       l.text = string.format("{\\an5\\bord1\\be2\\1c&Hffffff&\\3c&H5A5263&\\move(%d,%d,%d,%d)\\clip(%d,%d,%d,%d)}",posx,posy,posx,posy,  pos_x, posy-syl.height/2, pos_x +dist , posy+(syl.height/6)-(3) ) ..  syl.text_stripped 
		                                       l.layer=2
		                                       subs.append(l) 
                                                                end
 

                                                                local dist = 1	--|| UP \ Move ||--	 
                                                                for loop =1, line.height  *dist + 20 do 		              
		                                       poy = posy -10
		                                       pos_x =  posx  + (loop - syl.width/2-5)*dist 
		                                       l.start_time = line.start_time + syllable.end_time  + ((loop/j)-1)*syl.duration  
		                                       l.end_time =   line.start_time + syllable.end_time + ((loop/j)-1)*syl.duration  +400
                                                                           clp1 = string.format("{\\clip(%d,%d,%d,%d)",pos_x, posy-syl.height/2, pos_x +dist , posy+(syl.height/6)-(3))
                                                                           clp2 = string.format("%s\\t(\\clip(%d,%d,%d,%d)}",clp1, pos_x, posy-syl.height/6-(3)-(10), pos_x +dist , posy+(syl.height/6)-(3)-(10))
		                                       l.text = string.format("{\\an5\\bord1\\be2\\1c&Hffffff&\\3c&H5A5263&\\fad(0,100)\\move(%d,%d,%d,%d)}%s", posx,posy,posx,poy, clp2) .. syllable.text_stripped
		                                       l.layer=2
		                                       --subs.append(l) 
                                                                end

                                                                ----------------------------------------------------------------------------------

 
                                                               local dist = 1	--|| Down \ Unmove ||--
                                                               j = line.height  *dist + 20
                                                                for loop =1,  j do 	
		                                       pos_x =  posx  + (loop - syl.width/2-5 )*dist 
		                                       l.start_time = line.start_time + syllable.start_time 
		                                       l.end_time =  line.start_time + syllable.end_time + ((loop/j)-1)*syl.duration  
		                                       l.text = string.format("{\\an5\\bord1\\be2\\1c&Hffffff&\\3c&H5A5263&\\move(%d,%d,%d,%d)\\clip(%d,%d,%d,%d)}",posx,posy,posx,posy,  pos_x, posy-(syl.height/20)+(4), pos_x +dist , posy+syl.height) ..  syl.text_stripped 
		                                       l.layer=2
		                                      subs.append(l) 
                                                                end

                                                                local dist = 1	--|| Down \ Move ||--	 
                                                                for loop =1, line.height  *dist + 20  do 		              
		                                       poy = posy +10
		                                       pos_x =  posx  + (loop - syl.width/2 -5)*dist 
		                                       l.start_time = line.start_time + syllable.end_time  + ((loop/j)-1)*syl.duration  
		                                       l.end_time =   line.start_time + syllable.end_time +400 + ((loop/j)-1)*syl.duration  
                                                                           clp1 = string.format("{\\clip(%d,%d,%d,%d)",pos_x, posy-(syl.height/20)+(4), pos_x +dist , posy+syl.height)
                                                                           clp2 = string.format("%s\\t(\\clip(%d,%d,%d,%d)}",clp1, pos_x, posy-(syl.height/20)+(4)+(10), pos_x +dist , posy+syl.height+10)
		                                       l.text = string.format("{\\an5\\bord1\\be2\\3c&H5A5263&\\1c&Hffffff&\\fad(0,100)\\move(%d,%d,%d,%d)}%s", posx,posy,posx,poy, clp2) .. syllable.text_stripped
		                                       l.layer=2
		                                     --  subs.append(l) 
                                                                end

                                                end



                     elseif line.actor == "2" then

                    l.text = string.format("{\\an5\\pos(%d,%d)\\fad(90,90)\\1c&HFFFFFF&\\3c&H5A5263&\\bord2\\be2.5}%s",x,y,syl.text)
                    l.start_time = line.start_time - 100
                    l.end_time = line.end_time+100
                    l.layer=3
                    subs.append(l)

                    if line.effect =="fx1" then
                    l.text = string.format("{\\an5\\pos(%d,%d)\\fad(90,100)\\clip(m 519 7 l 543 77 176 77 178 6)\\1c&HEBBEC8&\\3c&H5A5263&\\bord2\\be2.5}%s",x,y,syl.text)
                    l.start_time = line.start_time +5450
                    l.end_time = line.end_time +100
                    l.layer=3
                    subs.append(l)

                    l.text = string.format("{\\an5\\pos(%d,%d)\\fad(90,100)\\clip(m 530 10 l 551 73 1075 79 1074 8)\\1c&HE1A2A9&\\3c&H5A5263&\\bord2\\be2.5}%s",x,y,syl.text)
                    l.start_time = line.start_time +6300
                    l.end_time = line.end_time  +100
                    l.layer=3
                    subs.append(l)
 
                    l.text = string.format("{\\an5\\pos(%d,%d)\\fad(90,100)\\clip(m 529 8 l 520 11 537 60 547 59)\\1c&H000000&\\3c&H5A5263&\\bord2\\be2.5}%s",x,y,syl.text)
                    l.start_time = line.start_time +5450
                    l.end_time = line.end_time  +100
                    l.layer=3
                    subs.append(l)
                    end

                                    local dr = syl.duration
		l.text = string.format("{\\an5\\pos(%f,%f)\\shad1.3\\4c&HFFFFFF&\\bord1.5\\be2\\1c&H00000&\\3c&HFFFFFF&\\t(0,"..dr/(2)..",\\fscx125\\fscy125\\3c&H00000&\\1c&HFFFFFF&)\\t("..dr/(2)..","..dr..",\\shad0\\1c&H481C0A&\\3c&HFFFFFF&\\fscx100\\fscy100)\\t(\\alpha&H%d&)}%s",x,y,syl.duration*50,syl.text_stripped)
		l.layer = 3
		l.start_time = line.start_time +syl.start_time
		l.end_time =  line.start_time +syl.start_time + syl.duration
		subs.append(l)
 
                    function Curve(intpol, x_ini, y_ini,  x_int1, y_int1, x_int2, y_int2, x_fin, y_fin)
                    curvx1 = interpolate(intpol, x_ini, x_int1)
                    curvx2 = interpolate(intpol, curvx1, x_int2)
                    curvx3 = interpolate(intpol, curvx2, x_fin)
                    curvy1 = interpolate(intpol, y_ini, y_int1)
                    curvy2 = interpolate(intpol, curvy1, y_int2)
                    curvy3 = interpolate(intpol, curvy2, y_fin)
                    cur_x, cur_y = curvx3, curvy3
                    	return cur_x, cur_y
                    end

                    local circlx = "{\\fscx250\\fscy250\\1c&Hffffff&}m 0 0 l 1 0 l 1 1 l 0 1 "
                    local x = syl.center + line.left
                    local y = line.middle  

                    local value = 450
                    for j = 1, value do
       
                    local pos_x = {}
                    pos_x[1] = x    
                    pos_x[2] = x 
                    pos_x[3] = x   
                    pos_x[4] = x  +math.cos(math.rad(j*25))*40

                    local pos_y = {}
                    pos_y[1] = y   
                    pos_y[2] = y  
                    pos_y[3] = y   
                    pos_y[4] = y    +math.sin(math.rad(j*25))*40

                    tim = 1*(syl.duration/800)
                    tiem_1 = line.start_time +syl.start_time
                    tiem_2 =line.start_time+syl.start_time+ j*2
                    timex  = interpolate(j/value,tiem_1,tiem_2)

                    Curve(j/value,pos_x[1], pos_y[1] ,pos_x[2], pos_y[2] ,pos_x[3], pos_y[3] ,pos_x[4], pos_y[4])
                    cr = "&HBA9E4E&"
                    l.text = string.format("{\\an5\\move(%3.f,%3.f,%3.f,%3.f)\\3c%s\\1c%s\\bord1\\blur2\\3a&H30&\\p1}%s",cur_x,cur_y,cur_x,cur_y,cr,cr,circlx)
                    l.start_time = timex 
                    l.end_time =  l.start_time+  syl.duration
                    l.layer = 2
                    subs.append(l)
            
                    end

                   end
                   end
end



function macro_load(subs)
 
	aegisub.progress.set(0)
	aegisub.progress.title(script_name)
	local meta, styles = karaskel.collect_head(subs) 
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do	
 
		aegisub.progress.set((ai-1) / maxai*100)
                                           if aegisub.progress.is_cancelled()  then  
                                                               error("User cancelled")
                                           end
		local linex = subs[i]
		if not linex.comment  and linex.class == "dialogue"   then
			karaskel.preproc_line(subs, meta, styles, linex)
			doFX(subs, meta, linex, styles,config)
			linex.comment = true
			subs[i] = linex
			else
			i = i + 1 
		end
                                           if #subs <= 5 then  ai = ai+ 10
		elseif #subs > 5 then  ai = ai + 5
                                           end
	end
                    aegisub.progress.task("Finished!")
                aegisub.progress.set(100)
        aegisub.set_undo_point(script_name)
end

 

aegisub.register_macro(script_name,script_description, macro_load)