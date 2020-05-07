precommit:
	pre-commit run --all-files

fmt:
	find . -name '*.dhall' -exec dhall format --inplace {} \;

lint:
	find . -name '*.dhall' -exec dhall lint --inplace {} \;

freeze:
	find . -name 'package.dhall' -exec dhall --ascii freeze --inplace {} --all \;

examples:
	find . \( -type f -and -path '*/examples/*.dhall' \) -exec sh -c 'x="{}"; dhall-to-yaml --explain --file $$x --omit-empty > $${x/.dhall/.yaml}' \;
