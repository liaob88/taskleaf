FROM ruby:2.6.0
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update -qq \
    && apt-get install -y postgresql-client nodejs npm
RUN mkdir /taskleaf
WORKDIR /taskleaf
COPY Gemfile /taskleaf/Gemfile
COPY Gemfile.lock /taskleaf/Gemfile.lock
RUN bundle install \
    && npm uninstall yarn -g && npm install yarn -g -y
COPY . /taskleaf
RUN yarn install --check-files

CMD ["rails", "server", "-b", "0.0.0.0"]