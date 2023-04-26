# Sweater Whether

Sweater Whether is an API designed for planning a road trip that gives users the opportunity to see what weather conditions might be like at their destination city through a front-end application. In order to use the API, users will have to create an account and login. Upon creation the user will be issued an API key for authentication. After authentication users can hit two endpoints to retrieve different info including weather data for a specific city, and road-trip planning information. 

<br>
<br>

Built With: 

![Ruby 3.1.1](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

## Table of Contents
1. [Project Main Points](#project-main-points)
1. [Learning Goals](#learning-goals)
1. [Setup and Installation](#setup-and-installation)
   * [Dependencies](#dependencies)
   * [API Keys](#api-keys)
   * [Cloning the Repo](#cloning-the-repo)
   * [Database Setup](#database-setup)
   * [Running the Application Using Postman](#running-the-application-using-postman)
1. [Endpoints](#endpoints)
   * [Weather Forecast](#weather-forecast)
   * [User Registration](#user-registration)
   * [User Login](#user-login)
   * [Road Trip](#road-trip)
1. [Testing](#testing)

## Project Main Points

1. Retrieve Weather for a City
    - API's consumed: `Weather API` and `MapQuest Geocoding API`
    - MapQuest Geocoding API retrieved lat & long for a city.
    - Weather API uses lat & long to return weather data.
    
2. User Registration and Sessions
    - A POST endpoint is exposed to allow the creation of a user.
    - A response is returned with the new user's email and API key.
    - If a user exists, the user can be authenticated and the API key will be returned upon login.
    
3. Planning a Road Trip
    - A POST endpoint is exposed for road trip planning.
    - Travel time in (HH:MM:SS) is returned, an ETA and weather is returned for the destination city as well. 
    - Authentication is required in order to receive a response.
    
## Learning Goals

1. Expose an API that aggregates data from multiple external APIs
2. Expose an API that requires an authentication token
3. Expose an API for CRUD functionality
4. Determine completion criteria based on the needs of other developers
5. Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

## Setup and Installation

### Dependencies

This app depends on several Ruby gems for functionality and development.

**Main Dependencies**
 - **Ruby 3.1.1**
 - **Rails 7.0.4**
 - **PostgreSQL**
 
### API Keys
 
 API keys can be retrieved by registering through the following links below:
 <br>
 - [Weather API](https://www.weatherapi.com/)
 - [Mapquest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)
 
### Cloning the Repo
 
 Follow these steps to clone the repo to your local machine:
 
 1. Open terminal.
 2. Navigate to directory where you'd like to store the repo: ```cd ~/directory```
 3. Clone repo to machine with the following command: ```https://github.com/your_github_name/github_repo_name.git```
 4. Change into the newly created directory: ```cd github_repo_name```
 5. Install the required Ruby gems ```bundle install ```

### Database Setup 
Setup the database by running the following command: 
``` 
rails db:create
rails db:migrate
```

### Running the Application using Postman 
1. Install Postman on your machine. You can download it from the [official website](https://www.postman.com/).
1. Ensure your Rails server is running. If it's not, start it by running:
```rails s```
1. Open Postman and create a new workspace to store the collection.
1. Click the + in the upper middle part of the screen to send a new request.
1. Set the request method (GET, POST) in the dropdown menu next to the address bar.
1. Enter the API endpoint URL in the address bar, replacing localhost:3000 with your application's address and port (if different) and adding the appropriate API endpoint. For example:
```http://localhost:3000/api/v1/endpoint```
1. If needed, change request headers by clicking on the "Headers" tab below the address bar. For example, you might need to set the Content-Type header to application/json.
1. For POST and PUT requests, you'll need to provide a JSON payload. Click on the "Body" tab below the headers and select the "raw" button. Make sure the dropdown menu to the right is set to "JSON". Enter your JSON payload in the text box that appears. For example:
```
{
  "required_field": "info",
  "required_field": "info"
}
```
1. Click the "Send" button to send the request to the server. The server's response will appear in the lower section of the window.
1. Review the response's status code, headers, and body to ensure the request was processed as expected (See below section on (#endpoints).
1. To save the request for future use, click on the "Save" button in the top right corner of the window. You can organize your requests into collections for easier management.

## Endpoints

This project provides four primary endpoints: 

 ### Weather Forecast
 
 You can make the following request
 
``` 
GET /api/v0/forecast?location=denver,co
Content-Type: application/json
Accept: application/json 
```
The API call will return a JSON API 1.0 Compliant response, such as: 

```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "last_updated": "04-25-2023 07:45 PM",
                "temperature": 40.5,
                "feels_like": 33.7,
                "humidity": 99,
                "uvi": 2.0,
                "visibility": 6.0,
                "condition": "Light rain",
                "icon": "//cdn.weatherapi.com/weather/64x64/night/296.png"
            },
            "daily_weather": [
                {
                    "date": "2023-04-25",
                    "sunrise": "06:08 AM",
                    "sunset": "07:48 PM",
                    "max_temp": 63.7,
                    "min_temp": 42.1,
                    "condition": "Moderate rain",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/302.png"
                }
                ],
            "hourly_weather": [
                [
                    {
                        "time": "04-25-2023 12:00 AM",
                        "temperature": 49.8,
                        "conditions": "Partly cloudy",
                        "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
                    },
                    {
                        "time": "04-25-2023 01:00 AM",
                        "temperature": 50.2,
                        "conditions": "Cloudy",
                        "icon": "//cdn.weatherapi.com/weather/64x64/night/119.png"
                    },
```
  ### User Registration
  
 This endpoint will permit you to make a user and add them to the PostgreSQL database. 
 
 You can make the following request
 
``` 
POST /api/v0/users
Content-Type: application/json
Accept: application/json

{
         "email": "notrealemail@notrealemail.com",
         "password": "baloney1",
         "password_confirmation": "baloney1"
}
```

being passed as a payload in the body. 

The API will return the following: 

```
{
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "notrealemail@notrealemail.com",
            "api_key": "som3a550rtm3nt0fnum83rs@ndl3tt3r5"
        }
    }
}
```
A Random API Key is generated upon successful registration. (No empty fields, or duplicate emails.)

### User Login

 You can make the following request
 
``` 
POST /api/v0/sessions
Content-Type: application/json
Accept: application/json

{
         "email": "notrealemail@notrealemail.com",
         "password": "baloney1"
}
```
being passed as a payload in the body. 

The API will return the following if all credentials are valid: 

```
{
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "notrealemail@notrealemail.com",
            "api_key": "som3a550rtm3nt0fnum83rs@ndl3tt3r5"
        }
    }
}
```


### Road Trip

This endpoint allows users to input an origin and destination point. It will calculate drive time and return the weather in the destination city at the ETA. Rounded up to the next hour.

You can make the following request: 
 
```
POST /api/v0/road_trip
Content-Type: application/json
Accept: application/json

body:

{ 
    "origin": "Los Angeles,CA",
    "destination": "New York,NY",
    "api_key": "som3a550rtm3nt0fnum83rs@ndl3tt3r5"
}
```

- Replace the origin and destination with the locations of your choosing.
- Use the real API key of a user.

If it's possible to drive between the two locations and the arrival time is within 5 days of midnight of the current day you will get output like this: 

```
{
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "start_city": "Los Angeles, CA",
            "end_city": "New York, NY",
            "travel_time": "40:18:09",
            "weather_at_eta": {
                "datetime": "04-27-2023 01:00 PM",
                "temperature": 64.6,
                "condition": "Sunny"
            }
        }
    }
}
```

If the route is impossible to drive the return will look like this:

```
{
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "London,UK",
            "travel_time": "impossible",
            "weather_at_eta": {}
        }
    }
}
```

## Testing 

The API is thoroughly tested using RSpec, ensuring that all features, edge cases, and sad paths are covered. To run the test suite, follow these steps:
1. Make sure you have RSpec installed. If not, you can install it by running the following command:
```gem install rspec```
2. Navigate to the root directory of the project: 
```cd path/to/sweater_weather```
3. Run the test suite with the following command:
```bundle exec rspec```
This will execute all the tests, and you'll be able to see the results in your terminal.
