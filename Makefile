include ../kgmEngine/Makefile.mac

subdirs := $(wildcard src/)

objects := $(patsubst %.cpp,%.o,$(sources))

OUT_BIN = kRacer.bin
OUT_A   = kRacer.a

DIRS    = -I ../kgmEngine -L ../kgmEngine -L ../kgmEngine/kgmSystem/lib

LIBS += -lkgmEngine

ifeq ($(OS), Linux)
else
endif

all: debug
	echo "Builded."

set_debug:
	$(eval DEFS += -DDEBUG)
	$(eval FLGS += -g)

set_release:
	$(eval DEFS += -DRELEASE)


release: set_release  $(OUT_BIN)
	echo 'release finished.'

debug: set_debug $(OUT_BIN)
	echo 'debug finished.'

$(objects) : %.o : %.cpp %.h
	$(CC) $(FLGS) $(DEFS) -c $< -o $@ $(DIRS)

$(OUT_BIN): $(objects)
	$(CC) -g -o $(OUT_BIN) $(objects) -O0 -Werror $(DEFS) $(DIRS) $(LIBS)

clean:
	$(RM) $(OUT_BIN) $(OUT_SO) $(OUT_A) *.o

run:
	./$(OUT_BIN)

android: clean
	make -C android
