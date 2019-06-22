.PHONY: test build clean docs

test: 
	# test project	
	set -o pipefail && xcodebuild test -workspace "Fenris.xcworkspace" -scheme "Fenris macOS" -destination "platform=macOS,arch=x86_64" OBJROOT="$(PWD)/build" -sdk "macosx10.14" | xcpretty

build:
	# build project
	set -o pipefail && xcodebuild build -workspace "Fenris.xcworkspace" -scheme "Fenris macOS" -destination "platform=macOS,arch=x86_64" OBJROOT="$(PWD)/build" -sdk "macosx10.14" | xcpretty

clean:
	# clean project
	set -o pipefail && xcodebuild clean | xcpretty

deploy_docs:
	# deploy docs
	jazzy
