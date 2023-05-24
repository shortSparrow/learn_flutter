import 'dart:convert';

import 'package:flutter_clean_architecture/data/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

import '../models/advice_model.dart';

abstract class AdviceRemoteDataSource {
  /// request random advice from API
  ///  returns [adviceModel] if success
  /// throw server - Exception if status code not 200
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final client = http.Client();

  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse("https://api.flutter-community.de/api/v1/advice"),
      headers: {
        "content-type": "application/json; charset=utf-8"
      },
    );

    if(response.statusCode != 200) {
      throw ServerException();
    }

    final responseBody = json.decode(response.body);

    return AdviceModel.fromJson(responseBody);
  }
}
