
include "karaskel-auto4.lua"

script_name = "FX_LUA.4"
script_description = "Function_Nickle"
script_author = "ALKOON"

function FX_LUA(subs)
	local meta, styles = karaskel.collect_head(subs)	
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
       aegisub.progress.task(string.format("Applying effect (%d,%d)...", ai, maxai))		
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
local y=line.margin_v + 30
if i == 1 then  universe = 0
end
		local l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(100,0)\\shad0\\1a&HFF&\\bord1\\be1.5\\be2.5\\3c&HFFFFFF&\\1c&H000000&}%s", x, y, syl.text_stripped)
		l.start_time=line.start_time-160+  universe
		l.end_time=line.start_time+syl.start_time
		subs.append(l)

--# FUNCTION NICKLE #--
--# Modificado function_alkoon #--

function genBucle(base,altura)
	area=(math.ceil(base)*math.ceil(altura))+syl.duration*4
		return area
                 end
	modi={-1,1}
	genBucle(syl.width,syl.height)
	if area>0 then
		 l = table.copy(line)
		 for z=0,area do
   		movx=math.random(-10,15)
   		movy=math.random(-10,10)
   	clipx=x+(math.random(syl.width))*modi[math.random(1,2)]
   	clipy=y+(math.random(syl.height))*modi[math.random(1,2)]
      l.start_time=line.start_time+syl.start_time
      l.end_time=l.start_time+math.random(syl.duration)+600+universe
      l.text = string.format("{\\be3\\blur3\\bord1\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\clip(%d,%d,%d,%d)\\t(\\fscx200\\fscy170)}%s",x,y,x+movx,y+movy,line.styleref.color2,clipx,clipy,clipx+1,clipy+1,syl.text_stripped)
     subs.append(l)
  end
end
	modi={-1,1}
	genBucle(syl.width,syl.height)
	if area>0 then
		 l = table.copy(line)
 		 for z=0,area  do 
   		 movx=math.random(-10,10)
   		 movy=math.random(-10,10)
   	clipx=x+(math.random(syl.width/2))*modi[math.random(1,2)]
   	clipy=y+(math.random(syl.height/2))*modi[math.random(1,2)]
        l.start_time=line.start_time+syl.start_time
        l.end_time=l.start_time+math.random(syl.duration)+200+universe
        l.text = string.format("{\\be3\\blur3\\bord1\\an5\\move(%d,%d,%d,%d,%d,%d)\\fad(0,100)\\1c%s\\clip(%d,%d,%d,%d)}%s",x,y,x+movx,y+movy,l.start_time+syl.duration/4,l.end_time,line.styleref.color2,clipx,clipy,clipx+1,clipy+1,syl.text_stripped)
        subs.append(l)
        universe=universe+(500/line.kara.n)
       end
    end
  end
end

aegisub.register_macro("FX_LUA", "Function_Nickle", FX_LUA)
aegisub.register_filter("FX_LUA", "Function_Nickle", 2000, FX_LUA)