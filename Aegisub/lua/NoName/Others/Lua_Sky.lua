
--Author : TheStorm
--Released int the public domain

name = "Sky" 

description = "Sky With FRY Effect_from TheStorm" 

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

        l.start_time = line.start_time + syl.start_time/10

        l.text = string.format("{\\an5\\pos(%d,%d)\\fad(200,200)}%s",x,y,syl.text_stripped)           


        local l = result.add()

        l.layer = 1

        l.start_time = line.start_time + syl.start_time/10

        l.end_time = line.start_time + syl.start_time/9

        l.text = string.format("{\\an5\\t(\\fry180)\\move(%d,%d,%d,%d)}%s",x,y,x,y+30,syl.text_stripped)



        local l = result.add()

        l.layer = 2

        l.start_time = line.start_time + syl.start_time/9

        l.end_time = line.start_time + syl.start_time/8

        l.text = string.format("{\\an5\\t(\\fry180)\\move(%d,%d,%d,%d)\\t(\\alpha&100&)}%s",x,y+30,x,y,syl.text_stripped) 


        local l = result.add()

        l.layer = 3

        l.start_time = line.start_time + syl.start_time/11

        l.end_time = line.start_time + syl.start_time/9

        l.text = string.format("{\\alpha&30&\\bord1\\\c&HE9E801&\\3c&HFFFFFF&\\shad0\\fad(300,300)\\an5\\move(%d,%d,%d,%d)\\p1}m 0 0 b -4 -4 -9 -2 -12 0 b -20 -3 -24 1 -20 6 b -24 8 -21 11 -21 14 b -18 17 -14 17 -13 15 b -10 17 -5 19 -3 15 b 3 18 8 17 11 14 b 16 15 20 9 18 5 b 18 2 17 -1 12 -1 b 6 -4 3 -2 0 0 {\\p0}",x-200,y-15,x+400,y-15,syl.text_stripped) 




	return result

end

