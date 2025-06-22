--Author : Abdullah Al-Farsi(G_NAZ)
--Released int the public domain


name = "dARK sOUL" 
description = "STUDENT" 
version, kind, configuration = 3, 'basic_ass', {} 


include("karaskel-adv.lua") 

function do_syllable(meta, styles, config, line, syl) 


	local result = {n=0} 


            function result.add() local l = copy_line(line); table.insert(result, l); return l end


	local x = line.centerleft + syl.center                   
	local y = 45                                                           
	local start_t = syl.start_time                                    
	local mid_t =  syl.start_time + syl.duration*5   
	local end_t = syl.end_time 
	       

        local l = result.add()
	l.layer = 0 

                                             
                  l.end_time = line.start_time + syl.start_time/10
	l.text = string.format("{\\an2\\pos(%d,%d)\\fad(500,500)}%s",x,y,syl.text_stripped)

	local l = result.add()                         
	l.layer = 1                                  
	l.start_time = line.start_time + syl.start_time/10 
	l.end_time = line.start_time + syl.start_time/6 
                                                                    
	l.text = string.format("{\\an2\\move(%d,%d,%d,%d)}{\\fad(550,200)}{\\t1c&H8F4CCF&}{\\fscy20}{\\fscx20}{\\t(\\frx360)}{\\p1}m 10 0 l 9 0 4 36 3 40 3 50 1 55 1 140 4 144 0 150 20 150 16 144 19 140 19 55 17 50 17 40 16 36 11 0{\\p0}",x,y,x-60,y+360,syl.text)
                                                                                                                                                          
                                                                                                                                                         
	local l = result.add()
	l.layer = 2

	l.start_time = line.start_time + syl.start_time/10
	l.text = string.format("{\\an2\\pos(%d,%d)}%s",x,y,syl.text_stripped)

                 

        return result

end 


