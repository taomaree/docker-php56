all: build

init:
	wget -c https://getcomposer.org/installer
	php ./installer
build:
	@docker build --tag=taomaree/php56 .
	
release: build
	@docker build --tag=taomaree/php56:$(shell cat VERSION) .

debug: build
	@docker run -ti --rm taomaree/php56 /bin/bash

run: build
	@docker run -d taomaree/php56

