#! /usr/bin/env bash

rm -rf dist
mkdir dist
cp src/* dist
NODE_ENV=production npx tailwindcss-cli build src/styles.css -o dist/styles.css
docker build -t radar-home .
