# Weatai_API
This API is to get instant weather information from [Central Weater Bureau Open Data](http://opendata.cwb.gov.tw/about) and [Environmental Protection Association Open Data](http://opendata.epa.gov.tw/). We've deployed on heroku and you can check it [Here](https://weataiapi.herokuapp.com/).

## Routes

- `/` - check if API alive
- `/v0.1/weather` - show all the instant weather and air quality information 
- `/v0.1/weather/[:station_id]` - show a station's instant weather and air quality information(1 to 38)
  - for examples:[station_id=3](https://weataiapi.herokuapp.com/api/v0.1/weather/3)
    - {"station":"3","stationName":"板橋","city":"新北市","township":"板橋區","temperature":"20.0","humidity":"0.72","MIN_10":"0.00","rainfall":"0.00","AirQuality":"21","Status":"良好","time":"2017-01-08T16:30:00+08:00"}


## Built With

* [Sinatra](https://github.com/sinatra/sinatra) - The web framework used
* [Heroku](https://www.heroku.com/) - Cloud Application Platform


## Authors

* **[Neil,Lee](https://github.com/Neilxx)**
* **[Andy,Chen](https://github.com/youyotsu)**
* **[Chien,Hung](https://github.com/chiachienhung)**
