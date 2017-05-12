timezone-api
============

## API for looking up time zone information given zip code

## Installation Instructions

Requires Ruby 2.2.6 and Rails 5.  To install, clone the project and run `rails server` to start the API server with the development environment.  For your convenience, the development database has been checked in that contains zip code data.

In production and staging, you will need to create a database and import zip code data.  To do this, download the [zipcode.csv file](https://boutell.com/zipcodes/zipcode.zip) at [boutell.com](https://boutell.com/zipcodes/), place the csv in the temp directory and run `rake zipcodes:import` for the environment you want to setup.

## API Usage

To use the API, send a post request to `/zipcodes/find` with the following JSON body:

```javascript
  { zipcode: 'zip code value' }
```

Given a successful request, this method should return an object named "data" containing the time zone name according to ActiveSupport and information regarding the zip code:

```javascript
  {
    tz_name: 'time zone name according to ActiveSupport (string)',
    zipcode: {
      city: 'City name for zip code (string)'
      dst: 'Does zip code observe daylight savings time (boolean)'
      lat: 'WGS84 DD Latitude for zip code (decimal)',
      lng: 'WGS84 DD Longitude for zip code (decimal)',
      state: 'State abbreviation for zip code (string)',
      utc_offset: 'UTC offset for zip code (integer)',
      zipcode: 'Zip code (integer)'
    }
  }
```
