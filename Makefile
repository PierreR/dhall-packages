openshift_dir = ./openshift
openshift_examples_dir := ./${openshift_dir}/examples
openshift_examples_files := application1.yaml cron1.yaml quota1.yaml
openshift_deps := $(openshift_dir)/func/*.dhall $(openshift_dir)/schemas/*.dhall

argo_examples_dir := ./argo/examples
argo_examples_files := argo1.yaml

precommit:
	pre-commit run --all-files

fmt:
	find . -name '*.dhall' -exec dhall format --inplace {} \;

lint:
	find . -name '*.dhall' -exec dhall lint --inplace {} \;

freeze:
	find . -name 'package.dhall' -exec dhall --ascii freeze --inplace {} --all \;

$(openshift_examples_dir)/%.yaml: $(openshift_examples_dir)/%.dhall $(openshift_deps)
	dhall-to-yaml --explain --file $< --omit-empty > $@

$(argo_examples_dir)/%.yaml: $(argo_examples_dir)/%.dhall
	dhall-to-yaml --explain --file $< --omit-empty > $@

argo-examples: $(argo_examples_files:%.yaml=${argo_examples_dir}/%.yaml)
openshift-examples: $(openshift_examples_files:%.yaml=${openshift_examples_dir}/%.yaml)

examples: argo-examples openshift-examples