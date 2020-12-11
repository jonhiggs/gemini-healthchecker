SHELL = /bin/bash
ENDPOINTS = etc/endpoints.json
ENDPOINT_IDS = $(shell jq -r .[].id "${ENDPOINTS}")

last_success: LATEST = $(shell redis-cli --raw MGET $(addprefix LS-,${ENDPOINT_IDS}) | sort -n | tail -n1)
last_test:    LATEST = $(shell redis-cli --raw MGET $(addprefix LT-,${ENDPOINT_IDS}) | sort -n | tail -n1)
last_test last_success: NOW = $(shell date +%s)
last_test last_success:
	@echo $$((${NOW}-${LATEST})) seconds ago

failing_checks:
	@redis-cli --raw MGET $(addprefix F-,${ENDPOINT_IDS}) | sed '/0/d' | wc -l

content/index.gmi: .FORCE
	echo -e "# healthcheck.shit.cx\n" > $@
	./bin/dump_status >> $@

.FORCE:
