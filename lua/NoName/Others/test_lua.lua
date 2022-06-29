--- √ÀÌ— Õ—ﬂ… «·ﬂ·„…-------
l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x-9,y+50)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer = 2
subs.append(l)

l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x+9,y-50)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer = 2
subs.append(l)
