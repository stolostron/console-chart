###############################################################################
# Copyright (c) 2020 Red Hat, Inc.
###############################################################################

CHART_NAME ?= console-chart
STABLE_CHART ?= stable/$(CHART_NAME)

# GITHUB_USER containing '@' char must be escaped with '%40'
GITHUB_USER := $(shell echo $(GITHUB_USER) | sed 's/@/%40/g')
GITHUB_TOKEN ?=

# Bootstrap (pull) the build harness
ifdef GITHUB_TOKEN
-include $(shell curl -H 'Authorization: token ${GITHUB_TOKEN}' -H 'Accept: application/vnd.github.v4.raw' -L https://api.github.com/repos/stolostron/build-harness-extensions/contents/templates/Makefile.build-harness-bootstrap -o .build-harness-bootstrap; echo .build-harness-bootstrap)
endif

helm:
	curl -fksSL https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz | sudo tar --strip-components=1 -xvz -C /usr/local/bin/ linux-amd64/helm

.PHONY: setup
setup: helm
	helm version

.PHONY: lint
lint: setup
	helm lint $(STABLE_CHART)
