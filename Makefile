SHELL = /bin/bash
ENDPOINTS = etc/targets.json
ENDPOINT_IDS = $(shell jq -r .[].id "${ENDPOINTS}")

last_success: LATEST = $(shell redis-cli --raw MGET $(addprefix LS-,${ENDPOINT_IDS}) | sort -n | tail -n1)
last_test:    LATEST = $(shell redis-cli --raw MGET $(addprefix LT-,${ENDPOINT_IDS}) | sort -n | tail -n1)
last_test last_success: NOW = $(shell date +%s)
last_test last_success:
	@echo $$((${NOW}-${LATEST})) seconds ago

failing_checks:
	@redis-cli --raw MGET $(addprefix F-,${ENDPOINT_IDS}) | sed '/0/d' | wc -l

content:
	@mkdir -p $@

content/index.gmi: DATE = $(shell date -u --iso-8601=seconds | sed 's/\+.*//g')
content/index.gmi: .FORCE | content
	@echo -e "# healthcheck.shit.cx\n" > $@
	@echo -e "This page shows the health of all targets checked. If you would like your Gemini Capsule to be monitored too, send a request to jon@shit.cx.\n" >> $@
	@echo '```' >> $@
	@./bin/dump_status >> $@
	@echo '```' >> $@
	@echo -e '\n=> https://git.sr.ht/~jonhiggs/gemini-healthchecker/ The source to run your own gemini-healthchecker can be found at https://git.sr.ht/~jonhiggs/gemini-healthchecker/.' >> $@
	@echo -e '\nThis page was last updated at ${DATE}.' >> $@


.FORCE:
