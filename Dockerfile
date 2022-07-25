FROM ruby:2.7

RUN mkdir /gem
WORKDIR /gem

COPY Gemfile *.lock idnow.gemspec /gem/
RUN bundle install

COPY . /gem/
