import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> getLocation() async {
    Location? location;
    location!.getCurrentLocation();
    print("Latitude: ${location.latitude}");
    print("Longitude: ${location.longitude}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getData() async {
    var url = Uri.parse(
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // se a requisição foi feita com sucesso
      var data = response.body;
      print(data); // imprima o resultado
    } else {
      print(response.statusCode); // senão, imprima o código de erro
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // obtém a localização atual
            getLocation();
          },
          child: const Text('Obter Localização'),
        ),
      ),
    );
  }
}
