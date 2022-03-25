import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertest/Models/TvSeriesModel.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertest/Models/MovieModel.dart';

class TvSeriesApi{

  Future<List<TvSeriesModel>> fetchTvSeries(int page) async {
    var client =http.Client();
    var url = Uri.parse('https://guwache.com/rest-api/v130/tvseries?page=$page');
    final response = await client.get(
        url, headers: {'API-KEY': 'baf4e9e715c5da63b99711ac'});

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseMovies, response.body);
  }



}

List<TvSeriesModel> parseMovies(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<TvSeriesModel>((json) => TvSeriesModel.fromJson(json)).toList();
}

