      include("karaskel.lua")
      script_name = "FX_1"
      script_description = " FX_LUA.4"
      script_author = "alkoon"  

function FX_1(subs)
	local meta, styles = karaskel.collect_head(subs)	
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do

	aegisub.progress.task(string.format("Applying effect (%d,%d)", ai, maxai))		
	aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" then karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1 
			subs.delete(i)
		else
		i = i + 1
		end
		ai = ai + 1
	end
end
        

function do_fx(subs, meta, line)    
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 20

                                                                                        
                                 local l = table.copy(line)
                                 l.start_time = line.start_time -300
                                 l.end_time=line.start_time+syl.start_time
                                 l.text = string.format("{\\bord1.5\\fad(150,0)\\1c&HA68F76&\\3c&H796753&\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)			
                                 l.layer=1
                                 subs.append(l)
                                 local l = table.copy(line)
                                 l.start_time=line.start_time+syl.start_time
                                 l.end_time = l.end_time+50
                                 l.text = string.format("{\\fad(0,200)\\bord1.5\\blur1\\1c&HE1CDB3&\\3c&H9D7745&\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
                                 l.layer=1
                                 subs.append(l)

                                       
                                            l = table.copy(line)
		         l.text = string.format("{\\bord1.5\\fad(150,0)\\an5\\1c&HB8A28A&\\be1.5\\bord0\\fscx90\\fscy90\\move(%d,%d,%d,%d)}%s",x,y,x,y,syl.text_stripped)
		         l.start_time = line.start_time -300
		         l.end_time=line.start_time+syl.start_time+100
		         l.layer=1
                                            subs.append(l)
                                            l = table.copy(line)
		         l.text = string.format("{\\bord1.5\\fad(150,0)\\an5\\1c&HC7B5A2&\\be1.5\\bord0\\fscx80\\fscy80\\move(%d,%d,%d,%d)}%s",x,y,x,y,syl.text_stripped)
		         l.start_time = line.start_time -300
		         l.end_time=line.start_time+syl.start_time+100
                                            l.layer=1
                                            subs.append(l)
                                            l = table.copy(line)
		         l.text = string.format("{\\bord1.5\\fad(150,0)\\an5\\1c&HD5C0A8&\\be1.5\\bord0\\fscx70\\fscy70\\move(%d,%d,%d,%d)}%s",x,y,x,y,syl.text_stripped)
		         l.start_time = line.start_time -300
		         l.end_time=line.start_time+syl.start_time+100
		         l.layer=1
                                            subs.append(l)
                                            l = table.copy(line)
		         l.text = string.format("{\\bord1.5\\fad(150,0)\\an5\\1c&HE3D1BB&\\be1.5\\bord0\\fscx60\\fscy60\\move(%d,%d,%d,%d)}%s",x,y,x,y,syl.text_stripped)
		         l.start_time = line.start_time -300
		         l.end_time=line.start_time+syl.start_time+100
		         l.layer=1
                                           subs.append(l)
         

           
                  l = table.copy(line)
	l.text = string.format("{\\bord1.5\\fad(50,200)\\an5\\1a&HFF&\\bord1\\3c&H796753&\\move(%d,%d,%d,%d)}%s",x,y,x-25,y+25,syl.text_stripped)
                  l.start_time=line.start_time+syl.start_time
                  l.end_time=l.start_time+syl.duration+500
	l.layer=1
                  subs.append(l)
                  l = table.copy(line)
                  l.text = string.format("{\\bord1.5\\fad(50,200)\\an5\\1c&HA68F76&\\bord0\\3c&H796753&\\move(%d,%d,%d,%d)}%s",x,y,x+15,y+15,syl.text_stripped)
                  l.start_time=line.start_time+syl.start_time
                  l.end_time=l.start_time+syl.duration+500
	l.layer=2
                  subs.append(l)
                  l = table.copy(line)
	l.text = string.format("{\\bord1.5\\fad(50,200)\\an5\\1c&HB8A28A&\\be1.5\\bord0\\fscx90\\fscy90\\move(%d,%d,%d,%d)}%s",x,y,x+5,y-25,syl.text_stripped)
                  l.start_time=line.start_time+syl.start_time
                  l.end_time=l.start_time+syl.duration+500
	l.layer=3
                  subs.append(l)
                  l = table.copy(line)
	l.text = string.format("{\\bord1.5\\fad(50,200)\\an5\\1c&HC7B5A2&\\be1.5\\bord0\\fscx80\\fscy80\\move(%d,%d,%d,%d)}%s",x,y,x-30,y,syl.text_stripped)
                  l.start_time=line.start_time+syl.start_time
                  l.end_time=l.start_time+syl.duration+500
	l.layer=4
                 subs.append(l)
                  l = table.copy(line)
	l.text = string.format("{\\bord1.5\\fad(50,200)\\an5\\1c&HD5C0A8&\\be1.5\\bord0\\fscx70\\fscy70\\move(%d,%d,%d,%d)}%s",x,y,x,y+25,syl.text_stripped)
                  l.start_time=line.start_time+syl.start_time
                  l.end_time=l.start_time+syl.duration+500
                  l.layer=5
                  subs.append(l)
 
                    
     end
end
aegisub.register_filter("FX_1", " ~ALKOON~", 2009, FX_1)