# The MIT License (MIT)
#
# Copyright (c) 2016 Jean Guyomarc'h
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

BUILD_DIR := build
QL := pud-quicklook.qlgenerator
QL_DIR := /Library/QuickLook

.PHONY: all install uninstall check quicklook libpud help

all: libpud quicklook

war2tools/CMakeLists.txt:
	if [ -d .git/ ]; then git submodule update --init --recursive; fi

libpud: war2tools/CMakeLists.txt
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) \
	    && cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS:BOOL=OFF ../war2tools \
	    && cmake --build . --target libpud

quicklook:
	xcodebuild -scheme pud-quicklook -project pud-quicklook.xcodeproj/ CONFIGURATION_BUILD_DIR=$(BUILD_DIR)

install: uninstall
	cp -r $(BUILD_DIR)/$(QL) $(QL_DIR)/$(QL)

uninstall:
	$(RM) -r $(QL_DIR)/$(QL)

check: $(BUILD_DIR)/$(QL)
	qlmanage -r
	qlmanage -p tests/cibola.pud

help:
	@echo "-------------------------"
	@echo "--- Available targets ---"
	@echo "-------------------------"
	@echo ""
	@echo "all........: build the libpud and the quicklook plugin"
	@echo "install....: install the quicklook plugin"
	@echo "uninstall..: remove the installed quicklook plugin"
	@echo "check......: test the installed quicklook plugin"
	@echo ""
	@echo "libpud.....: build the libpud only"
	@echo "quicklook..: build the quicklook plugin only"
