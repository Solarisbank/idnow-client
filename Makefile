test: rspec

rspec:
	bundle exec rspec

rubocop:
	bundle exec rubocop

build:
	docker build -t idnow-client .

dev: build
	docker run --rm -it -v $$PWD:/gem idnow-client bash