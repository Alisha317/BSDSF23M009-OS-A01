CC = gcc
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
LIB_DIR = lib
MAN_DIR = man/man3
TARGET = $(BIN_DIR)/client

PREFIX = /usr/local
INSTALL_BIN = $(PREFIX)/bin
INSTALL_MAN3 = $(PREFIX)/share/man/man3
INSTALL_MAN1 = $(PREFIX)/share/man/man1

.PHONY: all clean run install uninstall

all:
	$(MAKE) -C $(SRC_DIR)

clean:
	$(MAKE) -C $(SRC_DIR) clean

run: all
	./$(TARGET)

install: all
	install -d $(INSTALL_BIN)
	install -m 755 $(TARGET) $(INSTALL_BIN)/client
	install -d $(INSTALL_MAN3)
	install -m 644 $(MAN_DIR)/mystrlen.3 $(MAN_DIR)/mystrcpy.3 $(MAN_DIR)/mystrncpy.3 $(MAN_DIR)/mystrcat.3 $(MAN_DIR)/wordCount.3 $(MAN_DIR)/mygrep.3 $(INSTALL_MAN3)/
	install -d $(INSTALL_MAN1)
	install -m 644 $(MAN_DIR)/client.1 $(INSTALL_MAN1)/
	mandb >/dev/null 2>&1 || true

uninstall:
	rm -f $(INSTALL_BIN)/client
	rm -f $(INSTALL_MAN3)/mystrlen.3 $(INSTALL_MAN3)/mystrcpy.3 $(INSTALL_MAN3)/mystrncpy.3 $(INSTALL_MAN3)/mystrcat.3 $(INSTALL_MAN3)/wordCount.3 $(INSTALL_MAN3)/mygrep.3
	rm -f $(INSTALL_MAN1)/client.1
