THEOS_DEVICE_IP = 192.168.1.110
ARCH = arm64
TARGET = iphone:9.3

include /opt/theos/makefiles/common.mk

TWEAK_NAME = iOSWeChatFakeLocation
iOSWeChatFakeLocation_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
