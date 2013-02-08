coffee := ./node_modules/.bin/coffee

build:
  @$(coffee) -c -o public/javascripts/compiled -c public/javascripts/coffee

run:
  @$(coffee) -c -o public/javascripts/compiled -c public/javascripts/coffee
  @node server

test:
  @./node_modules/.bin/mocha

.PHONY: test build run