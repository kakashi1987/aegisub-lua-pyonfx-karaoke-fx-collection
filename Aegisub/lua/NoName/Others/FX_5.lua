include("karaskel.lua")


function FX_5(subs)
	local meta, styles = karaskel.collect_head(subs)
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do

aegisub.progress.task(string.format("Applying effect (%d,%d)...", ai, maxai))
aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue"  then  karaskel.preproc_line(subs, meta, styles, l)
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
local y=line.margin_v + 26  
local www_msoms = 500                                                                                                      
if i == 1 then universo =0
end  
                                  
                                     
                                   randfrz = math.random(-20,20) 
                                   l = table.copy(line)
		l.text = string.format("{\\fscy80\\fscx80\\fad(150,0)\\an5\\move(%d,%d,%d,%d)\\1c&HFFFFFF&\\bord0\\be1\\t(\\fscy90\\fscx90\\1c&H748D80&\\bord0\\alpha&H11&)\\t(\\alpha&H33&\\1c&H748D80&\\3c&H486766&\\fscy100\\fscx100\\frz%d\\bord1\\blur0\\be0\\fry0)}%s",x,y,x,y,randfrz,syl.text_stripped)
		l.start_time = line.start_time-500+universo
                                   l.end_time = l.start_time
		l.layer=3
		subs.append(l)	
                                   l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c&H748D80&\\bord1.5\\frz%d\\blur2\\3c&H486766&\\3a&H33&\\be1}%s",x,y,randfrz,syl.text_stripped)
		l.start_time = line.start_time
		l.end_time = l.start_time+syl.start_time
		l.layer=2
		subs.append(l)
 		                                          
		randfrz= math.random(-40,30)*syl.duration/100
		randfry= math.random(-20,30)*syl.duration/100
		randfrx= math.random(-20,20)*syl.duration/100
		l = table.copy(line)	
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration+universo+www_msoms+math.random(0,syl.duration)
		l.text = string.format("{\\an5\\be1\\move(%d,%d,%d,%d)\\fad(0,150)\\bord1\\1c&H748D80&\\t(\\be0\\1c&H627667&\\bord1)\\t(\\be0\\be0\\bord0\\be2)\\t(\\1c&HFFFFFF&\\frz%d\\frx%d\\fry%d\\bord0\\fscy130\\fscx200\\be7)\\t(\\bord0\\be30)}%s",x,y,x-10,y-20,randfrz,randfrx,randfry,syl.text_stripped)
		l.layer=2
		subs.append(l)
		l = table.copy(line)	
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration+universo+www_msoms
		l.text = string.format("{\\an5\\be1\\move(%d,%d,%d,%d)\\fad(0,150)\\bord0\\alpha&HFF&\\3c&HFFFFFF&\\fs1\\bord3\\blur8\\3a&H55&\\t(\\3c&HFFFFFF&\\fs1\\bord16\\blur21\\3a&H30&\\frz%d\\frx%d\\fry%d0)}%s",x,y,x-10,y-20,randfrz,randfrx,randfry,syl.text_stripped)
		l.layer=2
		subs.append(l)                                                                                                                                            	
     end
end

                                                                                                                                         
aegisub.register_filter("FX_5", "~ALKOON~", 2000, FX_5)                                              