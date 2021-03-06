import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'dff52d7e2bd9a51838ff7f59c7fb5d8e';
const String openWeatherLink = 'http://api.openweathermap.org/data/2.5/weather';
const String openWeatherCityLink =
    'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  double latitude, longitude;
  String enteredCity;

  Future<dynamic> cityWeatherLocation(String city) async {
    enteredCity = city;
    NetworkHelper nw = NetworkHelper(
        '$openWeatherCityLink?q=$city&appid=$apiKey&units=metric');

    var weatherDataCity = await nw.getResponse();
    return weatherDataCity;
  }

  Future<dynamic> weatherLocation() async {
    Location location = Location();
    await location.getLocationClass();

    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper nw = NetworkHelper(
        '$openWeatherLink?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await nw.getResponse();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if(condition == 0)
    {
      return '';
    }
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if(temp == 888)
    {
      return enteredCity;
    }
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
