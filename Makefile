examples_dir := ./openshift/examples
examples_files := application1.yaml cron1.yaml quota1.yaml

precommit:
	pre-commit run --all-files

fmt:
	find . -name '*.dhall' -exec dhall format --inplace {} \;

lint:
	find . -name '*.dhall' -exec dhall lint --inplace {} \;

freeze:
	find . -name 'package.dhall' -exec dhall --ascii freeze --inplace {} --all \;

$(examples_dir)/%.yaml: $(examples_dir)/%.dhall
	dhall-to-yaml --explain --file $< --omit-empty > $@

examples: $(examples_files:%.yaml=${examples_dir}/%.yaml)
