FROM bitwalker/alpine-elixir-phoenix:latest

# Environment
ARG MIX_ENV
ENV MIX_ENV ${MIX_ENV:-prod}
ARG DB_PASSWORD
ENV DB_PASSWORD ${DB_PASSWORD:-nopassword}

# Ports
EXPOSE 4000
ENV PORT=4000

# Elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Node deps
ADD package.json package.json
RUN npm install

ADD . .

# Compile
RUN brunch build --production && \
    mix do compile, phoenix.digest

CMD ["mix", "phoenix.server"]
