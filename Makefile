coffee := ./node_modules/.bin/coffee

build:
	@$(coffee) -o public/javascripts/compiled -c public/javascripts/coffee

run:
	@$(coffee) -o public/javascripts/compiled -c public/javascripts/coffee
	@node server

test:
	@./node_modules/.bin/mocha

.PHONY: test build run