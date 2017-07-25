PAWNCC=LD_LIBRARY_PATH=compiler/:$(LD_LIBRARY_PATH) ./compiler/pawncc

NAME=ZZ-RP
PARAMS=-d2

all:
	$(PAWNCC) $(PARAMS) "-;+" "-(+" "-icompiler/includes" "-isources" "-isources/lib/protection" "-ogamemodes/$(NAME).amx" "sources/$(NAME).pwn"

clean:
	rm gamemodes/$(NAME).lst gamemodes/$(NAME).asm gamemodes/$(NAME).amx
