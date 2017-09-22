FROM ruby:2.3-alpine

RUN mkdir /gem
WORKDIR /gem

RUN apk update
RUN apk add git build-base
RUN gem install bundler

COPY Gemfile idnow-client.gemspec /gem/
RUN bundle install

COPY . /gem/
