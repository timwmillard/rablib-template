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

# all: $(TARGET)

# $(TARGET): %.o
# 	$(LD) -o $(TARGET) $< $(LDFLAGS)

# %.o: src/%.c
# 	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

clean:
	rm -f *.o $(TARGET)

