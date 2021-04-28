FROM ruby:2.6.6

# env vars
ENV BUNDLE_VERSION 1.17.3
ENV APP_PATH /usr/src/yala-notlob
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000

# credentials args
# ARG facebook_id
# ARG facebook_secret
# ARG google_id
# ARG google_secret

# install dependencies for application
RUN apt-get update -qq \ 
    && apt-get install -y build-essential libpq-dev nodejs \
    && apt-get install -y sqlite3 libsqlite3-dev

RUN yes | apt install npm \ 
    && npm i npm@latest -g

RUN npm install --global yarn

WORKDIR $APP_PATH 

COPY . .

# creating application.yml file
# RUN echo "development: \n" \
#          "    FACEBOOK_APP_ID: \"$facebook_id\"\n" \
#          "    FACEBOOK_APP_SECRET: \"$facebook_secret\"\n" \
#          "    GMAIL_APP_ID: \"$google_id\"\n" \
#          "    GMAIL_APP_SECRET: \"$google_secret\"\n" > config/application.yml

RUN gem install bundler --version "$BUNDLE_VERSION" \ 
    && bundle install \
    && yarn add bootstrap@4.3.1 jquery popper.js \
    && yarn add bootstrap-icons \
    && npm i  

EXPOSE $RAILS_PORT

ENTRYPOINT [ "bundle", "exec" ]