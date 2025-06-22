--Author : Abdullah Al-Farsi(G_NAZ)
--Released int the public domain
ØÈÚÇğ ÃäÇ ÔÑÍÊ åĞÇ ÇáÌÒÁ ßáå İí ÇáÏÑÓ ÇáÇæá... İí åĞÇ ÇáÏÑÓ ÈÚáãß ßíİ ÊÍÑß ÇáÍÑæİ... ÇäÒá áÊÍÊ..
name = "lesson 2" 
description = "www.jnazh-karaoke.ahlamontada.net" 
version, kind, configuration = 3, 'basic_ass', {} 

áÇÒã Êßæä İÇåã ÇáÏÑÓ ÇáÇæá... ÚÔÇä Êİåã åĞÇ

include("karaskel-adv.lua") 

function do_syllable(meta, styles, config, line, syl) 


	local result = {n=0} 


            function result.add() local l = copy_line(line); table.insert(result, l); return l end


	local x = line.centerleft + syl.center                   
	local y = 45                                                           
	local start_t = syl.start_time                                    
	local mid_t =  syl.start_time + syl.duration*5   
	local end_t = syl.end_time 		       
============================================================================
        local l = result.add()
	l.layer = 0 
İí ÇáØÈŞÉ ÑŞã (0) ÓäÌÚá ÇáÌãáÉ ÊÙåÑ İí ÊæŞíÊåÇ ÇáÃÓÇÓí... æáßä ÍÑæİåÇ ÊäÊåí İí äåÇíÉ äØŞ ÇáãÛäí ßãÇ äáÇÍÙ... æåĞÇ áÃÌá Ãä äÖÚ İÑÕÉ ááØÈŞÇÊ ÇáÃÎÑì ááÙåæÑ
>_>
        l.end_time = line.start_time + syl.start_time/10
	l.text = string.format("{\\an5\\pos(%d,%d)\\fs30\\1c&H66F96A&\\3c&H0AA10E&\\shad0\\bord1}%s",x,y,syl.text_stripped)


============================================================================


	local l = result.add()
	l.layer = 1
                                                                            ÓäÌÚá ÇáÍÑæİ ÊÊÍÑß İí ÇáØÈŞÉ ÑŞã (1)... ÇáÑÌÇÁ ÇáãÒíÏ ãä ÇáÊÑßíÒ
	l.start_time = line.start_time + syl.start_time/10  æŞÊ ÈÏÇíÉ ÊÍÑß ÇáÍÑİ æåæ ÚäÏ ÑŞã ÚÔÑÉ... ãÚäÇå æŞÊ äØŞ ÇáãÛäí ááÍÑİ
	l.end_time = line.start_time + syl.start_time/8 + syl.duration  ÇãÇ İí äåÇíÉ äØŞ ÇáãÛäí ÓäÖÚ áå ÑŞã 8 áÃääí ÃÑíÏå Ãä íÊÃÎÑ İí ÃÎÊİÇÁ ÇáÍÑİ... ÍÊì íÈÏÃ ÇáãÛäí İí ÇáÍÑÈ ÇáÊÇáí ÈíäãÇ ÇáÍÑİ ÇáÓÇÈŞ ãÇÒÇá íÊÍÑß

--syl.duration=Øæá ÇáãŞØÚ ÇáÕæÊí
                                                                       äÖÚ ÇáßæÏ "ãæİ" ßãÇ ÊÑì... æäÖÚ ŞæÓíä İíåãÇ ÃÑÈÚ ÏæÇá... äÊÌå ÇáÂä İí ÇáÎáİ
	l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)}%s",x,y,x-60,y+20,syl.text_stripped)
                                                                                                      İí äåÇíÉ... íÌÈ Ãä ÊÖÚ ÃÑÈÚ ãÍÇæÑ ßãÇ ÊáÇÍÙ... äŞæã ÈÒíÇÏÉ ãÍæÑ ÇáÕÇÏÇÊ 20 ÏÑÌÉ ááÃÓİá... æäŞæã ÈÊäŞíÕ ãÍæÑ ÇáÓíäÇÊ 60 ÏÑÌÉ... æíãßäß ÇáÊáÇÚÈ ÈÇáÃÑŞÇã ÍÊì ÊÍÕá Úáì ãÈÊÛÇÇß... Ìãííííá ÃáíÓ ßĞáß¿


==============================================================================                                                                           
	local l = result.add()
	l.layer = 3
íãßäß Ãä ÊÒíá ÇáØÈŞÉ ÑŞã (3) ÅĞÇ ÃÍÈÈÊ Ğáß... İÇÆÏÉ åĞå ÇáØÈŞÉ åæ ÌÚá ÇáÌãáÉ ßÇãáÉ ÇËäÇÁ ÊØÈíŞå... İŞÏ ÃÒáäÇ æŞÊ äåÇíÉ äØŞ ÇáãÛäí... ææÖÚäÇ ÇáÈÏÇíÉ İŞØ... æåĞÇ íÚäí Ãä ÇáÍÑæİ ÓÊÙåÑ İí æŞÊ ÈÏÇíÉ äØŞ ÇáãÛäí İŞØ æáä ÊÎÊİí ÅáÇ İí æŞÊ äåÇíÉ ÇáÌãáÉ ÇáÃÓÇÓíÉ... æÇáÚßÓ ÕÍíÍ
	l.start_time = line.start_time + syl.start_time/10
	l.text = string.format("{\\an5\\pos(%d,%d)\\fs30\\bord2\\shad0}%s",x,y,syl.text_stripped)


ÇäÊåì ÇáÏÑÓ



	return result

end 

åĞÇ ÇáÏÑÓ ÍÕÑí Úáì ãÏÑÓÉ ÌäÇÒÉ áÊÚáíã ÇáßÇÑíæßí
http://www.jnazh-karaoke.ahlamontada.net/index.htm

ááÇÓİÓÇÑÇÊ æÇáÃÓÆáÉ İí áæÇ...ÊİÖáæÇ Åáí ãÏÑÓÊí áÊÊÚáãæÇ ÇáãÒíÏ