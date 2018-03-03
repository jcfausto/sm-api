FROM ruby:2.5
MAINTAINER hello@jcfausto.com

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN mkdir -p /api
WORKDIR /api

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

# This is ignored by Heroku. The app must listen on $PORT
EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

CMD passenger start -p $PORT --max-pool-size 3
