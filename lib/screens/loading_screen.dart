import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../services/location.dart';

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
    print("Latitude: ${location.latitude}");
    latitude = location.latitude!;
    print("Longitude: ${location.longitude}");
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
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // se a requisição foi feita com sucesso
      var data = response.body;
      var jsonData = jsonDecode(data);
      var cityName = jsonData['name'];
      var temperature = jsonData['main']['temp'];
      var weatherCondition = jsonData['weather'][0]['id'];
      print(
          'cidade: $cityName, temperatura: $temperature, condição: $weatherCondition');
      print(data); // imprima o resultado
    } else {
      print(response.statusCode); // senão, imprima o código de erro
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
