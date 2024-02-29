from pyonfx import *
from multipledispatch import dispatch
import re



io = Ass("Edit.ass")
meta, styles, lines = io.get_data()

default_fscx = 100
default_fscy = 130
default_xshad = 5
default_yshad = 5


def test(line, l):

    fscxArray = getFscx(l.raw_text)
    fscyArray = getFscy(l.raw_text)

    if len(fscxArray) == 2 and len(fscyArray) == 2:
        startFscx, endFscx = fscxArray[0], fscxArray[1]
        startFscy, endFscy = fscyArray[0], fscyArray[1]

        startXshad = (default_xshad / default_fscx) * startFscx
        startYshad = (default_yshad / default_fscy) * startFscy

        endXshad = (default_xshad / default_fscx) * endFscx
        endYshad = (default_yshad / default_fscy) * endFscy

        l.raw_text = setXShad(l.raw_text, startXshad, endXshad)
        l.raw_text = setYShad(l.raw_text, startYshad, endYshad)

        l.text = l.raw_text
        io.write_line(l)
    elif len(fscxArray) == 1 and len(fscyArray) == 1:
        fscx, fscy = fscxArray[0], fscyArray[0]

        xshad = (default_xshad / default_fscx) * fscx
        yshad = (default_yshad / default_fscy) * fscy

        l.raw_text = setXShad(l.raw_text, xshad)
        l.raw_text = setYShad(l.raw_text, yshad)

        l.text = l.raw_text
        io.write_line(l)

@dispatch(str, float, float)
def setXShad(text, startXshad, endXshad):
    regex = re.search("\\\\t\\(.*\\)", text)
    return text[:regex.start()] + "\\xshad" + str('%.2f' % startXshad) +  text[regex.start():regex.end()-1] + "\\xshad" + str('%.2f' % endXshad) + text[regex.end()-1:]

@dispatch(str, float, float)
def setYShad(text, startYshad, endYshad):
    regex = re.search("\\\\t\\(.*\\)", text)
    return text[:regex.start()] + "\\yshad" + str('%.2f' % startYshad) +  text[regex.start():regex.end()-1] + "\\yshad" + str('%.2f' % endYshad) + text[regex.end()-1:]

@dispatch(str, float)
def setXShad(text, xshad):
    regex = re.search("\\}", text)
    return text[:regex.start()] + "\\xshad" + str('%.2f' % xshad) + text[regex.end()-1:]

@dispatch(str, float)
def setYShad(text, yshad):
    regex = re.search("\\}", text)
    return text[:regex.start()] + "\\yshad" + str('%.2f' % yshad) + text[regex.end()-1:]


def getFscx(text):
    regex = re.findall("\\\\fscx[0-9]{1,3}", text)
    
    fscxArray = []
    if regex:
        for fscx in regex:
            fscxArray.append(float(fscx.split("\\fscx")[1]))
        
        return fscxArray
    else:
        fscxArray.append(default_fscx)
        return fscxArray

def getFscy(text):
    regex = re.findall("\\\\fscy[0-9]{1,3}", text)
    
    fscyArray = []
    if regex:

        for fscy in regex:
            fscyArray.append(float(fscy.split("\\fscy")[1]))
        
        return fscyArray    
    else:
        fscyArray.append(default_fscy)        
        return fscyArray

for line in lines:

    # Generating lines
    if line.effect == "Shad":
        test(line, line.copy())


io.save()
io.open_aegisub()