BINARY = program.bin

DASMOPTS = -vk

PROGS = s3dasm s3dasm_test s3asm

dasm: $(BINARY).asm
asm:  $(BINARY).asm.bin

$(BINARY).asm: $(BINARY) $(BINARY).txt s3dasm
	./s3dasm $(DASMOPTS) $<

$(BINARY).asm.bin: $(BINARY).asm s3asm
	./s3asm $<

asmx: $(BINARY).asm
	asm68k -e -C 68000 -b -o $<.asmx $<

clean:
	find . -name \*~ -delete
	rm -f $(BINARY).asm*

zip: $(BINARY).asm
	gzip -fk $<

install:
	if [ `id -u` -eq 0 ]; then \
	  cp $(PROGS) /usr/local/bin; \
	else \
	  mkdir -p ~/bin; \
	  cp $(PROGS)  ~/bin; \
	fi

.PHONY: dasm asm asmx clean zip install
