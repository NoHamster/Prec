CC= g++
CFLAGS= -Wall -m64 -s -g #-O3 -mavx2

OUT_DIR := ./bin

SRC_DIRS := 	$(wildcard src/*.cpp) \
		$(wildcard src/parpre/*.c)

obj = $(SRC_DIRS:.c=.o)


Parser: $(obj)
	$(CC) -o $(OUT_DIR)/$@ $^ $(CFLAGS)

clean: $(obj)
	del $(subst /,\,$^)