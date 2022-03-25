import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Pages/FavoritePage.dart';
import 'package:fluttertest/Pages/TvSeriesListPage.dart';
import 'package:fluttertest/Pages/testPage.dart';

import 'Pages/HomePage.dart';
import 'Pages/MovieListPage.dart';
import 'Pages/TvChannelsPage.dart';
import 'Pages/TvPlayerPage.dart';
import 'Pages/TvSeriesPage.dart';

void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Guwache",
    home: MainPage(),

  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int selectedIndex = 2;
  List<Widget> listWidgets = [const MovieListPage(),const TvChannelsPage(),const HomePage(),const TvSeriesListPage(),const FavoritePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidgets[selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        color: Colors.white,
        backgroundColor: Colors.red[400],
        items: const [
          TabItem(icon: Icons.movie, title: 'Movies'),
          TabItem(icon: Icons.live_tv, title: 'Live'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.movie_filter_outlined, title: 'Series'),
          TabItem(icon: Icons.favorite, title: 'Favorite'),
        ],
        initialActiveIndex: 2,
        //optional, default as 0
        onTap: (int i) => setState(() {
          selectedIndex=i;
        }),
      ),
    );

  }
}
