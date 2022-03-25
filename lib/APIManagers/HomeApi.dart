import 'dart:convert';
import 'package:fluttertest/Models/HomeModel.dart';
import 'package:http/http.dart' as http;

class HomeApi{

  Future<HomeModel> fetchHome() async {

    var client =http.Client();
    var url = Uri.parse('https://guwache.com/rest-api/v130/home_content_for_android');
    final response = await client.get(
        url, headers: {'API-KEY': 'baf4e9e715c5da63b99711ac'});

    final parsed = json.decode(response.body);

    HomeModel homeData=HomeModel.fromJson(parsed);

   return homeData;
  }


}
