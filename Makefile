.PHONY: examples fmt lint precommit freeze

DIRS = openshift/examples # TODO we need to fix --omit-empty before including argo/examples

precommit:
	pre-commit run --all-files

fmt:
	find . -name '*.dhall' -exec dhall format --inplace {} \;

lint:
	find . -name '*.dhall' -exec dhall lint --inplace {} \;

freeze:
	dhall freeze --all --inplace ./**/examples/*.dhall;

%.yaml: %.dhall
	dhall-to-yaml --file $< > $@


examples: $(foreach dir, $(DIRS), $(patsubst %.dhall,%.yaml,$(wildcard $(dir)/*.dhall)))