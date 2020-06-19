.PHONY: examples fmt lint precommit freeze

DIRS = openshift/examples # TODO we need to fix --omit-empty before including argo/examples

all: freeze examples

precommit:
	pre-commit run --all-files

fmt:
	find . -name '*.dhall' -exec dhall format --inplace {} \;

lint:
	fd -e dhall -x dhall lint --check --inplace;

%.yaml: %.dhall
	dhall-to-yaml --file $< > $@

examples: $(foreach dir, $(DIRS), $(patsubst %.dhall,%.yaml,$(wildcard $(dir)/*.dhall)))

freeze-oc:
	sed -i "s/\(OC=.*\) sha256:.*/\1 $(shell dhall hash <<< "./openshift/package.dhall")'/" shell.nix

freeze-argo:
	sed -i "s/\(ARGO=.*\) sha256:.*/\1 $(shell dhall hash <<< "./argo/package.dhall")'/" shell.nix

freeze: freeze-argo freeze-oc

clean:
	fd -e dhall -x touch