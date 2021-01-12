# ShopAPI

A simple application made with Rails 6.1.0 + PostgresSQL + Webpack => VueJS

Installation
-------------
1. Clone this repository
2. Install the dependencies by running these commands:
```bash
$ bundle install # to install ruby dependencies
$ yarn install # (npm i) to install js dependencies 
```
3. Duplicate your `.env.sample` file and rename it to `.env`
4. Fill up the desired database_uri or database credentials
5. Run `$ bundle exec rake db:create` to create database
6. Run `$ bundle exec rake db:seed` to seed the csv file provided
7. Start the application by following these commands:
```bash
$ rails s # Backend w/ initial compilation of front end
$ bin/webpack && bin/webpack-dev-server # Front End (enable recompilation while editing vue)
```

API Endpoints
-------------
These are the available API Endpoints for the application to retrieve some information from DB
- `api/v1/get_apns/` - returns all apn_code available
- `/transactions/:apn_code` - returns Array of datasets needed for chartjs
- `/annual-transactions/:apn_code` - returns an Object needed for chartjs


<!--  Breakdown of requirements from warwick's email
Here is a sales history file for a shop. 
1. I want you to create and load this into an SQL database, 
2. create an API and an interface that will give the shop owner a monthly view of ex tax sales and gross profit this year vs last year. 
3. Shop owners want to be able to easily see if they have improved or not compared to the same month in the previous year. -->
