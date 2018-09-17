include ../kgmEngine/Makefile.mac

subdirs := $(wildcard src/)

objects := $(patsubst %.cpp,%.o,$(sources))

OUT_BIN = kRacer.bin
OUT_SO  = kRacer.so
OUT_A   = kRacer.a

DIRS    = -I ./src -L ./lib -L ../kgmEngine/kgmSystem/lib

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

$(OUT_A): $(objects)
	$(AR) -r -c -s $(OUT_A) $(objects)

$(OUT_SO): $(objects)
	$(CC) -shared -o $(OUT_SO) $(objects) $(FLGS) $(DEFS) $(DIRS) $(LIBS)

$(OUT_BIN): $(OUT_SO) $(OUT_A) kRacer.cpp
	$(CC) -g -o $(OUT_BIN) kRacer.cpp -O0 -Werror $(DEFS) $(DIRS) $(LIBS)

clean:
	$(RM) $(OUT_BIN) $(OUT_SO) $(OUT_A) *.o

run:
	./$(OUT_BIN)

android: clean
	make -C android
