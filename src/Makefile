CC = gcc
CFLAGS = -Wall -I../include
OBJ_DIR = ../obj
BIN_DIR = ../bin
TARGET = $(BIN_DIR)/client

SOURCES = main.c mystrfunctions.c myfilefunctions.c
OBJECTS = $(SOURCES:%.c=$(OBJ_DIR)/%.o)

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJECTS)
	@mkdir -p $(BIN_DIR)
	$(CC) $(OBJECTS) -o $(TARGET)

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ_DIR)/*.o $(TARGET)
