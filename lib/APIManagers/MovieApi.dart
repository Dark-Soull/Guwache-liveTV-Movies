import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertest/Models/MovieModel.dart';

class MovieApi{

  Future<List<MovieModel>> fetchMovies(int page) async {
    var client =http.Client();
    var url = Uri.parse('https://guwache.com/rest-api/v130/movies?page=$page');
    final response = await client.get(
        url, headers: {'API-KEY': 'baf4e9e715c5da63b99711ac'});

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseMovies, response.body);
  }



}

// A function that converts a response body into a List<MovieModel>.
List<MovieModel> parseMovies(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
}

