browserify := ./node_modules/.bin/browserify
mocha      := ./node_modules/.bin/mocha

build:
	@echo
	@node templatizer.js
	@$(browserify) -e public/javascripts/lib/index.js -o ./public/javascripts/compiled/bundle.js

run:
	@make build
	@echo
	@node server

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
