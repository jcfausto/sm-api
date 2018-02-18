# Secret Messages API

Entrypoint: https://ancient-shelf-11063.herokuapp.com/

## Services
- Store geolocated messages
- Query nearby messages, with optional custom search radius
- Query for the closest message to a certain position

# Model

#### Message

| Attribute  | Type 				 | Required | Constraint		 |
| -----------| --------------|----------|----------------|
| content | string | yes |max length = 300 characters
| latitude | float | yes |between -90 and 90 |
| longitude | float | yes | between -180 and 180 |

JSON Schema:
```
{
  "content": "your message here",
  "latitude": 54.456744,
  "longitude": 13.974647
}
```

# API Design
Overview below. For more details, check the
[API public documentation](https://documenter.getpostman.com/view/1104741/secret-messages-api/RVfyAp9d).

## Endpoints

| HTTP VERB  | URL 					 | Required query params		 | Optional query params | Functionality
| -----------| --------------|-------------------------- | --------------------- |------------ |
| POST 			 | /messages  	 | 				                   |                       |Creates a new message.   			  |
| GET  			 | /messages     | type, latitude, longitude | radius                |Fetch nearby messages.           |
| GET  			 | /messages     | type, latitude, longitude |                       |Fetch the nearest message.       |

#### Query params

| Param      | Valid values 				 | example		 
| -----------| ----------------------|------------------------------|
| type       | nearby, nearest       | /messages?type=nearby        |
| latitude   | Float number between -90 and 90 | /messages?type=nearby&latitude=52.54124 |
| longitude  | Float number between -180 and 180 | /messages?type=nearby&latitude=52.54124&longitude=13.400241 |

# How to run this API

### Requirements

- Rails 5
- PostgreSQL
  - with an user "postgres"

#### Optional (Case you want to run on Docker)
- Docker
- Docker Compose

#### Optional (Case you want to run the container on Heroku)
- Heroku CLI
- Heroku Container Tools

## Running locally

```
$ git clone [https://github.com/jcfausto/sm-api.git](https://github.com/jcfausto/sm-api.git)
$ bundle install
$ rake db:create
$ rake db:migrate
$ rails s
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
$ docker-compose run api rake db:create
$ docker-compose run api rake db:migrate
$ docker-compose up
```
#### Running the tests on Docker:
```
$ docker-compose run api rspec -fd
```
Note: Test coverage report available inside the ```./coverage``` folder after first run.

### Running on Heroku

Test first

```
$ docker-compose build
$ docker-compose run api rspec -fd
```
If its is all green, then proceed:

```
$ heroku login
$ heroku create
$ heroku addons:create heroku-postgresql:hobby-dev
$ heroku container:login
$ heroku config:set RAILS_ENV=production
$ heroku config:set SECRET_KEY_BASE=d5a18ce9dc18caab60995bad06c1b43e9cb62edf5f53f9878a5411b6f1176ee72c514a6e61378f09482a4643a218e08e0cfe9eff0ba76e50e5ac30632ba02e1e
$ heroku container:push web
$ heroku run rake db:migrate
```
If you want some data, please run:
```
$ heroku run rake db:seed
```
Check the ```db/seed.rb``` file to know with locations will be available for querying.

Example: Querying for ```type=nearest&latitude=52.54124&longitude=13.400241``` will present to you a secret message posted near this location.

# Source code documentation
You can generate source code documentation by running
```
$ rdoc
```
Once generated, the docs will be available at the ```/doc``` folder inside the project.
