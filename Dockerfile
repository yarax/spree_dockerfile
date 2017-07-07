FROM ubuntu
RUN mkdir -p /app
WORKDIR /app
RUN apt-get update
RUN apt-get install -y ruby2.3
RUN apt-get install -y ruby-dev
RUN apt-get install libgmp-dev
RUN apt-get install -y gcc make zlib1g-dev sqlite3 libsqlite3-dev
RUN apt-get install -y rubygems
RUN apt-get install -y libxml2-dev libxslt1-dev
RUN apt-get install -y nodejs
RUN apt-get install -y bash
RUN apt-get install -y tzdata
RUN gem install pkg-config -v "~> 1.1.7"
RUN NOKOGIRI_USE_SYSTEM_LIBRARIES=1 gem install nokogiri -v "~> 1.8"
RUN gem install rails -v 4.2.6 -V
RUN gem install bundler
RUN gem install sqlite3
RUN apt-get install -y imagemagick
RUN rails _4.2.6_ new mystore
WORKDIR mystore
RUN echo "source 'https://rubygems.org'" >> Gemfile
RUN echo "gem 'spree', '~> 3.1.0'" >> Gemfile
RUN echo "gem 'spree_auth_devise', '~> 3.1'" >> Gemfile
RUN echo "gem 'spree_gateway', '~> 3.1'" >> Gemfile
RUN echo "gem 'tzinfo-data'" >> Gemfile
RUN echo "gem 'tzinfo'" >> Gemfile
RUN bundle update
RUN AUTO_ACCEPT=1 rails g spree:install --user_class=Spree::User
RUN rails g spree:auth:install
RUN rails g spree_gateway:install --auto_run_migrations=true
EXPOSE 3000
RUN echo "<script src='https://s3-eu-west-1.amazonaws.com/analytics-js-tracker/piwik_extended.js'></script>" >> /var/lib/gems/2.3.0/gems/spree_frontend-3.1.5/app/views/spree/layouts/spree_application.html.erb
CMD ["rails", "server", "-b", "0.0.0.0"]
