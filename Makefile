APP_NAME=love_benchmark
APP_VERSION=0.1
LOVE_VERSION=0.10.2

build setup:
	mkdir build

all:portable

portable:
	zip -9 -q -r build/$(APP_NAME)-$(APP_VERSION).love . -x \*.git* \build

clean:
	rm -rf build/
