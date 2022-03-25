import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertest/Models/SingleMovieModel.dart';
import 'package:fluttertest/Pages/testPage.dart';
import 'package:http/http.dart' as http;

class SingleMovieApi{

  Future<SingleMovieModel> fetchSingleMovie(String type,String ID) async {

    var client =http.Client();
    var url = Uri.parse('https://guwache.com/rest-api/v130/single_details?type=$type&id=$ID');
    final response = await client.get(
        url, headers: {'API-KEY': 'baf4e9e715c5da63b99711ac'});

    final parsed = json.decode(response.body);

    //print(parsed);
    //SingleMovieModel SingleData=SingleMovieModel.fromJson(parsed);
    // print(SingleData.isTvseries);

    //return SingleData;
    return compute(parseMovies, response.body);
  }


}

SingleMovieModel parseMovies(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return SingleMovieModel.fromJson(parsed);
}