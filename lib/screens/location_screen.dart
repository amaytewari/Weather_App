import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temperature;
  int condition;
  String city;
  WeatherModel weatherModel = WeatherModel();

  void UIupdate(dynamic locationWeather1) {
    setState(() {
      if(locationWeather1 == null)
      {
        temperature = 888;
        condition = 0;
        city = 'Not a Valid City';
        return;
      }
      temperature = locationWeather1['main']['temp'];
      condition = locationWeather1['weather'][0]['id']; 
      city = locationWeather1['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    UIupdate(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var buttonWeatherData =
                          await weatherModel.weatherLocation();
                      UIupdate(buttonWeatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{ 
                        var searchCity = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));
                        if(searchCity != null)
                        {
                          var cityWeatherData = await weatherModel.cityWeatherLocation(searchCity);
                          UIupdate(cityWeatherData);
                        }
                      },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temperature.toStringAsFixed(1) + '°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '${weatherModel.getWeatherIcon(condition)} ',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weatherModel.getMessage(temperature.toInt())} in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

