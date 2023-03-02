import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

final dio = Dio();

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    final googleApiKey = FlutterConfig.get('GOOGLE_API_KEY');
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }

  static Future<String> getPlaceAddress(
      {required double lat, required double lng}) async {
    final googleApiKey = FlutterConfig.get('GOOGLE_API_KEY');
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey';
    final response = await dio.get(url);
    return response.data['results'][0]['formatted_address'];
  }
}
