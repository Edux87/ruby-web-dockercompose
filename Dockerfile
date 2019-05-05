FROM ruby:2.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev sqlite3 nodejs
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
RUN bundle install
COPY . /app
