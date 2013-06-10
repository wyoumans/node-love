browserify := ./node_modules/.bin/browserify
less       := ./node_modules/.bin/lessc
mocha      := ./node_modules/.bin/mocha
forever    := ./node_modules/.bin/forever

build:
	@echo
	@node templatizer.js
	@$(browserify) -e public/javascripts/lib/index.js -o ./public/javascripts/compiled/bundle.js
	@$(less) public/stylesheets/screen.less > public/stylesheets/screen.css
	@$(less) public/stylesheets/print.less > public/stylesheets/print.css
	@$(less) public/stylesheets/ie.less > public/stylesheets/ie.css

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

run-forever:
	@make build
	@$(forever) start --minUptime 1000 --spinSleepTime 1000 server.js

.PHONY: test build run clean reload
