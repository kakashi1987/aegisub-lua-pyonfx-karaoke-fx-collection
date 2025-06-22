-- Aegisub Automation 3 
-- Original written by Semo


name = "Semo-first lua"

description = "Fantay karaoke^^"

version = 3

kind = "basic.ass"

include("karaskel-adv.lua") 


function do_syllable(meta, styles, config, line, syl) 

local result = {n=0}


function result.add()
             local l= copy_line(line)
             table.insert(result, l)

return l 

end

local x=syl.center + line.centerleft  
local y = 45

if time ~= line.start_time then
time=line.start_time
br=-1
end
br=br+1


l = table.copy(line)
for i=0,20 do
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\1c&HB4B4B4&\\3c&HB4B4B4&\\fs5\\blur5\\alpha&HFF&\\t(\\1c&HB4B4B4&\\3c&H4E4E4E&\\blur1\\fs40\\alpha&H55&)}%s",x+math.random(-12,12)+40,y+math.random(-12,12),x,y,syl.text_stripped)
l.start_time = line.start_time -28 +br*1
l.end_time = line.start_time + br*10 -15
l.layer = 2
subs.append(l)
end


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\t(\\fs5\\alpha&HFF&\\frx360)}%s",x,y,x-50,y,syl.text_stripped)
l.start_time = line.end_time -28 +br*1
l.end_time = line.end_time + br*10 -15
l.layer = 3
subs.append(l)


l = table.copy(line)
l.text = string.format ("{\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
l.start_time = line.start_time + br*10 -15
l.end_time = line.start_time + syl.start_time
l.layer = 4
subs.append(l)


l = table.copy(line)
l.text = string.format ("{\\an5\\pos(%d,%d)\\blur2.5\\1c&HFFFFFF&\\3c&HFFFFFF&\\fs50\\t(\\fs40\\3c&H578494&\\1c&HA2A29B&)}%s",x,y,syl.text_stripped) 
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.end_time
l.layer = 5
subs.append(l)


l = table.copy(line)
l.text = string.format ("{\\an5\\pos(%d,%d)\\blur2.5\\1c&HFFFFFF&\\3c&HFFFFFF&\\fs50\\t(\\fs40\\3c&H578494&\\1c&HA2A29B&)}%s",x,y,syl.text_stripped) 
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.end_time
l.layer = 6
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCA&}%s",x,y-1,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 7
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCB&}%s",x,y-2,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 8
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCC&}%s",x,y-3,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 9
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCD&}%s",x,y-4,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 10
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCE&}%s",x,y-5,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 11
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCF&}%s",x,y-6,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 12
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD5&}%s",x,y-7,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 13
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD6&}%s",x,y-8,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 14
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD7&}%s",x,y-9,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 15
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD8&}%s",x,y-10,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 16
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD9&}%s",x,y-11,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 17
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDA&}%s",x,y-12,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 18
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDB&}%s",x,y-13,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 19
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDC&}%s",x,y-14,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 20
subs.append(l)


