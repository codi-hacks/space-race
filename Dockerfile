FROM abaez/luarocks:lua5.1
ARG COVERALLS_TOKEN
ENV COVERALLS_TOKEN=$COVERALLS_TOKEN

## Install additional system packages
RUN apk update && \
    apk upgrade && \
    # run the same lua interpreter as LOVE
    apk add luajit \
    # pip/python deps for luacov
    libffi-dev \
    python3-dev
RUN rm -rf /var/cache/apk/*

## Build pip and cpp-coveralls
RUN curl -O https://bootstrap.pypa.io/pip/3.6/get-pip.py
RUN python3 get-pip.py
RUN python3 -m pip install cpp-coveralls

## Luarocks
RUN luarocks install busted 2.0.rc13-0
RUN luarocks install luacheck
RUN luarocks install luacov
RUN luarocks install luacov-coveralls

## App setup
RUN mkdir /usr/app
WORKDIR /usr/app
COPY . /usr/app

## Run tests
CMD ["sh", "-c", "busted --lua=luajit . && luacov-coveralls -t ${COVERALLS_TOKEN} -e usr/ -e lib/ -e .spec.lua"]
