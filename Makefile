TARGET = iphone:16.5:16.0
ARCHS = arm64e
INSTALL_TARGET_PROCESSES = JQYS

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = JQYSAdAuto
JQYSAdAuto_FILES = Tweak.xm
JQYSAdAuto_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
