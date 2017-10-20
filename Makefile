THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2222
ARCHS = armv7 arm64

include /opt/theos/makefiles/common.mk

TWEAK_NAME = iOSWeChatFakeLocation
iOSWeChatFakeLocation_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
