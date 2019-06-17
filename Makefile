.PHONY: test

test:  clean
	xcodebuild test -workspace "Fenris.xcworkspace" -scheme "Fenris macOS" -destination "platform=macOS,arch=x86_64" OBJROOT="$(PWD)/build" -sdk "macosx10.14"

clean:
	xcodebuild clean
