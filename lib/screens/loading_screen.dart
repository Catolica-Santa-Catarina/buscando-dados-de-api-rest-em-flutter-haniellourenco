import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/location.dart';
import '../services/networking.dart';
import 'location_screen.dart';

const apiKey = '556cd7311cf5a5486f28f8942c0544bc';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  Future<void> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    // print("Latitude: ${location.latitude}");
    latitude = location.latitude!;
    // print("Longitude: ${location.longitude}");
    longitude = location.longitude!;

    getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/'
        'data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    pushToLocationScreen(weatherData);
  }

  void pushToLocationScreen(dynamic weatherData) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(localWeatherData: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    return const Center(
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}