l = table.copy(line)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 21
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDD&}%s",x,y-15,x,y,syl.text_stripped)
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDE&}%s",x,y-16,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 22
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDF&}%s",x,y-17,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 23
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEA&}%s",x,y-18,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 24
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEB&}%s",x,y-19,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 25
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEC&}%s",x,y-20,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 26
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HED&}%s",x,y-21,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 27
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEE&}%s",x,y-22,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 28
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEF&}%s",x,y-23,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 29
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x,y-24,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 30
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCA&}%s",x,y+1,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 41
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCB&}%s",x,y+2,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 42
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCC&}%s",x,y+3,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 43
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCD&}%s",x,y+4,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 44
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCE&}%s",x,y+5,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 45
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCF&}%s",x,y+6,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 46
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD5&}%s",x,y+7,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 47
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD6&}%s",x,y+8,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 48
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD7&}%s",x,y+9,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 49
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD8&}%s",x,y+10,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 50
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD9&}%s",x,y+11,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 51
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDA&}%s",x,y+12,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 52
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDB&}%s",x,y+13,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 53
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDC&}%s",x,y+14,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 54
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDD&}%s",x,y+15,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 55
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDE&}%s",x,y+16,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 56
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDF&}%s",x,y+17,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 57
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEA&}%s",x,y+18,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 58
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEB&}%s",x,y+19,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 59
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEC&}%s",x,y+20,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 60
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HED&}%s",x,y+21,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 61
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEE&}%s",x,y+22,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 62
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEF&}%s",x,y+23,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 63
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x,y+24,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 64
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCA&}%s",x-1,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 65
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCB&}%s",x-2,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 66
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCC&}%s",x-3,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 67
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCD&}%s",x-4,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 68
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCE&}%s",x-5,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 69
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCF&}%s",x-6,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 70
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD5&}%s",x-7,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 71
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD6&}%s",x-8,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 72
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD7&}%s",x-9,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 73
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD8&}%s",x-10,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 74
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD9&}%s",x-11,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 75
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDA&}%s",x-12,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 76
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDB&}%s",x-13,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration
l.layer = 77
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDC&}%s",x-14,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 78
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDD&}%s",x-15,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 79
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDE&}%s",x-16,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 80
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDF&}%s",x-17,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 81
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEA&}%s",x-18,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 82
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEB&}%s",x-19,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 83
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEC&}%s",x-20,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 84
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HED&}%s",x-21,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 85
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEE&}%s",x-22,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 86
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEF&}%s",x-23,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 87
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x-24,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 88
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCA&}%s",x+1,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 89
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCB&}%s",x+2,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 90
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCC&}%s",x+3,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 91
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCD&}%s",x+4,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 92
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCE&}%s",x+5,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 93
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCF&}%s",x+6,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 94
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD5&}%s",x+7,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 95
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD6&}%s",x+8,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 96
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD7&}%s",x+9,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 97
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD8&}%s",x+10,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 98
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD9&}%s",x+11,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 99
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDA&}%s",x+12,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 100
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDB&}%s",x+13,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 101
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDC&}%s",x+14,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 102
subs.append(l)

l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDD&}%s",x+15,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 103
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDE&}%s",x+16,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 104
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDF&}%s",x+17,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 105
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEA&}%s",x+18,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 106
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEB&}%s",x+19,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 107
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEC&}%s",x+20,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 108
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HED&}%s",x+21,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 109
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEE&}%s",x+22,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 110
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEF&}%s",x+23,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 111
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x+24,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 112
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCA&}%s",x-1,y-1,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 113
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCB&}%s",x-2,y-2,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 114
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCC&}%s",x-3,y-3,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 115
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCD&}%s",x-4,y-4,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 116
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCE&}%s",x-5,y-5,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 117
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCF&}%s",x-6,y-6,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 118
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD5&}%s",x-7,y-7,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 119
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD6&}%s",x-8,y-8,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 120
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD7&}%s",x-9,y-9,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 121
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD8&}%s",x-10,y-10,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 122
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD9&}%s",x-11,y-11,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 123
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDA&}%s",x-12,y-12,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 124
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDB&}%s",x-13,y-13,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 125
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDC&}%s",x-14,y-14,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 126
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDD&}%s",x-15,y-15,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 127
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDE&}%s",x-16,y-16,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 128
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDF&}%s",x-17,y-17,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 129
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEA&}%s",x-18,y-18,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 130
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEB&}%s",x-19,y-19,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 131
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEC&}%s",x-20,y-20,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 132
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HED&}%s",x-21,y-21,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 133
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEE&}%s",x-22,y-22,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 134
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEF&}%s",x-23,y-23,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 135
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x-24,y-24,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 136
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCA&}%s",x+1,y+1,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 137
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCB&}%s",x+2,y+2,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 138
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCC&}%s",x+3,y+3,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 139
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCD&}%s",x+4,y+4,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 140
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCE&}%s",x+5,y+5,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 141
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCF&}%s",x+6,y+6,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 142
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD5&}%s",x+7,y+7,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 143
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD6&}%s",x+8,y+8,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 144
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD7&}%s",x+9,y+9,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 145
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD8&}%s",x+10,y+10,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 146
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD9&}%s",x+11,y+11,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 147
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDA&}%s",x+12,y+12,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 148
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDB&}%s",x+13,y+13,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 149
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDC&}%s",x+14,y+14,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 150
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDD&}%s",x+15,y+15,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 151
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDE&}%s",x+16,y+16,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 152
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDF&}%s",x+17,y+17,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 153
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEA&}%s",x+18,y+18,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 154
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEB&}%s",x+19,y+19,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 155
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEC&}%s",x+20,y+20,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 156
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HED&}%s",x+21,y+21,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 157
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEE&}%s",x+22,y+22,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 158
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEF&}%s",x+23,y+23,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 159
subs.append(l)

