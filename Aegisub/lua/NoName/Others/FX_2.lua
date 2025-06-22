      include("karaskel.lua")
      script_name = "FX_2"
      script_description = " FX_LUA.4"
      script_author = "alkoon"  


function FX_2(subs)
	local meta, styles = karaskel.collect_head(subs)	
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
   
aegisub.progress.task(string.format("applying effect (%d,%d)", ai, maxai))
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
local texti = syl.text_stripped
local x=syl.center + line.left
local y=line.margin_v + 20  	             
if i == 1 then alkoon = 0 
end 

                          
                                 local l = table.copy(line)
                                 l.start_time = line.start_time -600+alkoon
                                 l.end_time=line.start_time+alkoon
                                 l.text = string.format("{\\bord1.5\\fad(80,0)\\1c&HFFFFFF&\\bord1\\clip(5,22,631,62)\\3c&H796753&\\t(\\1c&HA68F76&)\\move(%d,%d,%d,%d)\\t(\\1c&HA68F76&)}%s",x+100,0,x,y,texti )			
                                 l.layer=1
                                 subs.append(l)
                                 local l = table.copy(line)
                                 l.start_time = line.start_time+alkoon
                                 l.end_time = line.start_time+syl.start_time
                                 l.text = string.format("{\\bord1.5\\fad(0,0)\\1c&HA68F76&\\bord1\\clip(5,22,631,62)\\3c&H796753&\\move(%d,%d,%d,%d)}%s",x,y,x,y,texti )				
                                 l.layer=1
                                 subs.append(l)



                     l = table.copy(line)
                     l.start_time=line.start_time+syl.start_time
                     l.end_time=l.start_time+syl.duration+400
                     l.text = string.format("{\\bord0.5\\fad(0,250)\\1c&HA68F76&\\3c&H796753&\\move(%d,%d,%d,%d)\\t(\\frz50\\frx70)\\t(\\1a&H55&\\bord0\\be2)}%s",x,y,x+20,y+20,texti )				
                     l.layer=4
                     subs.append(l)
                     l = table.copy(line)
                     l.start_time=line.start_time+syl.start_time
                     l.end_time=l.start_time+syl.duration+400
                     l.text = string.format("{\\bord0.5\\fad(0,250)\\1c&HA68F76&\\3c&H796753&\\move(%d,%d,%d,%d)\\t(\\frz-50\\frx-70)\\t(\\1a&H55&\\bord0\\be2)}%s",x,y,x+20,y-20,texti )				
                     l.layer=4
                     subs.append(l)
 

       local l = table.copy(line) 
       l.start_time = line.start_time+syl.start_time
       l.end_time = line.end_time-50+alkoon
       l.text = string.format("{\\fad(0,200)\\1c&HEEE5DB&\\bord1.5\\3c&H796753&\\t(\\1a&HFF&)\\t(\\3c&HFFFFFF&)\\move(%d,%d,%d,%d)\\t(\\1a&HE7DBCD&\\3c&H796753&)}%s",x,y,x,y,texti )				
       l.layer=2
       subs.append(l)
    end
 end
aegisub.register_filter("FX_2", "~ALKOON~", 2009,  FX_2)
