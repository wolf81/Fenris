#!/bin/bash

DOCS_DIR="${1}"

if [ "${TRAVIS_BRANCH}" == "master" ]; then
  	echo "deploy docs"

  	cd "${DOCS_DIR}"
  	git init
  	git config user.name "Travis CI"
	git config user.email "travis@travis-ci.org"
	git add .
	git commit --message "Auto deploy from Travis CI build ${TRAVIS_BUILD_NUMBER}"
	git remote add deploy "https://${GH_TOKEN}@github.com/wolf81/FenrisDocs.git" >/dev/null 2>&1
	git push --force deploy master >/dev/null 2>&1
else
	echo "no docs will be deployed, not on master branch"
fi