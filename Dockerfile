FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /photoblog
WORKDIR /photoblog
ADD Gemfile /photoblog/Gemfile
ADD Gemfile.lock /photoblog/Gemfile.lock
RUN bundle install
RUN apt-get install -y imagemagick
ADD . /photoblog
