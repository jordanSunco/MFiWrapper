export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:7.0:7.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = mfiwrapper
mfiwrapper_FILES =  src/common.cpp \
                    \
                    src/frontend/frontend.mm \
                    src/frontend/GCController_Hook_iOS.xm \
                    src/frontend/MFiWrapper.mm \
                    src/frontend/keyboard.mm \
                    \
                    src/backend/backend.cpp \
                    src/backend/hidmanager/HIDManager.cpp \
                    src/backend/hidpad/HIDPad.cpp \
                    src/backend/hidpad/HIDPad_Playstation3.cpp \
                    src/backend/hidpad/HIDPad_DualShock4.cpp \
                    src/backend/hidpad/HIDPad_WiiMote.cpp \
                    src/backend/hidpad/HIDPad_WiiUPro.cpp \
                    src/backend/hidpad/wiimote.cpp

LOG_LEVEL           =  3

mfiwrapper_CFLAGS  += -DIOS
mfiwrapper_CCFLAGS += -std=c++11 -Iinclude -Isrc/frontend -Isrc -DLOG_LEVEL=$(LOG_LEVEL)
mfiwrapper_CCFLAGS += -Isrc/backend -Isrc/backend/hidpad -Isrc/backend/hidmanager -I.

ifdef USE_ICADE
mfiwrapper_CFLAGS  += -DUSE_ICADE
endif

mfiwrapper_LDFLAGS = -framework UIKit -L. -lIOKit

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += btserverfilter
include $(THEOS_MAKE_PATH)/aggregate.mk
