.PHONY: test

test:  clean
	xcodebuild test -workspace "Fenris.xcworkspace" -scheme "Fenris macOS" -destination "platform=macOS,arch=x86_64"

clean:
	xcodebuild clean
