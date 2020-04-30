#!/usr/bin/env python3


"""Your goal is to connect to port 5842 on vortex.labs.overthewire.org and 
read in 4 unsigned integers in host byte order. Add these integers together and 
send back the results to get a username and password for vortex1. This information can be used to log in using SSH.

Note: vortex is on an 32bit x86 machine (meaning, a little endian architecture)"""
total = 0
import socket
import struct
site = 'vortex.labs.overthewire.org' 
port = 5842

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

s.connect((site,port))
for i in range( 4):
	d = s.recv(4)

	print(d)
	tmp = struct.unpack("<I", d)[0]
	total = total +  tmp
	print(tmp)
	# tmp = d[0]


	# print("Recievd %0i ore hex %0x"% (tmp, tmp))

	
	# print("New total: %0i,  %0x" % (total, total))
	# total = total + tmp

total=struct.pack("<I", (total & 0xFFFFFFFF))
print("Sending total as %s" % total)

s.send(total)
ret = s.recv(1024)
s.close()
print(str(ret))


# Sending total as b'Z\xea\x18\x9f'
# b'Username: vortex1 Password: Gq#qu3bF3
