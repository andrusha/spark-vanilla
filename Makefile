.PHONY: help build minikube

help:
	@echo 'Usage: make [target] ...'
	@echo
	@echo 'Targets:'
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

build:  ## Builds local images
	@docker build -t andrusha/spark-vanilla:base base
	@docker build -t andrusha/spark-vanilla:master master
	@docker build -t andrusha/spark-vanilla:worker worker

minikube:  ## Builds images in the minikube context
	@eval $(minikube docker-env)
	@make build