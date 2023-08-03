.PHONY: all clean
# change application name here (executable output name)
TARGET=app

# compiler
CC=clang
# linker
LD=clang
# debug
DEBUG=-g
# optimisation
OPT=-O0
# warnings
WARN=-Wall

# CFLAGS=$(DEBUG) $(OPT) $(WARN)

# raylib
CFLAGS += $(shell pkg-config --cflags raylib)
LDFLAGS += $(shell pkg-config --libs raylib)


all : $(TARGET)

$(TARGET) : main.o
	$(LD) -o $(TARGET) $< $(LDFLAGS)

main.o : src/main.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

## Statically linked build

# Need to build raylib from source first
# Then update path to libraylib
STATIC_RAYLIB = ~/cprogs/vendor/raylib/src/libraylib.a
# clang -framework CoreVideo -framework IOKit -framework Cocoa -framework GLUT -framework OpenGL libraylib.a my_app.c -o my_app
FRAMEWORKS = -framework CoreVideo -framework IOKit -framework Cocoa -framework GLUT -framework OpenGL
release : main.o
	$(LD) -o $(TARGET) $< $(FRAMEWORKS) $(STATIC_RAYLIB)
	cp $(TARGET) release/$(TARGET).app/Contents/MacOS/

# all: $(TARGET)

# $(TARGET): %.o
# 	$(LD) -o $(TARGET) $< $(LDFLAGS)

# %.o: src/%.c
# 	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

clean:
	rm -f *.o $(TARGET) release/$(TARGET).app/Contents/MacOS/$(TARGET)

