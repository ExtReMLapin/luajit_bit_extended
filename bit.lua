--fast function
--entry : 424242    00000000 00000110 01111001 00110010
--exit: 262144      00000000 00000100 00000000 00000000
function bit.MSB(value)
	value = bit.bor(value, bit.rshift(value, 1))
	value = bit.bor(value, bit.rshift(value, 2))
	value = bit.bor(value, bit.rshift(value, 4))
	value = bit.bor(value, bit.rshift(value, 8))
	value = bit.bor(value, bit.rshift(value, 16))
	value = value + 1
	value = bit.rshift(value, 1)

	return value
end

--fast
--entry : 424242   00000000 00000110 01111001 00110010
--exit: 2          00000000 00000000 00000000 00000010
function bit.LSB(value)
	return bit.band(-value, value)
end

--fast
--entry : 128	  00000000 00000000 00000000 10000000
--exit: 8
-- it returns the position of the bit (starts at 1)
-- you can only enter power of two values
function bit.getPos(value)
	return math.log(value, 2) + 1
end

--fast

--bit.select(133742101, 0xffffffff)
--entry : 133742101	  00000111 11111000 10111110 00010101
--exit:   133742101	  00000111 11111000 10111110 00010101

--bit.select(133742101, 0x00f0000)
--entry : 133742101   00000111 11111000 10111110 00010101
--mask =              00000000 00001111 00000000 00000000
--exit: 8                      00001000

--bit.select(133742101, 0x0f0ff000)
--entry : 133742101   00000111 11111000 10111110 00010101
--mask =              00001111 00001111 11110000 00000000
--exit: 28811             0111 00001000 10110000 00000000
--exit: 28811                           01110000 10001011

function bit.select(value, mask)
	if mask == 0 then return 0 end
	local maskOffset = bit.getPos(bit.LSB(mask)) - 1

	return bit.rshift(bit.band(mask, value), maskOffset)
end

-- slow
--turns number into table of 0 or 1
function bit.split(value)
	-- pre allocate the table
	local bit_table = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	local i = 0

	while i < 32 do
		if bit.rshift(value, i) % 2 == 1 then
			bit_table[32 - i] = 1
		end

		i = i + 1
	end

	return bit_table
end

-- obviously slow
-- turns number into string of 0s and 1s bytes_separator to true to add space for every bytes
function bit.tostring(value, bytes_separator)
	if not bytes_separator then
		return table.concat(bit.split(value), sepatator)
	else
		return string.format("%s %s %s %s",
			table.concat(bit.split(value), sepatator, 1, 8),
			table.concat(bit.split(value), sepatator, 9, 16),
			table.concat(bit.split(value), sepatator, 17, 24),
			table.concat(bit.split(value), sepatator, 25, 32))
	end
end
