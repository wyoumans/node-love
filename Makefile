coffee     := ./node_modules/.bin/coffee
browserify := ./node_modules/.bin/browserify
mocha      := ./node_modules/.bin/mocha

build:
	@$(coffee) templatizer.coffee
	@$(browserify) -e public/javascripts/lib/index.coffee -o ./public/javascripts/compiled/bundle.js

run:
	@make build
	@$(coffee) app

test:
	@$(mocha)

.PHONY: test build run