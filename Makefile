fmt:
	find . -name '*.dhall' -exec dhall format --inplace {} \;

lint:
	find . -name '*.dhall' -exec dhall lint --inplace {} \;

freeze:
	find . -name 'package.dhall' -exec dhall --ascii freeze --inplace {} --all \;
