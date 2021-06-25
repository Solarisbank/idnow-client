FROM ruby:2.5

RUN mkdir /gem
WORKDIR /gem

COPY Gemfile idnow-client.gemspec /gem/
RUN bundle install

COPY . /gem/
