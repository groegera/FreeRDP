#
#  Makefile - Copyright (c) Andreas Gröger, Ilvesheim
#
BUILD := build
INSTALL := install

INST_CMDS=client/X11/install/strip \
  client/common/install/strip \
  winpr/libwinpr/install/strip \
  libfreerdp/install/strip


.DEFAULT_GOAL:=all
.PHONY: all do_build do_install clean buildclean

all:  do_install

$(BUILD):
	@echo --- setup cmake
	@cmake -S . -B $(BUILD) -DCMAKE_INSTALL_PREFIX=$(INSTALL) -DCMAKE_BUILD_TYPE=Release -DWITH_VERBOSE_WINPR_ASSERT=OFF -DWITH_VAAPI_H264_ENCODING=OFF


do_build: $(BUILD)
	@cmake --build $(BUILD)


do_install: do_build
	@echo --- install
	@cmake --build $(BUILD) $(INST_CMDS:%=-t %)
	@rm -r $(INSTALL)/lib/cmake $(INSTALL)/lib/pkgconfig

clean:
	@echo --- rm $(INSTALL)
	@rm -fr $(INSTALL)

buildclean:
	@echo --- rm $(BUILD)
	@rm -fr $(BUILD)
