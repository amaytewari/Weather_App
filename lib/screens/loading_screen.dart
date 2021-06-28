import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


const apiKey = 'dff52d7e2bd9a51838ff7f59c7fb5d8e';

double latitude, longitude;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    
    WeatherModel weatherModel = WeatherModel();

    var weatherData = await weatherModel.weatherLocation();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData);
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SpinKitWave(
      color: Colors.white,
      size: 50.0,
    ),
        ));
  }
}
