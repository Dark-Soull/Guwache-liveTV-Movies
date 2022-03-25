import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertest/Models/SingleTvSeriesModel.dart';
import 'package:http/http.dart' as http;

class SingleTvSeriesApi{

  Future<SingleTvSeriesModel> fetchSingleTvseries(String type,String ID) async {

    var client =http.Client();
    var url = Uri.parse('https://guwache.com/rest-api/v130/single_details?type=$type&id=$ID');
    final response = await client.get(
        url, headers: {'API-KEY': 'baf4e9e715c5da63b99711ac'});


    return compute(parseMovies, response.body);
  }


}

SingleTvSeriesModel parseMovies(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return SingleTvSeriesModel.fromJson(parsed);
}