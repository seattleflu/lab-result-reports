SHELL := bash -euo pipefail

BUILD := $(shell ./devel/next-build-number)

docker:
	docker build --tag=seattleflu/lab-result-reports:{latest,build-$(BUILD)} .

publish: docker
	git tag build-$(BUILD) -m "build #$(BUILD)"
	docker image push seattleflu/lab-result-reports:latest
	docker image push seattleflu/lab-result-reports:build-$(BUILD)
