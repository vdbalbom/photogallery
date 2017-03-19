FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /typeinstant-sergio
WORKDIR /typeinstant-sergio
ADD Gemfile /typeinstant-sergio/Gemfile
ADD Gemfile.lock /typeinstant-sergio/Gemfile.lock
RUN bundle install
RUN apt-get install -y imagemagick
ADD . /typeinstant-sergio
