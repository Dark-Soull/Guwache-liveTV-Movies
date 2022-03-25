import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertest/Models/TvModel.dart';
import 'package:http/http.dart' as http;

class TvChannelApi{

  Future <List<TvModel>> fetchTvChannel() async {

    var client =http.Client();
    var url = Uri.parse('https://guwache.com/rest-api/v130/all_tv_channel_by_category');
    final response = await client.get(
        url, headers: {'API-KEY': 'baf4e9e715c5da63b99711ac'});

    return compute(parseMovies, response.body);
  }


}

List<TvModel> parseMovies(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<TvModel>((json) => TvModel.fromJson(json)).toList();
}