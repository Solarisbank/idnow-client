FROM ruby:2.2.3

RUN mkdir /gem \
    && mkdir /var/bundle

COPY Gemfile /gem/
COPY idnow-client.gemspec /gem/
WORKDIR /gem

RUN bundle install --path /var/bundle
ADD . /gem

ENTRYPOINT ["bundle", "exec"]
