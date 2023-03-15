import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MapBoxHelper {
  static const baseMapboxApiUrl = 'https://api.mapbox.com/styles/v1';
  static getStaticMapUrl(double latitude, double longitude,
      {String mapSize = '600x350',
      styles = 'mapbox/streets-v12',
      marker = 'pin-l-embassy+f74e4e',
      zoom = 13}) {
    return '${MapBoxHelper.baseMapboxApiUrl}/$styles/static/$marker($longitude,$latitude)/$longitude,$latitude,$zoom,0.00,0.00/$mapSize?access_token=${dotenv.env['MAPBOX_ACCESS_TOKEN']}';
  }

  static getAddressFromLatLong(double latitude, double longitude) async {
    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=${dotenv.env['MAPBOX_ACCESS_TOKEN']}';
    final response = await http.get(Uri.parse(url));
    final address = jsonDecode(response.body)['features'][0]['place_name'];
    return address;
  }
}
