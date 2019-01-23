FROM erlang:20

COPY . /usr/app

WORKDIR /usr/app


RUN make release

ENV WEB_PORT 3434
ENV RELX_REPLACE_OS_VARS true

CMD ["./_build/prod/rel/reinierapp/bin/reinierapp", "foreground"]