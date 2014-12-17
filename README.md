# Autobots

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## Ruby version

* Ruby 1.9.3

## System dependencies

* Postgres 

## Configuration

## Database creation

* Create a role for application user

```shell
psql template1
-#CREATE USER autobots;
-#ALTER USER autobots CREATEDB;
```

[http://www.cyberciti.biz/faq/howto-add-postgresql-user-account/]

* Create databases

```shell
rake db:create
```

## Database initialization

* Initialize database

```Shell
rake db:migrate
```

## Asset building

* Download bower packages (Read from Bowerfile)
```
rake bower:install
```

## How to run the test suite

## Services (job queues, cache servers, search engines, etc.)

## Deployment instructions

The steps are same for setting up. However, some tweaks must be applied.

## ...

