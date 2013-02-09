coffee     := ./node_modules/.bin/coffee
browserify := ./node_modules/.bin/browserify

build:
	#@$(coffee) -o public/javascripts/compiled -c public/javascripts/lib
	@$(browserify) -e public/javascripts/lib/index.coffee -o ./public/javascripts/compiled/bundle.js

run:
	@make build
	@$(coffee) app

test:
	@./node_modules/.bin/mocha

.PHONY: test build run