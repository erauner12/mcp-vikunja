# -----------------------------------------
# Build & publish mcp-vikunja Docker image
# -----------------------------------------

# docker-hub user / tag  (override at CLI or env)
DOCKER_USER ?= your_dockerhub_user
DOCKER_TAG  ?= latest

IMAGE := $(DOCKER_USER)/mcp-vikunja:$(DOCKER_TAG)

.PHONY: build push login run clean

## build: create the image locally
build:
	docker build -t $(IMAGE) .

## push: build + push to Docker Hub
push: build
	docker push $(IMAGE)

## login: docker login wrapper
login:
	docker login

## run: start the container with .env mounted
run: build
	docker run --rm -it --env-file .env $(IMAGE)

## clean: delete local image
clean:
	docker rmi -f $(IMAGE) || true