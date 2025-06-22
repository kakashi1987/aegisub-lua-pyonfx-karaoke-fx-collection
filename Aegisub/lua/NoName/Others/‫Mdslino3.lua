

if line.actor == 'NO.' then
l = table.copy(line)
l.text = "{"..fad(800,0)..an(5)..move(x+rand(300),100+rand(30),x,100)..fscx(50)..fscy(50)..bord(0)..color(1,'ffffff')..t(fscx(100)..fscy(100)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil() --Aqui são os efeitos
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,100)..estilo(1,line.styleref.color2)..AutoTimer(TE2,500,'frz',30,0.7,6).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)

else


if line.actor == 'rom1' then
posicion_anterior=0
longsil=string.len(sil())
modt=0
modtend=0
for char in unicode.chars(sil()) do
tam_caracter=aegisub.text_extents(line.styleref,char)
x_individual=line.left + syl.left +tam_caracter/2+posicion_anterior

l = table.copy(line)
l.start_time=line.start_time-1000+modi_tiempo+modt
l.end_time=line.start_time+modi_tiempo+modtend-130
l.text = "{"..an(5)..alpha('FF')..move(x+5,y+10,x_individual,y,0,500)..org(x+30,y+20)..frxyz(150,50,200)..bord(0)..shad(1)..fscxy(100)..color(1,line.styleref.color2)..t(alpha('00')..frxyz(0,0,0)).."}"..char
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(1)..estilo(1,line.styleref.color1).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..blur(2)..bord(1)..estilo(2,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=2
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..blur(2)..bord(1)..estilo(3,line.styleref.color3).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=3
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(2)..be(3)..fscxy(60)..color(1,line.styleref.color1)..color(3,line.styleref.color1)..alpha('46')..fscxy(100)..t(fscxy(120)..alpha('90')).."}"..sil()
l.start_time=line.start_time+syl.start_time-200
l.end_time=line.start_time+syl.end_time
l.layer=4
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x-9,y+5)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer=5
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x+9,y-5)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer=6
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x+20,y-8)..t(fscxy(150)..frz(760)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer=7
subs.append(l)

l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x+20,y-8)..t(fscxy(150)..frz(-760)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer=8
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x+5,y,x+40,y-18)..t(fscxy(150)..frz(-1760)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer=9
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=10
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-5)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=11
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-10)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=11
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-15)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=12
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-20)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=13
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(10)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFF&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=14
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(20)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=15
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(30)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=16
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(40)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=17
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(50)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx30..fscy30..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=18
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(60)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=19
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(70)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx30..fscy30..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=20
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(80)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=21
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(90)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=22
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(100)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=23
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-30)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=24
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-35)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=25
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-40)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=26
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-45)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx30..fscy30..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=27
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-50)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=28
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-55)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=29
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-60)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=30
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-65)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=31
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-70)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=32
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-75)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=33
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-80)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=34
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-85)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=35
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-90)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=36
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-95)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=37
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-100)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=38
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(110)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=39
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(130)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=40
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(140)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx30..fscy30..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=41
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(150)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=42
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(160)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=43
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(170)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=44
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(180)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=45
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-130)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=46
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-150)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=47
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-170)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=48
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-190)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=49
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-200)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=50
subs.append(l)


l = table.copy(line)
for j = 1,4 do
l.text = "{"..an(5)..color(1,'2fffff1')..move(x,y,x+rand(18),y-rand(120))..frz(-760)..fscxy(5)..bord(2)..t(fscxy(10)..alpha('ff'))..blur(3).."}"..p(3,Formas(3,1))
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=51
subs.append(l)
end


l = table.copy(line)
for j = 1,8 do
l.text = "{"..an(5)..color(1,'2fffff1')..move(x,y,x+rand(110),y-rand(120))..frz(-760)..fscxy(5)..bord(2)..t(fscxy(10)..alpha('ff'))..blur(3).."}"..p(1,Formas(3,1))
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=52
subs.append(l)
end

else


if line.actor == 'rom2' then
posicion_anterior=0
longsil=string.len(sil())
modt=0
modtend=0
for char in unicode.chars(sil()) do
tam_caracter=aegisub.text_extents(line.styleref,char)
x_individual=line.left + syl.left +tam_caracter/2+posicion_anterior --Posicionamos nuestro carácter

l = table.copy(line) 	
l.start_time=line.start_time-1000+modi_tiempo+modt
l.end_time=line.start_time+modi_tiempo+modtend-130
l.text = "{"..an(5)..alpha('FF')..move(x+5,y+10,x_individual,y,0,500)..org(x+30,y+20)..frxyz(150,50,200)..bord(0)..shad(1)..fscxy(100)..color(1,line.styleref.color2)..t(alpha('00')..frxyz(0,0,0)).."}"..char
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(1)..estilo(1,line.styleref.color1).."}"..sil()
l.start_time=line.start_time
l.end_time=line.start_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..blur(2)..bord(1)..estilo(2,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time=line.start_time+syl.start_time
l.layer=2
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..blur(2)..bord(1)..estilo(3,line.styleref.color3).."}"..sil()
l.start_time=line.start_time
l.end_time=line.start_time+syl.start_time
l.layer=3
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(2)..be(3)..fscxy(60)..color(1,line.styleref.color1)..color(3,line.styleref.color1)..alpha('46')..fscxy(100)..t(fscxy(150)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time-100
l.end_time=line.start_time+syl.end_time
l.layer=4
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x-9,y+50)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer=5
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x+9,y-50)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer=6
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=7
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-5)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=8
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-10)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=9
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-15)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=10
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-20)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=11
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(10)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFF&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=12
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(20)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=13
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(30)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=14
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(40)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=15
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(50)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx30..fscy30..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=18
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(60)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=16
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(70)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx30..fscy30..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=17
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(80)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=18
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(90)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=19
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(100)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=20
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-30)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=21
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-35)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=22
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-40)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=23
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-45)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx30..fscy30..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=24
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-50)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=25
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-55)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=26
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-60)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=27
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-65)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=28
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-70)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=29
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-75)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=30
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-80)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=31
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-85)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=32
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-90)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=33
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-95)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=34
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-100)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(50)..fscy(50)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=35
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(110)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=36
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(130)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=37
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(140)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx30..fscy30..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=38
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(150)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=39
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(160)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=40
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(170)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=41
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(180)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=42
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-130)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=43
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-150)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=44
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-170)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=45
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-190)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(30)..fscy(30)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=46
subs.append(l)


l = table.copy(line)
l.text = "{"..fscx(40)..fscy(40)..an(5)..fr(-200)..alfa(1,'&H77&')..pos(x,y)..fad(10,10)..shad(0)..bord(0)..color(1,'&H1DB2FF&')..fscx(70)..fscy(70)..t(frz(syl.duration*3))..t(fscx(40)..fscy(40)..alpha('&HFA&')).."}"..p(1,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=47
subs.append(l)


l = table.copy(line)
for j = 1,4 do
l.text = "{"..an(5)..color(1,'2fffff1')..move(x,y,x+rand(18),y-rand(120))..frz(-760)..fscxy(5)..bord(2)..t(fscxy(10)..alpha('ff'))..blur(3).."}"..p(3,Formas(3,1))
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=48
subs.append(l)
end


l = table.copy(line)
for j = 1,8 do
l.text = "{"..an(5)..color(1,'2fffff1')..move(x,y,x+rand(110),y-rand(120))..frz(-760)..fscxy(5)..bord(2)..t(fscxy(10)..alpha('ff'))..blur(3).."}"..p(1,Formas(3,1))
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=49
subs.append(l)
end



end
end
end
end
end