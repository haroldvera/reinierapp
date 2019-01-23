
REBAR3 = ./rebar3
DEBUG = 1
release:
	rm -rf _build && ${REBAR3} as prod release

build-docker:
	docker build -t reinierapp .