#! /usr/bin/bash

# to run this script:
# 1. chmod u+x deploy.sh
# 2 ./deploy.sh

# variables
BRANCH="$(git rev-parse --abbrev-ref HEAD)"

echo 'Enter command or press ENTER to perform deploy'
read var

if [ -z "${var}" ];
then
    # launch git pull
    git fetch
    git pull origin $BRANCH

    # lauch composer update
    php8.3 ~/.local/bin/composer update

    # update language files
    php8.3 /usr/local/bin/wp-cli.phar language core update
    php8.3 /usr/local/bin/wp-cli.phar language plugin update --all

    #replace WP_ENV variable to production
    sed -i -e "s/WP_ENV='development'/WP_ENV='production'/g" .env
    sed -i -e "s/WP_ENV='staging'/WP_ENV='production'/g" .env
    grep WP_ENV .env
fi