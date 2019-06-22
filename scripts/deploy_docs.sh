#!/bin/bash

echo "deploy docs"

DOCS_DIR="${1}"
echo "DOCS_DIR: ${DOCS_DIR}"

if [ "$TRAVIS_BRANCH" == "deploy-docs" ]; then
  	echo "do deploy"

  	cd "${DOCS_DIR}"
  	git init
  	git config user.name "Travis CI"
	git config user.email "travis@travis-ci.org"
	git add .
	git commit --message "Auto deploy from Travis CI build $TRAVIS_BUILD_NUMBER"
	git remote add deploy "https://${GH_TOKEN}@github.com/wolf81/FenrisDocs.git" >/dev/null 2>&1
	git push --force deploy master >/dev/null 2>&1
fi