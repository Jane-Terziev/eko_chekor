FROM ruby:2.7.1-alpine

RUN apk update && apk add bash build-base nodejs postgresql-dev tzdata

RUN mkdir /eko_chekor
WORKDIR /eko_chekor

COPY Gemfile Gemfile.lock ./

RUN gem install bundler --no-document

RUN bundle install

COPY . .

# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]