--Author : Abdullah Al-Farsi(G_NAZ)
--Released int the public domain


--√ÊﬂÌ... „” ⁄œÌ‰ ··œ—”ø! ÿ»⁄« ^^ﬂ
--œ—”Ì ·Â–« «·ÌÊ„ »Ì ﬂ·„ ⁄‰ ﬂÌ›Ì… ≈÷«›… —”Ê„ ··ﬂ«—ÌÊﬂÌ
--„„« Ì“Ìœ «·ﬂ«—ÌÊﬂÌ ÕÌÊÌ… ÊÃ„«·«
--ÿÌ»... «‰“·Ê«  Õ  ⁄‘«‰ «‘—Õ ·ﬂ„... Ê≈‰ ‘«¡ «··Â ‘—ÕÌ »Ìÿ·⁄  „««„

-- Êﬂ·‰« ⁄·Ï «··Â

name = "Lesson 3" 
description = "www.jnazh-karaoke-ahlamontada.net" 
version, kind, configuration = 3, 'basic_ass', {} 


include("karaskel-adv.lua") 

function do_syllable(meta, styles, config, line, syl) 


	local result = {n=0} 


            function result.add() local l = copy_line(line); table.insert(result, l); return l end


	local x = line.centerleft + syl.center                   
	local y = 45                                                           
	local start_t = syl.start_time                                    
	local mid_t =  syl.start_time + syl.duration*5   
	local end_t = syl.end_time 
	       

        local l = result.add()
	l.layer = 0 

                                                   --Â–Ì ÂÌ «·ÿ»ﬁ… «·√Ê·Ï.. »‰Œ·ÌÂ ⁄«œÌ (Ì„ﬂ‰ﬂ„ ≈÷«›… √Ì ﬂÊœ  »Ê‰Â).. ‘€·‰« ›Ì «·ÿ»ﬁ… «·À«‰Ì…^^œ
                  l.end_time = line.start_time + syl.start_time/10
	l.text = string.format("{\\an5\\pos(%d,%d)\\fad(0,400)}%s",x,y,syl.text_stripped)

	local l = result.add()                               --›Ì «·ÿ»ﬁ… «·À«‰Ì…
	l.layer = 1                                  
	l.start_time = line.start_time + syl.start_time/10 --»‰Œ·Ì Êﬁ  ŸÂÊ— «·—”„… ›Ì »œ«Ì… ‰ÿﬁ «·„€‰Ì
	l.end_time = line.start_time + syl.start_time/8  --·ﬂ‰ «·‰Â«Ì… »‰√Œ—Â« ‘ÊÌ… Õ Ï   —ﬂ «·—”„…   Õ—ﬂ “Ì«œ… ﬁ»· ·«  Œ ›Ì... Ã„Ì· √·Ì” ﬂ–·ﬂ^^ø
                                                                          --›Ì Ê÷⁄ «· √ÀÌ—« ... ‰Õÿ ﬂÊœ "ﬂÊ›" ÊÂÊ „Â„ Õ Ï ‰Õ—ﬂ «·—”„… »«·« Ã«Â √·Ì ‰»€Ì... Ê ﬁœ—Ê‰  Œ·Ê‰ «·—”„…   ‘ﬁ·» Ê œÊ— »√” Œœ«„ «·ﬂÊœ " Ì".... ⁄«„· «·—”„… ﬂ„« ·Ê «‰Â« ‰’
	l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\t(\\frz180\\frx180\\fry180)\\1c&H8F4CCF&\\p1}m -3 -9 l -6 -4 l -7 1 l -1 9 l 6 1 l 5 -4 l 3 -9 l 0 -3 l -3 -9 {\\p0}",x,y,x-20,y+50,syl.text)
                                                                                                                                                                  --Ì„ﬂ‰  ”√·Ê‰Ì ‘‰Ê Â–Ì «·«—ﬁ«„ø! »ﬁÊ· ·ﬂ„ ÂÌ ‰ﬁ«ÿ «·—”„… ^(^ Ê·«“„  ﬂÊ‰ „”»Êﬁ… »Õ—› "«·«„" ⁄‘«‰  ‘ €·.. Ê»⁄œ ·«“„ ‰Õÿ «·—”„… »Ì‰ ﬁÊ”Ì‰
                                                                                                                                                             --Ê·„“Ìœ „‰ «·„⁄·Ê„«  «œŒ·Ê« "„Â„ ··—”«„Ì‰" Õ Ï «‘—Õ ·ﬂ„ «·«‘Ì«¡ «·„Â„… ··—”„
	local l = result.add()
	l.layer = 2

	l.start_time = line.start_time + syl.start_time/10
	l.text = string.format("{\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)

                 

        return result

end 


--Â–« «·œ—”  „  Õ„Ì·Â „‰ „œ—”… Ã‰«“… · ⁄·Ì„ «·ﬂ«—ÌÊﬂÌ
--·Ê «—œ  «‰  ” ›”— ⁄‰ ‘Ì¡ ﬁ„ »ﬂ «» Â ›Ì „œ—” Ì
--www.jnazh-karaoke-ahlamontada.net
--31\7\2008

--Œ·Ì ÕÌ« ﬂ ≈Ã«“… „⁄ Ã‰«“…