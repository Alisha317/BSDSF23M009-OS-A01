CC = gcc
AR = ar
ARFLAGS = rcs
CFLAGS = -Wall -I../include
OBJ_DIR = ../obj
BIN_DIR = ../bin
LIB_DIR = ../lib
TARGET = $(BIN_DIR)/client_static
LIB = $(LIB_DIR)/libmyutils.a

LIB_SOURCES = mystrfunctions.c myfilefunctions.c
LIB_OBJECTS = $(LIB_SOURCES:%.c=$(OBJ_DIR)/%.o)
MAIN_OBJECT = $(OBJ_DIR)/main.o

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(MAIN_OBJECT) $(LIB)
	@mkdir -p $(BIN_DIR)
	$(CC) $(MAIN_OBJECT) -L$(LIB_DIR) -lmyutils -o $(TARGET)

$(LIB): $(LIB_OBJECTS)
	@mkdir -p $(LIB_DIR)
	$(AR) $(ARFLAGS) $(LIB) $(LIB_OBJECTS)

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ_DIR)/*.o $(TARGET) $(LIB)
