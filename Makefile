ARACHNE_OPTS=-d 8k -P ct256

blink.bin: blink.v blink.pcf
	yosys -s build.yosys -p "write_blif -gates -attr -param blink.blif"
	arachne-pnr $(ARACHNE_OPTS) blink.blif -p blink.pcf > blink.txt
	icepack blink.txt blink.bin

clean:
	rm -f blink.blif blink.txt blink.bin

flash: blink.bin
	iceprog blink.bin
