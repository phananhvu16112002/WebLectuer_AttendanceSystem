import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GetLocation {
  double? latitude;
  double? longtitude;
  Position? positionMain;
  String? address;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanently denied");
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(hours: 2),
        forceAndroidLocationManager: true);
    latitude = position.latitude;
    longtitude = position.longitude;
    positionMain = position;
    return position;
  }

  Future<String?> getAddressFromLatLong(Position position) async {
    try {
      String apiurl =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyAj53xWW9TWMq2obphJulyMKZjQlKapcYI";
      Response response = await http.get(Uri.parse(apiurl));
      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        if (data['status'] == 'OK') {
          Map firstResult = data['results'][0];
          address = firstResult['formatted_address'];
          return address;
        }
      } else {
        print('Error');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  String processAddress(String address) {
    List<String> components = address.split(',');
    List<String> filteredComponents =
        components.where((component) => component.trim().isNotEmpty).toList();
    String processedAddress = filteredComponents.join(',');
    return processedAddress;
  }
}
