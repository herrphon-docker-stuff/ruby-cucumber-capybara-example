FROM ruby

# update/upgrade and install needed dependencies for phantomjs
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
        build-essential \
        chrpath \
        libssl-dev \
        libxft-dev \
 && apt-get install -y \
        libfreetype6 libfreetype6-dev \
        libfontconfig1 libfontconfig1-dev

# install phantomjs
ADD https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 /tmp
RUN cd /tmp && tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 --strip 1 
RUN cp /tmp/bin/phantomjs /usr/local/bin/phantomjs 
RUN rm -rf /tmp/*

# do a bundle install of the basic stuff
RUN mkdir /code
ADD code/Gemfile       /code
ADD code/Gemfile.lock  /code
RUN cd /code && bundle install

CMD ["bundle", "exec", "cucumber"]

