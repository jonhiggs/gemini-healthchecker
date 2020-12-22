SHELL := /bin/bash

.PHONY: test
test:
	test/test_inputs
	test/test_failing
	test/test_passing
