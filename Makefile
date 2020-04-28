SHELL := bash -euo pipefail

IMAGE := seattleflu/lab-result-reports
BUILD := $(shell ./devel/next-build-number)

image:
	docker build --tag=$(IMAGE):{latest,build-$(BUILD)} .

publish: image
	@echo "Checking that repo is clean"
	@if [[ -n $$(git status --porcelain --untracked-files=no) ]]; then\
		echo Error: Repository is not clean; \
		exit 1; \
	fi
	
	@echo "Checking that branch is up-to-date with origin"
	@if [[ $$(git rev-parse HEAD) != $$(git rev-parse HEAD@{u}) ]]; then \
		echo Error: Branch is not up-to-date with origin; \
		exit 1; \
	fi
	
	@echo "Tagging build-$(BUILD)"
	@git tag build-$(BUILD) -m "build #$(BUILD)"
	
	@echo "Pushing $(IMAGE):{latest,build-$(BUILD)} to Docker Hub"
	docker image push $(IMAGE):latest
	docker image push $(IMAGE):build-$(BUILD)
	
	@echo "Pushing build-$(BUILD) tag to git"
	@git push origin tag build-$(BUILD)
