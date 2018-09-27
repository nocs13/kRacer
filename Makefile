include ../kgmEngine/Makefile.mac

subdirs := $(wildcard src)

sources = $(wildcard $(subdirs)/*.cpp)
sources += $(wildcard *.cpp)

objects := $(patsubst %.cpp, %.o, $(sources))

OUT_BIN = kRacer.bin
OUT_A   = kRacer.a

DIRS    = -I ../kgmEngine -L ../kgmEngine -L ../kgmEngine/kgmSystem/lib

#LIBS += -lkgmEngine_s

ifeq ($(OS), Linux)
else
endif

all: debug
	echo $(objects)
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

$(objects) : %.o : %.cpp
	$(CC) $(FLGS) $(DEFS) -c $< -o $@ $(DIRS)

$(OUT_BIN): $(objects) ../kgmEngine/libkgmEngine_s.a
	$(CC) -g -o $(OUT_BIN) $(objects) -O0 -Werror $(DEFS) $(DIRS) -lkgmEngine_s $(LIBS)

clean:
	$(RM) $(OUT_BIN) $(OUT_SO) $(OUT_A) *.o

run:
	./$(OUT_BIN)

android: clean
	make -C android
