--Author : Abdullah Al-Farsi(G_NAZ)
--Released int the public domain


--����... ������� ����ӿ! ����� ^^�
--���� ���� ����� ������ �� ����� ����� ���� ���������
--��� ���� ��������� ����� �������
--���... ������ ��� ���� ���� ���... ��� ��� ���� ���� ����� �����

--������ ��� ����

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

                                                   --��� �� ������ ������.. ������ ���� (������ ����� �� ��� �����).. ����� �� ������ �������^^�
                  l.end_time = line.start_time + syl.start_time/10
	l.text = string.format("{\\an5\\pos(%d,%d)\\fad(0,400)}%s",x,y,syl.text_stripped)

	local l = result.add()                               --�� ������ �������
	l.layer = 1                                  
	l.start_time = line.start_time + syl.start_time/10 --����� ��� ���� ������ �� ����� ��� ������
	l.end_time = line.start_time + syl.start_time/8  --��� ������� ������� ���� ��� ���� ������ ����� ����� ��� �� �����... ���� ���� ����^^�
                                                                          --�� ��� ���������... ��� ��� "���" ��� ��� ��� ���� ������ �������� ��� ����... ������� ����� ������ ������ ����� �������� ����� "��".... ���� ������ ��� �� ���� ��
	l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\t(\\frz180\\frx180\\fry180)\\1c&H8F4CCF&\\p1}m -3 -9 l -6 -4 l -7 1 l -1 9 l 6 1 l 5 -4 l 3 -9 l 0 -3 l -3 -9 {\\p0}",x,y,x-20,y+50,syl.text)
                                                                                                                                                                  --���� ������� ��� ��� �������! ���� ��� �� ���� ������ ^(^ ����� ���� ������ ���� "����" ���� �����.. ���� ���� ��� ������ ��� �����
                                                                                                                                                             --������ �� ��������� ������ "��� ��������" ��� ���� ��� ������� ������ �����
	local l = result.add()
	l.layer = 2

	l.start_time = line.start_time + syl.start_time/10
	l.text = string.format("{\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)

                 

        return result

end 


--��� ����� �� ������ �� ����� ����� ������ ���������
--�� ���� �� ������ �� ��� �� ������� �� ������
--www.jnazh-karaoke-ahlamontada.net
--31\7\2008

--��� ����� ����� �� �����