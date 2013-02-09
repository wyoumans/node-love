coffee     := ./node_modules/.bin/coffee
browserify := ./node_modules/.bin/browserify

build:
	#@$(coffee) -o public/javascripts/compiled -c public/javascripts/coffee
	@$(browserify) -e public/javascripts/coffee/browserify.coffee -o ./public/javascripts/compiled/bundle.js

run:
	@make build
	@$(coffee) app

test:
	@./node_modules/.bin/mocha

.PHONY: test build run