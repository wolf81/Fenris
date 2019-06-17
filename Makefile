.PHONY: test clean

test: 
	# test project	
	xcodebuild test -workspace "Fenris.xcworkspace" -scheme "Fenris macOS" -destination "platform=macOS,arch=x86_64" OBJROOT="$(PWD)/build" -sdk "macosx10.14"

build:
	# build project
	xcodebuild build -workspace "Fenris.xcworkspace" -scheme "Fenris macOS" -destination "platform=macOS,arch=x86_64" OBJROOT="$(PWD)/build" -sdk "macosx10.14"

clean:
	# clean project
	xcodebuild clean
