# RA Challenge

## This project is a resolution for RA Challenge

### Project Dependencies:

* Ruby version
```
  2.6.0
```

* Rails version
```
  5.2.3
```

* Database
```
  MongoDB
```

### Run Instructions
* Clone this project
* Install MongoDB on your machine

Then run:
```
  rails s
```
This will start your application.

## Test suit
### This projects uses RSpec to run tests. To execute all tests simply type:
```
  bundle exec rspec
```
# Deployment Instructions
With the heroku-cli instaled type:
```
  heroku create app-name-example
```
Check if you heroku repository is already added:
```
  git remote -v
```
Install MongoDB addon in your heroku project:
```
  heroku addons:create mongolab:sandbox
```
Ensure that you have MONGODB_URI in your project
(You should see something like: MONGODB_URI: <KEY_HERE>)
```
  heroku config
```
Create a new commit

And finally deploy to heroku
```
  git push heroku master
```

The application will be running and the endpoints can be accessed.
# API Docs

## API Version: V1

### Available endpoints:
* GET /complains
* GET /complains/:id
* POST /complains
* GET /complains/search
* GET /complains/coodinates
* GET /complains/:id/localization


## GET /complains
This endpoint will return all created complains with the total complains count.

Request
```
 GET https://reclameaqui.com.br/api/v1/complains
```

Response:
```
  {
    "total": 18,
    "complains": [
        {
            "_id": {
                "$oid": "5d07a6d97405db04806f802a"
            },
            "company": "Carros",
            "coordinates": [
                -34.882028,
                -7.1215981
            ],
            "created_at": "2019-06-17T14:42:33.794Z",
            "description": "Descrição Reclamação",
            "locale": "João Pessoa, PB",
            "name": "Fefe",
            "title": "Titulo Reclamação",
            "updated_at": "2019-06-17T14:42:33.794Z"
        },
  ...
```
* Returns 200 when successful.

## GET /complains/:id
This endpoint will return a single created complain

Request
```
 GET https://reclameaqui.com.br/api/v1/complains/5d06b3d57405db6081e5a040
```

Response:
```
{
  "_id": {
      "$oid": "5d06b3d57405db6081e5a040"
  },
  "company": "Embra",
  "coordinates": [
      -34.882028,
      -7.1215981
  ],
  "created_at": "2019-06-16T21:25:41.680Z",
  "description": "Descrição Reclamação",
  "locale": "João Pessoa, PB",
  "name": "Mateus",
  "title": "Titulo Reclamação",
  "updated_at": "2019-06-16T21:25:41.680Z"
}
```
* Returns 200 when successful.
* Returns 404 when complain does not exists.

## POST /complains
This endpoint allows to create a new complain

Request
```
 POST https://reclameaqui.com.br/api/v1/complains/
```
Data Params
```
{
	"complain":{
		"name":"Nome da Pessoa",
		"title":"Titulo Reclamaçãossss",
		"description":"Descrição Reclamação",
		"locale":"Cidade",
		"company":"42"
	}
}
```

Required Fields:
```
  title,
  description,
  locale,
  company
```

Response:
```
{
  "_id": {
      "$oid": "5d06b3d57405db6081e5a040"
  },
  "company": "Embra",
  "coordinates": [
      -34.882028,
      -7.1215981
  ],
  "created_at": "2019-06-16T21:25:41.680Z",
  "description": "Descrição Reclamação",
  "locale": "João Pessoa, PB",
  "name": "Mateus",
  "title": "Titulo Reclamação",
  "updated_at": "2019-06-16T21:25:41.680Z"
}
```
* Returns 201 when create new complain
* Return 400 when could not create complain

## GET /complains/search
This endpoint allows to search by companies, locales or companies and locales. It will return all complains that match with params and the quantity of this complains.

Request
```
 GET https://reclameaqui.com.br/api/v1/complains/search?company=on&locale=Pessoa
```

Query Params:
```
  company=example
  locale=example
```

Response:
```
{
  "quantity": 1,
  "complains": [
      {
          "_id": {
              "$oid": "5d06b3c77405db6081e5a03d"
          },
          "company": "Company",
          "coordinates": [
              -34.882028,
              -7.1215981
          ],
          "created_at": "2019-06-16T21:25:27.626Z",
          "description": "Descrição Reclamação",
          "locale": "João Pessoa, PB",
          "name": "Amteus",
          "title": "Titulo Reclamação",
          "updated_at": "2019-06-16T21:25:27.626Z"
      }
  ]
}
```
* Returns 200 when successful.
* Returns 200 with empty array when not found any complain

## GET /complains/coordinates
This endpoint allows to search a localization by coordinates(latitude, longitude). It will return information about that specific localization.

Request
```
 GET https://reclameaqui.com.br/api/v1/complains/coordinates?lat=-7.1215981&lon=-34.882028
```

Query Params:
```
  lat=-7.1215981
  lon=-34.882028
```

Response:
```
[
  {
      "data": {
          "place_id": 134592431,
          "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
          "osm_type": "way",
          "osm_id": 245982671,
          "lat": "-7.12156899917987",
          "lon": "-34.8815852692268",
          "display_name": "Rua Diogo Velho, Centro, João Pessoa, Microrregião de João Pessoa, Região Metropolitana de João Pessoa, Mesorregião da Mata Paraibana, Paraíba, Northeast Region, 58013-131, Brazil",
          "address": {
              "road": "Rua Diogo Velho",
              "suburb": "Centro",
              "city_district": "João Pessoa",
              "city": "João Pessoa",
              "county": "Microrregião de João Pessoa",
              "state_district": "Mesorregião da Mata Paraibana",
              "state": "Paraíba",
              "postcode": "58013-131",
              "country": "Brazil",
              "country_code": "br"
          },
          "boundingbox": [
              "-7.1223566",
              "-7.1212673",
              "-34.8816051",
              "-34.8815335"
          ]
      },
      "cache_hit": null
  }
]
```
* Returns 200 when successful.
* Returns 200 with empty array when not found any localization

## GET /complains/:id/localization
This endpoint allows to search a localization of a specific complaun. It will return information about that specific localization complain.

Request
```
 GET https://reclameaqui.com.br/api/v1/complains/5d0707f07405db7355d4cb14/localization
```

Query Params:
```
  id=5d0707f07405db7355d4cb14
```

Response:
```
[
  {
      "data": {
          "place_id": 15792714,
          "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
          "osm_type": "way",
          "osm_id": 282468073,
          "lat": "-19.9235832",
          "lon": "-43.9447845",
          "display_name": "1187, Avenida Bias Fortes, Lourdes, Regional Centro-Sul, Belo Horizonte, Microrregião Belo Horizonte, Região Metropolitana de Belo Horizonte, Mesorregião Metropolitana de Belo Horizonte, Minas Gerais, Southeast Region, 30170-121, Brazil",
          "address": {
              "house_number": "1187",
              "road": "Avenida Bias Fortes",
              "suburb": "Lourdes",
              "city_district": "Regional Centro-Sul",
              "city": "Belo Horizonte",
              "county": "Microrregião Belo Horizonte",
              "state_district": "Mesorregião Metropolitana de Belo Horizonte",
              "state": "Minas Gerais",
              "postcode": "30170-121",
              "country": "Brazil",
              "country_code": "br"
          },
          "boundingbox": [
              "-19.9236832",
              "-19.9234832",
              "-43.9448845",
              "-43.9446845"
          ]
      },
      "cache_hit": null
  }
]
```
* Returns 200 when successful.
* Returns 404 not found a complain with given id.


=)