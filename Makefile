coffee     := ./node_modules/.bin/coffee
browserify := ./node_modules/.bin/browserify
mocha      := ./node_modules/.bin/mocha

build:
	@echo
	@$(coffee) templatizer.coffee
	@$(browserify) -e public/javascripts/lib/index.coffee -o ./public/javascripts/compiled/bundle.js

run:
	@make build
	@echo
	@$(coffee) app

test:
	@echo
	@$(mocha)

clean:
	@echo
	@mongo nodelove --eval "db.dropDatabase()"

reload:
	@make clean
	@make run

.PHONY: test build run clean reload