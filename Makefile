all: bundler docs/build/openapi.yaml
	redoc-cli bundle docs/build/openapi.yaml -t ./docs/html/index.hbs -o docs/index.html \
    --options.item-types-instead-of-operations=true \
        --options.root-param-name-as-group-header=true \
        --options.hide-download-button=true \
        --options.hide-response-samples=true \
        --options.hide-path=true \
        --options.flatten-response-view=true \
        --options.crop-arm-prefixes=true \
        --options.code-samples-instead-of-request-samples=true \
        --options.theme.params.underlined-header.text-transform=none \
        --options.theme.typography.links.color=#695de4 \
    /

sp :=

sp += # add space

my-sort = $(shell echo $(subst $(sp),'\n',$2) | sort $1 --key=1,1 -)

define appendFilesWithTabs
	for file in $(call my-sort,,$(1)); do \
		while IFS= read -r line || [ -n "$$line" ]; do \
			echo "$(2)$$line"; \
		done < $$file; \
	done >> $3
endef

docs/build/tokend_openapi_generated.yaml: ./*.x
	bundle exec rake xdr:generate

docs/build/paths.yaml: ./docs/paths/*.yaml
	echo "paths:" > $@
	$(call appendFilesWithTabs, $^,""  "", $@)

docs/build/openapi.yaml: docs/index.yaml docs/build/paths.yaml docs/build/tokend_openapi_generated.yaml
	echo "#This file has been generated automatically. DO NOT MODIFY!" > $@
	for file in $^; do \
		while IFS= read -r line; do \
			echo "$$line"; \
		done < $$file; \
	done >> $@

clean:
	rm -rf docs/build/*

bundler:
	bundle install --path ./vendor
	bundle update xdrgen
