FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /photogallery
WORKDIR /photogallery
ADD Gemfile /photogallery/Gemfile
ADD Gemfile.lock /photogallery/Gemfile.lock
RUN bundle install
RUN apt-get install -y imagemagick
ADD . /photogallery
