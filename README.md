# luajit_bit_extended
extending the luajit bit lib



* ### bit.MSB(int value)
	Returns the value with it's most significant bit only **most**-**significant**-**bit** only
	```
	entry : 	424242 00000000 00000110 01111001 00110010

	exit:		262144 00000000 00000100 00000000 00000000
	```

* ### bit.LSB(int value)
	 Returns the value with it's most significant bit only **least**-**significant**-**bit** only

* ### bit.getPos(int value)
	Returns the position of the (only) bit of the number, mostly meant to be used with LSB and MSB, function itself used by `bit.select`
	```
	entry : 128 00000000 00000000 00000000 10000000
	exit: 8
	```
* ### bit.select(int value, mask)
	Similar to bit.band but also correctly right-shift it to get only the part we need.
	Example (Looks much better in the .lua comments because markdown formating sucks) : 
	```
	bit.select(133742101, 0xffffffff)

	entry : 	133742101 00000111 11111000 10111110 00010101
	
	exit: 		133742101 00000111 11111000 10111110 00010101
	```
	```
	bit.select(133742101, 0x00f0000)

	entry 133742101 : 	00000111 11111000 10111110 00010101

	mask =				00000000 00001111 00000000 00000000

	exit: 8		00001000
	```
	
	```
	bit.select(133742101, 0x0f0ff000)

	entry :	133742101 00000111 11111000 10111110 00010101

	mask = 	00001111 00001111 11110000 00000000

	exit: 28811 0111 00001000 10110000 00000000

	exit: 28811 01110000 10001011
	``````

* ### bit.split(int value)
	Turns the 32bit integer into a table (size = 32) of 1s and 0s

* ### bit.tostring(int value, bool bytes_separator)
	Returns a string (visual representation) of the integer.
