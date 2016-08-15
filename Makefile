DOCKER_TAG=solarisbank/idnow-client-test

rspec:
	docker run -t $(DOCKER_TAG) rspec

rubocop:
	docker run -t $(DOCKER_TAG) rubocop

test: rubocop rspec

build:
	docker build -t $(DOCKER_TAG) -f ci/Dockerfile .
