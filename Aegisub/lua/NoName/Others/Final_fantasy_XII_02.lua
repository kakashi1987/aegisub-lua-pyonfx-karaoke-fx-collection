include("karaskel.lua")-------\\-----[[ If you have any questions tell me " Iam alkoon " ]]-----------//--
script_modified = "27/5/2009_Monday, May 27, 2009_by alkoon"-----------------------------------\\--
- \\include("alkoonskel.lua")--\\-------------------------------------------------------------------------------------//--               
---\\These script is very simpl,you can use and modify the effect freely,also without credit --\\--      
----\\-------------------------------------\\-----------######[ALKOON]######----------------------------------//--                              
-----\\-------------------------------------\\---------------------------------------------------------------------------------\\--            		
SCRIPT_NAME = "ASSAYS_LUA" ----------------------------------------------------------------------------//-- 
-------\\SCRIPT_AUTHOR = "ALKOON" ----------------------------------------------------------------------\\-- 
--------\\-SCRIPT_DISCRIPTION \\ ":D" -----------------------------------------------------------------------//-- 
---------\\-------------------------------------\\ ----------------------------------------------------------------------------\\--   			      
----------\\-------------------------------------\\------######[ALKOON]######---------------------------------//--                              

function essays_lua(subs)
                  aegisub.progress.task("Getting header data")
                  local meta, styles = karaskel.collect_head(subs)
                  aegisub.progress.task("APPLYING EFFECT")
                  local i, ai, maxi, maxai = 1, 1, #subs, #subs
                  while i ~= maxi do  
   
aegisub.progress.task(string.format("applying effect (%d,%d)", ai, maxai))
aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
			not l.comment then
			karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1 
			subs.delete(i)
		else
		i = i + 1
		end
		ai = ai + 1
	end
--[[  you can  write these >>> herein
>>>	aegisub.progress.task("Finished!")-- like writing " jfs"
	aegisub.progress.set("100")  ]]--
end

function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local texti = syl.text_stripped
local x=syl.center + line.left
local y=line.margin_v + 32  	             
if i == 1 then alkoon = 0 end 
--------\\------------------IF YOU HAVE ANY QUESTIONS TELL ME ( IAM ALKOON )------------------------------//--               
---------\\-------------------------------------\\--------------------------------------------------//-----------------------------------------//--                              		      
----------\\-------------------------------------\\------######[ALKOON]######-----//-----------------------------------------//--                              
-----------\\-------------------------------------\\----------------------------------------------//-----------------------------------------//--                              
--[[ you can write this (( -local l = table.copy(line)- )) or  this ((- l = table.copy(line) -)) what would you like :D ]]--    
--[[ these.. [ subs.append(l) ] ..meaning [ subtitles.applying end (line) ]]--
--[[ l.text = string.format("{..........}%s",x,y,syl.text_stripped) [ forming and writing codes effects ]]--                             
                                 local l = table.copy(line)
                                 l.start_time = line.start_time -600+alkoon
                                 l.end_time=line.start_time+alkoon
                                 l.text = string.format("{\\bord1.5\\fad(80,0)\\1c&HFFFFFF&\\bord1\\clip(5,22,631,62)\\3c&H796753&\\t(\\1c&HA68F76&)\\move(%d,%d,%d,%d)\\t(\\1c&HA68F76&)}%s",x+80,0,x,y,texti )			
                                 l.layer=1
                                 subs.append(l)
                                 local l = table.copy(line)
                                 l.start_time = line.start_time+alkoon
                                 l.end_time = line.start_time+syl.start_time
                                 l.text = string.format("{\\bord1.5\\fad(0,0)\\1c&HA68F76&\\bord1\\clip(5,22,631,62)\\3c&H796753&\\move(%d,%d,%d,%d)}%s",x,y,x,y,texti )				
                                 l.layer=1
                                 subs.append(l)

---------\\-------------------------------------\\--------------------------------------------------//-----------------------------------------//--                              		      
----------\\-------------------------------------\\------######[ALKOON]######-----//-----------------------------------------//--                              
-----------\\-------------------------------------\\----------------------------------------------//-----------------------------------------//--   

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

---------\\-------------------------------------\\--------------------------------------------------//-----------------------------------------//--                              		      
----------\\-------------------------------------\\------######[ALKOON]######-----//-----------------------------------------//--                              
-----------\\-------------------------------------\\----------------------------------------------//-----------------------------------------//--   

       local l = table.copy(line) 
       l.start_time = line.start_time+syl.start_time
       l.end_time = line.end_time-50+alkoon
       l.text = string.format("{\\fad(0,200)\\1c&HEEE5DB&\\bord1.5\\3c&H796753&\\t(\\1a&HFF&)\\t(\\3c&HFFFFFF&)\\move(%d,%d,%d,%d)\\t(\\1a&HE7DBCD&\\3c&H796753&)}%s",x,y,x,y,texti )				
       l.layer=2
       subs.append(l)

---------\\-------------------------------------\\--------------------------------------------------//-----------------------------------------//--                              		      
----------\\-------------------------------------\\------######[ALKOON]######-----//-----------------------------------------//--                              
alkoon=alkoon+(600/line.kara.n)-----\\----------------------------------------------//-----------------------------------------//--           
-------------\\------------------------------------\\--------------------------------------------//-----------------------------------------//--   
--------------\\------------------IF YOU HAVE ANY QUESTIONS TELL ME ( IAM ALKOON )-------------------//--               
---------------\\------------------------------------\\----------------------------------------//-----------------------------------------//--   
 end
 end
aegisub.register_filter("FX.LUA", "you can altering this script", 2009,  essays_lua)-->> 
-->>Synopsis: aegisub.register_filter(name, description, priority, processing_function, configuration_panel_provider) 