--Author : Abdullah Al-Farsi(G_NAZ)
--Released int the public domain
����� ��� ���� ��� ����� ��� �� ����� �����... �� ��� ����� ����� ��� ���� ������... ���� ����..
name = "lesson 2" 
description = "www.jnazh-karaoke.ahlamontada.net" 
version, kind, configuration = 3, 'basic_ass', {} 

���� ���� ���� ����� �����... ���� ���� ���

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
�� ������ ��� (0) ����� ������ ���� �� ������� �������... ���� ������ ����� �� ����� ��� ������ ��� �����... ���� ���� �� ��� ���� ������� ������ ������
>_>
        l.end_time = line.start_time + syl.start_time/10
	l.text = string.format("{\\an5\\pos(%d,%d)\\fs30\\1c&H66F96A&\\3c&H0AA10E&\\shad0\\bord1}%s",x,y,syl.text_stripped)


============================================================================


	local l = result.add()
	l.layer = 1
                                                                            ����� ������ ����� �� ������ ��� (1)... ������ ������ �� �������
	l.start_time = line.start_time + syl.start_time/10  ��� ����� ���� ����� ��� ��� ��� ����... ����� ��� ��� ������ �����
	l.end_time = line.start_time + syl.start_time/8 + syl.duration  ��� �� ����� ��� ������ ���� �� ��� 8 ����� ����� �� ����� �� ������ �����... ��� ���� ������ �� ����� ������ ����� ����� ������ ����� �����

--syl.duration=��� ������ ������
                                                                       ��� ����� "���" ��� ���... ���� ����� ����� ���� ����... ���� ���� �� �����
	l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)}%s",x,y,x-60,y+20,syl.text_stripped)
                                                                                                      �� �����... ��� �� ��� ���� ����� ��� �����... ���� ������ ���� ������� 20 ���� ������... ����� ������ ���� ������� 60 ����... ������ ������� �������� ��� ���� ��� �������... ������� ���� ���߿


==============================================================================                                                                           
	local l = result.add()
	l.layer = 3
����� �� ���� ������ ��� (3) ��� ����� ���... ����� ��� ������ �� ��� ������ ����� ����� ������... ��� ����� ��� ����� ��� ������... ������ ������� ���... ���� ���� �� ������ ����� �� ��� ����� ��� ������ ��� ��� ����� ��� �� ��� ����� ������ ��������... ������ ����
	l.start_time = line.start_time + syl.start_time/10
	l.text = string.format("{\\an5\\pos(%d,%d)\\fs30\\bord2\\shad0}%s",x,y,syl.text_stripped)


����� �����



	return result

end 

��� ����� ���� ��� ����� ����� ������ ���������
http://www.jnazh-karaoke.ahlamontada.net/index.htm

���������� �������� �� ���...������ ��� ������ �������� ������