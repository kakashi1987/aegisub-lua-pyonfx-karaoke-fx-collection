
-- Aegisub Automation script
-- Original written by Ivan Tanev aka Crafty_Shadow
name = "Ayakashi OP"
description = "Ayakashi exploding shaking OP"
configuration = {}
version, kind = 3, 'basic_ass'

-->--includes and global variables
include("karaskel-adv.lua")
br=0
time=1
--<--end include


function do_syllable(meta, styles, config, line, syl)

-->>FUNCTION FOR RESULT PARSING>>--
local result = {n=0}
function result.add() local l = copy_line(line); table.insert(result, l); return l end
--<<FUNCTION FOR RESULT PARSING<<--

-->--check for empty line
  if syl.text == "" then
   return { n=0 }
  end
  if syl.text == " " then
   return { n=0 }
  end
--<--end check

-->-- x and y coordination definition
  local x=syl.center + line.centerleft
  local y=line.styleref.margin_v + 60
--<-- end def

-->--check if a new line has started, and zero the brer if it has; increase the brer
if time ~= line.start_time then
  time=line.start_time
  br=-1
end
br=br+1
--<--end of check



l=result.add()
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\alpha&HFF&\\t(\\1a&H00&\\3a&C8&\\4a&64&\\fscy100)}%s",x,y-15,x,y,syl.text_stripped)
l.start_time = line.start_time - 20
l.end_time = line.start_time

l=result.add()
l.text = string.format("{\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
l.end_time = line.start_time + syl.start_time/10

l=result.add()
l.text = string.format("{\\an5\\pos(%d,%d)\\t(\\alpha&HCF&)}%s",x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time/10
l.end_time = l.start_time + syl.duration

if  (syl.text_stripped == ".") then elseif (syl.text_stripped == ",") then elseif (syl.text_stripped == "\"") then else
 for i=0,6 do
  l=result.add()
  l.layer=50
  l.text = string.format("{\\an5\\pos(%d,%d)\\3a&HFF&\\4a&HFF&\\1c&HFFFFFF&\\fscx100\\fscy100\\t(0.15,\\fscx%d\\fscy%d\\1a&HBF&)}%s",x,y,160+math.random(-50,50),160+math.random(-50,50),syl.text_stripped)
  l.start_time = line.start_time + syl.start_time/10
  l.end_time = l.start_time + syl.duration + 5 + math.random(15)
  if (l.end_time > line.end_time) then l.end_time = line.end_time end
  -->if (l.end_time==l.start_time) then return { n=0 } end<--
 end
end

z=(line.end_time - line.start_time - syl.start_time/10)/10
for i=0,(z-2) do
  bla=line.start_time + syl.start_time/10 + syl.duration + i*10
  ble=bla+10
 for b=0,1 do
   l = result.add()
   l.layer=20
   l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\alpha&HCF&\\1c&H292929\\3c&HE6E6E8&}%s", x+math.random(-1,1), y+math.random(-1,1), x+math.random(-1,1), y+math.random(-1,1), syl.text_stripped)
   l.start_time = bla

  if (ble>(line.end_time)) then
   l.end_time = line.end_time
  else
   l.end_time = ble
  end
 end
end

l=result.add()
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\alpha&HCF&\\t(\\frx-90)}%s",x+math.random(-1,1),y+math.random(-1,1),x+math.random(-1,1),y+7+math.random(-1,1),syl.text_stripped)
l.start_time = line.end_time
l.end_time = line.end_time + 6


  return result
end