FROM ruby:2.6.6

# Env vars
ENV BUNDLE_VERSION 1.17.3
ENV APP_PATH /usr/src/yala-notlob
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000

# Credentials args
ARG facebook_id
ARG facebook_secret
ARG google_id
ARG google_secret

# Installing dependencies for application
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg \ 
    && apt-key add /root/yarn-pubkey.gpg

RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn \ 
    && apt-get install -y sqlite3 libsqlite3-dev

WORKDIR $APP_PATH 

COPY . .

# Creating application.yml file
RUN echo "development: \n" \
         "    FACEBOOK_APP_ID: \"$facebook_id\"\n" \
         "    FACEBOOK_APP_SECRET: \"$facebook_secret\"\n" \
         "    GMAIL_APP_ID: \"$google_id\"\n" \
         "    GMAIL_APP_SECRET: \"$google_secret\"\n" > config/application.yml

RUN gem install bundler --version "$BUNDLE_VERSION" \ 
    && bundle install \
    && yarn install

EXPOSE $RAILS_PORT

ENTRYPOINT [ "bundle", "exec" ]