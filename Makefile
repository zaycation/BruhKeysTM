export TARGET = iphone:clang:12.1:11.0
FINALPACKAGE=1

include $(THEOS)/makefiles/common.mk

ARCHS = arm64 arm64e

TWEAK_NAME = gayKeys

gayKeys_FILES = Tweak.xm
gayKeys_CFLAGS = -fobjc-arc
gayKeys_EXTRA_FRAMEWORKS = Cephei
SUBPROJECTS += prefs

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"

include $(THEOS_MAKE_PATH)/aggregate.mk
