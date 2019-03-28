#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# push to github repository
git add dist
git commit -m "HELLO"
git subtree push --prefix dist origin gh-pages