.PHONY: test
test:
	helm lint --strict charts/unikorn-common
	helm template charts/unikorn-common > /dev/null
	tmp=$$(mktemp -d); \
	cp -R testdata/otlp-env $$tmp/otlp-env; \
	perl -0pi -e 's#file://../../charts/unikorn-common#file://$(CURDIR)/charts/unikorn-common#' $$tmp/otlp-env/Chart.yaml; \
	helm dependency update $$tmp/otlp-env; \
	helm template $$tmp/otlp-env | grep -q 'name: OTEL_RESOURCE_ATTRIBUTES'; \
	helm template $$tmp/otlp-env | grep -q 'deployment.environment=dev,service.version=test'
