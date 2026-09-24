CC = gcc
AR = ar
ARFLAGS = rcs
CFLAGS = -Wall -I../include
CFLAGS_PIC = -Wall -I../include -fPIC
OBJ_DIR = ../obj
BIN_DIR = ../bin
LIB_DIR = ../lib

STATIC_TARGET = $(BIN_DIR)/client_static
DYNAMIC_TARGET = $(BIN_DIR)/client_dynamic
STATIC_LIB = $(LIB_DIR)/libmyutils.a
DYNAMIC_LIB = $(LIB_DIR)/libmyutils.so

LIB_SOURCES = mystrfunctions.c myfilefunctions.c
LIB_OBJECTS = $(LIB_SOURCES:%.c=$(OBJ_DIR)/%.o)
PIC_OBJECTS = $(LIB_SOURCES:%.c=$(OBJ_DIR)/%_pic.o)
MAIN_OBJECT = $(OBJ_DIR)/main.o

.PHONY: all static dynamic clean

all: static dynamic

static: $(STATIC_TARGET)

dynamic: $(DYNAMIC_TARGET)

$(STATIC_TARGET): $(MAIN_OBJECT) $(STATIC_LIB)
	@mkdir -p $(BIN_DIR)
	$(CC) $(MAIN_OBJECT) -L$(LIB_DIR) -lmyutils -o $(STATIC_TARGET)

$(STATIC_LIB): $(LIB_OBJECTS)
	@mkdir -p $(LIB_DIR)
	$(AR) $(ARFLAGS) $(STATIC_LIB) $(LIB_OBJECTS)

$(DYNAMIC_TARGET): $(MAIN_OBJECT) $(DYNAMIC_LIB)
	@mkdir -p $(BIN_DIR)
	$(CC) $(MAIN_OBJECT) -L$(LIB_DIR) -lmyutils -o $(DYNAMIC_TARGET)

$(DYNAMIC_LIB): $(PIC_OBJECTS)
	@mkdir -p $(LIB_DIR)
	$(CC) --shared -o $(DYNAMIC_LIB) $(PIC_OBJECTS)

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/%_pic.o: %.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS_PIC) -c $< -o $@

clean:
	rm -f $(OBJ_DIR)/*.o $(STATIC_TARGET) $(DYNAMIC_TARGET) $(STATIC_LIB) $(DYNAMIC_LIB)
