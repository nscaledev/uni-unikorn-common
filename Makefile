.PHONY: test
test:
	helm lint --strict charts/unikorn-common
	helm template charts/unikorn-common > /dev/null
