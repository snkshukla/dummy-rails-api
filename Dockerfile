FROM ruby:2.7.0

WORKDIR /app
ADD . ./

RUN gem install bundler
RUN bundle install

RUN bin/rails db:create
RUN bin/rails db:migrate
RUN bin/rails db:seed

EXPOSE 3000

CMD ["bin/rails", "server"]
