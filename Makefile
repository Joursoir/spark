PREFIX ?= /usr/local/bin
MAN_PATH = /usr/share/man/man1
SCRIPT_NAME = spark.sh

.PHONY: all clean install uninstall

all:
	@echo "Spark is a shell script. Try \"make install\" instead."

install:
	@install -m 755 -v $(SCRIPT_NAME) $(PREFIX)/$(SCRIPT_NAME:.sh= )

uninstall:
	@rm -vf $(PREFIX)/$(SCRIPT_NAME:.sh= )