l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x+24,y+24,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 160
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCA&}%s",x-1,y+1,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 161
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCB&}%s",x-2,y+2,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 162
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCC&}%s",x-3,y+3,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 163
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCD&}%s",x-4,y+4,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 164
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCE&}%s",x-5,y+5,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 165
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCF&}%s",x-6,y+6,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 166
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD5&}%s",x-7,y+7,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 167
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD6&}%s",x-8,y+8,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 168
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD7&}%s",x-9,y+9,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 169
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD8&}%s",x-10,y+10,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 170
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD9&}%s",x-11,y+11,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 171
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDA&}%s",x-12,y+12,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 172
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDB&}%s",x-13,y+13,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 173
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDC&}%s",x-14,y+14,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 174
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDD&}%s",x-15,y+15,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 175
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDE&}%s",x-16,y+16,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 176
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDF&}%s",x-17,y+17,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 177
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEA&}%s",x-18,y+18,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 178
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEB&}%s",x-19,y+19,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 179
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEC&}%s",x-20,y+20,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 180
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HED&}%s",x-21,y+21,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 181
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEE&}%s",x-22,y+22,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 182
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEF&}%s",x-23,y+23,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 183
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x-24,y+24,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 184
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCA&}%s",x+1,y-1,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 185
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCB&}%s",x+2,y-2,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 186
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCC&}%s",x+3,y-3,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 187
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCD&}%s",x+4,y-4,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 188
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCE&}%s",x+5,y-5,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 189
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HCF&}%s",x+6,y-6,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 190
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD5&}%s",x+7,y-7,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 191
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD6&}%s",x+8,y-8,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 192
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD7&}%s",x+9,y-9,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 193
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD8&}%s",x+10,y-10,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 194
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HD9&}%s",x+11,y-11,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 195
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDA&}%s",x+12,y-12,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 196
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDB&}%s",x+13,y-13,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 197
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDC&}%s",x+14,y-14,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 198
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDD&}%s",x+15,y-15,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 199
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDE&}%s",x+16,y-16,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 200
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HDF&}%s",x+17,y-17,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 201
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEA&}%s",x+18,y-18,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 202
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEB&}%s",x+19,y-19,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 203
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HEC&}%s",x+20,y-20,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 204
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HED&}%s",x+21,y-21,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 205
subs.append(l)


l = table.copy(line)
l.text = string.format ("{\\an5\\pos(%d,%d)\\blur2.5}%s",x,y,syl.text_stripped) 
l.start_time =  line.start_time + syl.end_time
l.end_time = line.end_time -28 +br*1
l.layer = 206
subs.append(l)


l = table.copy(line)
for i=0,85 do
l.text = string.format("{\\an5\\shad0\\alpha&80&\\move(%d,%d,%d,%d)\\3c&H5152FF&\\1c&H1B1C7F&\\blur8\\fscx15\\fscy15\\3c&H0000B1&\\1c&H000068&\\t(\\alpha&HF8&)}{\\p1}m 9 -5 b 15 2 15 13 9 19 b 9 19 9 19 9 19 b 3 13 3 2 9 -5 {\\p0}", x+math.random(-3.5,3.5), y, x+math.random(-8,8), y+55,  syl.text)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration + i*2
l.layer = 206
subs.append(l)
end