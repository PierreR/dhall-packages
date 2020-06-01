.PHONY: examples fmt lint precommit freeze

DIRS = openshift/examples # TODO we need to fix --omit-empty before including argo/examples

precommit:
	pre-commit run --all-files

fmt:
	find . -name '*.dhall' -exec dhall format --inplace {} \;

check-lint:
	fd -e dhall -x dhall lint --check --inplace;

freeze:
	dhall freeze --all --inplace ./**/examples/*.dhall;

%.yaml: %.dhall
	dhall lint --inplace $<
	dhall-to-yaml --file $< > $@


examples: $(foreach dir, $(DIRS), $(patsubst %.dhall,%.yaml,$(wildcard $(dir)/*.dhall)))