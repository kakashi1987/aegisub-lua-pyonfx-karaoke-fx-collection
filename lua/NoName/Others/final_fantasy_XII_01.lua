script_modified = "5/18/2009_Monday, May 18, 2009_by alkoon"
script_configuration = "script is organizer and altered by alkoon"
include("unicode.lua")\\include "alkoon.lua--[[.... these words not important, and you can write it's or not ]]--
include "karaskel.lua" --[[ These script is very simple ,
aim her the explaining about how can you doing script simple :D_alkoon
# -- These words quoted from_jfs (from other script ..)
jfs said...This script is given to the public domain and  You can use and modify the effect freely,
also without credit, although I would appreciate some.
also If you have any questions tell me " Iam alkoon " ]]--


--## IF YOU HAVE ANY QUESTIONS TELL ME ( IAM ALKOON ) ##--

     script_name = "lua.4" --[[ (string) - Name of the script, this should be short.  ]]
     script_description = "assays_lua4" --[[(string) - Description of the purpose of the script. Shouldn't be too long either ]]
     script_author = "modified by alkoon"  --[[ Author credits for the script ]]
     script_version = "1" [[ (string or number)- Version numer/name of the script. This is freeform, no specific meaning is assigned to this ]]

function lesson_lua(subs)
	aegisub.progress.task("Getting header data")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i ~= maxi do

aegisub.progress.task(string.format("Applying effect (%d,%d)", ai, maxai))		
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
>>>	aegisub.progress.task("Finished!")-- like writing jfs
	aegisub.progress.set("100")  ]]--
end

                 --## IF YOU HAVE ANY QUESTIONS TELL ME ( IAM ALKOON ) ##--

function do_fx(subs, meta, line)    
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25

--[[ you can write these (( -local l = table.copy(line)- )) or  these ((- l = table.copy(line) -)) what would you like :D ]]--    
--[[ these.. [ subs.append(l) ] ..meaning [ subtitles.applying end (line) ]]--
--[[ l.text = string.format("{...............}%s",x,y,syl.text_stripped) [ forming and writing codes effects ]]--                             
                                 --# these layer for the beginning_  text emersion_01                                                                                             
                                 local l = table.copy(line)
                                 l.start_time = line.start_time -300
                                 l.end_time=line.start_time+syl.start_time
                                 l.text = string.format("{\\bord1.5\\fad(150,0)\\1c&HA68F76&\\3c&H796753&\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)			
                                 l.layer=1
                                 subs.append(l)
                                 --# these layer for end effect
                                 local l = table.copy(line)
                                 l.start_time=line.start_time+syl.start_time
                                 l.end_time = l.end_time+50
                                 l.text = string.format("{\\fad(0,200)\\bord1.5\\blur1\\1c&HE1CDB3&\\3c&H9D7745&\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
                                 l.layer=1
                                 subs.append(l)

                                            --# these layers for the beginning_  text emersion_02  
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


                 --## IF YOU HAVE ANY QUESTIONS TELL ME ( IAM ALKOON ) ##--

                  --# these layers for song singer 
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
 
                 --## IF YOU HAVE ANY QUESTIONS TELL ME ( IAM ALKOON ) ##--                
     end
end
aegisub.register_filter("FX_LUA", " you can altering this script", 2009,  lesson_lua)-->> 
-->>Synopsis: aegisub.register_filter(name, description, priority, processing_function, configuration_panel_provider) 