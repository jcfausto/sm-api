# Secret Messages API

[WIP]

## Features
- Store geolocated messages
- Fetch all messages within a radius around a certain position. Maximum radius is 100Km.
- Fetch the closest message to a certain position

### Notes
- Message's content lenght is limited to 300 characters

# Model

#### Message

| Attribute  | Type 				 | Required | Constraint		 |
| -----------| --------------|----------|----------------|
| content | string | yes |max length = 300 characters
| latitude | float | yes |between -90 and 90 |
| longitude | float | yes | between -180 and 180 |

# API Design

## Endpoints

| HTTP VERB  | URL 					 | Required query params		 | Optional query params | Functionality
| -----------| --------------|-------------------------- | --------------------- |------------ |
| POST 			 | /messages  	 | 				                   |                       |Creates a new message.   			  |
| GET  			 | /messages     | type, latitude, longitude | radius                |Fetch nearby messages.           |
| GET  			 | /messages     | type, latitude, longitude |                       |Fetch the nearest message.       |

#### Query params

| Param      | Valid values 				 | example		 |
| -----------| ----------------------|----------|----------------|
| type       | nearby, nearest       | /messages?type=nearby |
| latitude   | Float number between -90 and 90 | /messages?type=nearby&latitude=52.54124 |
| longitude  | Float number between -180 and 180 | /messages?type=nearby&latitude=52.54124&longitude=13.400241 |

For more details, please consult the API documentation here: [Link]

# How to run this API

#### Stack
- Rails 5
- PostgreSQL

#### Optional (Case you want to run on Docker)
- Docker
- Docker Compose

#### Optional (Case you want to run the container on Heroku)
- Heroku CLI
- Heroku Container Tools

## Running locally

```
$ git clone [link to repo]
$ bundle install
$ rake db:create
$ rake db:migrate
```
#### Run the tests:
```
$ rspec -fd
```
Note: Test coverage report available inside the ```./coverage``` folder after first run.

## Running on Docker
```
$ git clone [link to repo]
$ docker-compose build
$ docker-compose up
```
#### Run the tests:
```
$ docker-compose run api rspec -fd
```
Note: Test coverage report available inside the ```./coverage``` folder after first run.

### Running on Heroku
```
$ heroku login
$ heroku create
$ heroku addons:create heroku-postgresql:hobby-dev
$ docker-compose build
$ docker-compose run api rspec -fd
$ heroku container:login
$ heroku config:set RAILS_ENV=production
$ heroku container:push web
$ heroku run rake db:migrate
```
