import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

Future<String> getAddressName(LocationData location, String apiKey) async {
  try {
    var endPoint =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location?.latitude},${location?.longitude}&key=$apiKey';
    var response = jsonDecode((await http.post(
      endPoint,
    ))
        .body);

    // getPostalCode(response['results'][0]['address_components'].las);
    return response['results'][0]['formatted_address'];
  } catch (e) {
    print(e);
    return null;
  }
}

Future<String> getUserCurrentAddress() async {
  final String key = '${GlobalConfiguration().getValue('api_key')}';
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  _locationData = await location.getLocation();
  return getAddressName(_locationData, key);
}
