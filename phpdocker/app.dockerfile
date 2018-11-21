# Step 1/6: Get from repository
FROM phpdockerio/php72-fpm:latest

# Step 2/6: Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Step 3/6: Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install php7.2-dev php-pear php-memcached php7.2-mysql php-redis php7.2-bcmath php7.2-ldap php7.2-soap

# Step 4/6: Install git and other extensions
RUN apt-get update \
    && apt-get -y install git phpunit libz-dev vim curl nano unzip && docker-php-ext-install pdo_mysql \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
  
# Step 5/6: Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Step 6/6: Install Language pt-br
RUN apt-get update \
    && apt-get -y install language-pack-pt && dpkg-reconfigure locales -f pt_BR.UTF-8 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*