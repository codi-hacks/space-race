NAME:=$$(basename "$$PWD")

build:
	docker build -t ${NAME} .

build-quiet:
	docker build --quiet -t ${NAME} .

test: build-quiet
	docker run --rm $(NAME) sh -c "luacheck ." && \
	docker run --rm $(NAME) sh -c "busted --lua=luajit ."

test-lint: build-quiet
	docker run --rm $(NAME) sh -c "luacheck ."

test-unit: build-quiet
	docker run --rm $(NAME) sh -c "busted --lua=luajit ."
