
      include("karaskel.lua")

      script_name = "FX_3"
      script_description = " FX_LUA.4"
      script_author = "alkoon"  
------------\\XXXXX//------------------------------------//XX(2)XX\\----------------------------------\\XXXXX//--------------

function FX_3(subs) 
	local meta, styles = karaskel.collect_head(subs)	
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do

------------\\XXXXX//------------------------------------//XX(3)XX\\----------------------------------\\XXXXX//--------------
aegisub.progress.task(string.format("Applying effect (%d,%d)...", ai, maxai))		
aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" then karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
                        else  i = i + 1  end  ai = ai + 1 
             end
end

------------\\XXXXX//------------------------------------//XX(3)XX\\----------------------------------\\XXXXX//--------------

function do_fx(subs, meta, line)
       for i = 1, line.kara.n do
               local syl = line.kara[i]
                     local x=syl.center + line.left
                         local y=line.margin_v + 20
                             if i == 1 then iii = 0 end
                             iii=iii+(150/line.kara.n)
                         local l = table.copy(line)
                     l.start_time = line.start_time + syl.start_time+50
              l.end_time=l.end_time+150+iii
       l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,100)\\bord1\\blur2\\shad0\\1c&H4DA152&\\3c&HE5FEEC&}%s",x+10,y,x,y,syl.text)
subs.append(l)

------------\\XXXXX//------------------------------------//XX(4)XX\\----------------------------------\\XXXXX//--------------

                                local l = table.copy(line)
                                for g= 0,01 do
                                l.layer=3
                                l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(200,200)\\be1\\1a&H55&\\bord1\\blur1\\shad0\\1c&H4DA152&\\3c&HE5FEEC&}%s",x+20, y,x,y, syl.text)
                                l.start_time=line.start_time+syl.start_time
                                l.end_time=l.start_time+syl.duration + g*200
                                subs.append(l)
                                end
                                local l = table.copy(line)
                                for g = 0,01 do
                                l.layer=3
                                l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(200,200)\\be1\\1a&H55&\\bord1\\blur1\\shad0\\1c&H4DA152&\\3c&HE5FEEC&}%s",x, y,x+20,y, syl.text)
                                l.start_time=line.start_time+syl.start_time
                                l.end_time=l.start_time+syl.duration + g*200
                                subs.append(l)
                                end
                                local l = table.copy(line)
                                for g = 0,01 do
                                l.layer=3
                                l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(200,200)\\be1\\1a&H70&\\bord1\\blur1\\shad0\\1c&H4DA152&\\3c&HE5FEEC&}%s",x+16, y,x,y, syl.text)
                                l.start_time=line.start_time+syl.start_time
                                l.end_time=l.start_time+syl.duration + g*200
                                subs.append(l)
                                end
                                local l = table.copy(line)
                                for g = 0,0 do
                                l.layer=3
                                l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(200,200)\\be1\\1a&H70&\\bord1\\blur1\\shad0\\1c&H4DA152&\\3c&HE5FEEC&}%s",x, y,x+16,y, syl.text)
                                l.start_time=line.start_time+syl.start_time
                                l.end_time=l.start_time+syl.duration + g*200
                                subs.append(l)
                     end
             end
     end

aegisub.register_filter("FX_3", "~ALKOON~", 2000, FX_3)