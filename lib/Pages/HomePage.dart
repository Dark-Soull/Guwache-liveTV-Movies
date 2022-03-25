import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertest/APIManagers/HomeApi.dart';
import 'package:fluttertest/Models/HomeModel.dart';
import 'package:fluttertest/Pages/testPage.dart';
import 'package:marquee/marquee.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'MoviePage.dart';
import 'TvPlayerPage.dart';
import 'TvSeriesPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<HomeModel> _HomeData;

  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  static final customManager=CacheManager(
    Config(
      'HomePage',
      stalePeriod: const Duration(days: 15),
    ),
  );



  toggleMenu() {
    final _state = _sideMenuKey.currentState!;
    if (_state.isOpened) {
      _state.closeSideMenu();
    } else {
      _state.openSideMenu();
    }
  }

  @override
  void initState() {
    super.initState();
    _HomeData = HomeApi().fetchHome();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: _sideMenuKey,
      background: Colors.red[400],
      menu: buildMenu(),
      type: SideMenuType.slideNRotate,
      onChange: (_isOpened) {
        setState(() => isOpened = _isOpened);
      },
      child: IgnorePointer(
        ignoring: isOpened,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                //for top bar and top color..............
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.14,
                  child: Stack(
                    children: [
                      //for top background color.............
                      Container(
                        // Background
                        color: Colors.red[400],
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.1,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                      ),

                      Container(),
                      // Required some widget in between to float AppBar

                      //for app bar..........................
                      Positioned(
                        // To take AppBar Size only
                        top: 45.0,
                        left: 20.0,
                        right: 20.0,
                        child: AppBar(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20),
                              top: Radius.circular(20),
                            ),
                          ),
                          leading: IconButton(
                            icon: const Icon(Icons.menu),
                            color: Colors.red[400],
                            onPressed: () {
                              toggleMenu();
                            },
                            tooltip: MaterialLocalizations
                                .of(context)
                                .openAppDrawerTooltip,
                          ),
                          primary: false,
                          title: Text(
                            "Home",
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[400]),
                          ),
                          actions: <Widget>[
                            IconButton(
                              icon: Icon(Icons.search, color: Colors.red[400]),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                FutureBuilder<HomeModel>(
                  future: _HomeData,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("An error has occurred !"),
                      );
                    } else if (snapshot.hasData) {
                      return HomeList(snapshot.data!);
                    } else {
                      return Column(children: [
                        //for sliderr............................................
                        SkeletonAnimation(
                          shimmerColor: Colors.grey,
                          child: Container(
                            height: 170,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        //for gap between slider and populer stars................
                        const SizedBox(
                          height: 30,
                        ),
                        //for Featured TV.......................................
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SkeletonAnimation(
                                  shimmerColor: Colors.grey,
                                  child: Container(
                                    height: 155,
                                    width: 100,
                                    margin: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SkeletonAnimation(
                                  shimmerColor: Colors.grey,
                                  child: Container(
                                    height: 155,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SkeletonAnimation(
                                  shimmerColor: Colors.grey,
                                  child: Container(
                                    height: 155,
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        //for Featured TV.......................................
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SkeletonAnimation(
                                  shimmerColor: Colors.grey,
                                  child: Container(
                                    height: 155,
                                    width: 100,
                                    margin: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SkeletonAnimation(
                                  shimmerColor: Colors.grey,
                                  child: Container(
                                    height: 155,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SkeletonAnimation(
                                  shimmerColor: Colors.grey,
                                  child: Container(
                                    height: 155,
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //for Latest Tvseries.......................................
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SkeletonAnimation(
                              shimmerColor: Colors.grey,
                              child: Container(
                                height: 290,
                                width: 150,
                                margin: const EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SkeletonAnimation(
                              shimmerColor: Colors.grey,
                              child: Container(
                                height: 290,
                                width: 150,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ]);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget HomeList(HomeModel moviesList) {
    return SingleChildScrollView(
      child: Column(children: [
        //for sliderr............................................
        CarouselSlider.builder(
          itemCount: moviesList.slider.slide.length,
          itemBuilder: (context, index, j) {
            return InkWell(
              onTap: () {
                if (moviesList.slider.slide[index].actionType == 'movie') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MoviePage(
                            type: moviesList.slider.slide[index].actionType,
                            ID: moviesList.slider.slide[index].id,
                          )));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TvSeriesPage(
                              type: moviesList.slider.slide[index].actionType,
                              ID: moviesList.slider.slide[index].id)));
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(children: [
                  CachedNetworkImage(imageUrl:moviesList.slider.slide[index].imageLink,
                    fit: BoxFit.fill, width: 1000,
                    placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                    errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),
                    cacheManager: customManager,
                  ),
                  Align(
                      alignment: const Alignment(-0.8, 0.6),
                      child: Text(moviesList.slider.slide[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16))),
                ]),
              ),
            );
          },
          options: CarouselOptions(
            height: 170,
            autoPlay: true,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            autoPlayCurve: Curves.linearToEaseOut,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),

        //for gap between slider and populer stars................
        const SizedBox(
          height: 30,
        ),

        //for popular star.......................................
        Column(
          children: [
            const Align(
              alignment: Alignment(-0.9, 0),
              child: Text("Popular Stars",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                  itemCount: moviesList.popularStars.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey[50],
                      elevation: 0,
                      margin: const EdgeInsets.all(20),
                      child: InkWell(
                        onTap: () {
                          print(moviesList.popularStars[index].starId);
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: CachedNetworkImage(
                                imageUrl: moviesList.popularStars[index].imageUrl,
                                fit: BoxFit.fill,
                                height: 90,
                                cacheManager: customManager,
                                width: 90,
                                placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Center(
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                    moviesList.popularStars[index].starName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),

        //for Featured TV.......................................
        Column(
          children: [
            const Align(
              alignment: Alignment(-0.9, 0),
              child: Text("Featured Tv Channel",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
            ),
            SizedBox(
              height: 155,
              child: ListView.builder(
                  itemCount: moviesList.featuredTvChannel.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => TvPlayerPage(
                                    type: 'tv',
                                    ID: moviesList
                                        .featuredTvChannel[index].liveTvId)));
                      },
                      child: Card(
                        color: Colors.grey[50],
                        elevation: 0,
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: moviesList.featuredTvChannel[index].posterUrl,
                                fit: BoxFit.fill,
                                height: 60,
                                width: 90,
                                cacheManager: customManager,
                                placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                  moviesList.featuredTvChannel[index].tvName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),

        //for Latest Movies.......................................
        Column(
          children: [
            const Align(
              alignment: Alignment(-0.9, 0),
              child: Text("Latest Movies",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 290,
              child: ListView.builder(
                  itemCount: moviesList.latestMovies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey[50],
                      elevation: 0,
                      margin: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoviePage(
                                      type: "movie",
                                      ID: moviesList
                                          .latestMovies[index].videosId)));
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: moviesList.latestMovies[index].thumbnailUrl,
                                fit: BoxFit.fill,
                                height: 200,
                                width: 150,
                                cacheManager: customManager,
                                placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 150,
                              height: 20,
                              child: Marquee(
                                text: moviesList.latestMovies[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                blankSpace: 150,
                                numberOfRounds: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),

        //for Latest Tvseries.......................................
        Column(
          children: [
            const Align(
              alignment: Alignment(-0.9, 0),
              child: Text("Latest Tv Series",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 290,
              child: ListView.builder(
                  itemCount: moviesList.latestMovies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey[50],
                      elevation: 0,
                      margin: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TvSeriesPage(
                                      type: 'tvseries',
                                      ID: moviesList
                                          .latestTvseries[index].videosId)));
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: moviesList.latestTvseries[index].thumbnailUrl,
                                fit: BoxFit.fill,
                                height: 200,
                                width: 150,
                                cacheManager: customManager,
                                placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            SizedBox(
                              width: 150,
                              height: 20,
                              child: Marquee(
                                text: moviesList.latestTvseries[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                blankSpace: 150,
                                numberOfRounds: 1,
                              ),
                            ),

                            // Marquee(
                            //    // Text(moviesList.latestMovies[index].title,style: const TextStyle(
                            //    //  fontWeight: FontWeight.bold,
                            //    //  color: Colors.black,
                            //    //  fontSize: 15,)),
                            // ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),

        //for Featured tvSeries or movies.......................................
        Column(
          children: [
            Align(
              alignment: const Alignment(-0.9, 0),
              child: Text(moviesList.featuresGenreAndMovie[0].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 290,
              child: ListView.builder(
                  itemCount: moviesList.featuresGenreAndMovie[0].videos.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey[50],
                      elevation: 0,
                      margin: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          if (moviesList.featuresGenreAndMovie[0].videos[index]
                              .isTvseries ==
                              '0') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MoviePage(
                                        type: 'movie',
                                        ID: moviesList.featuresGenreAndMovie[0]
                                            .videos[index].videosId)));
                          } else {
                            print("its series");
                          }
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: moviesList.featuresGenreAndMovie[0]
                                    .videos[index].thumbnailUrl,
                                fit: BoxFit.fill,
                                height: 200,
                                width: 150,
                                cacheManager: customManager,
                                placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            SizedBox(
                              width: 150,
                              height: 20,
                              child: Marquee(
                                text: moviesList.featuresGenreAndMovie[0]
                                    .videos[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                blankSpace: 150,
                                numberOfRounds: 1,
                              ),
                            ),

                            // Marquee(
                            //    // Text(moviesList.latestMovies[index].title,style: const TextStyle(
                            //    //  fontWeight: FontWeight.bold,
                            //    //  color: Colors.black,
                            //    //  fontSize: 15,)),
                            // ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ]),
    );
  }



  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 110,
                width: 150,
                child: Image.asset(
                  'Assets/logo.png',
                  fit: BoxFit.fill,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  "Guwache - Live TV & Movies",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.home, size: 20.0, color: Colors.white),
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {},
            leading:
            const Icon(Icons.folder_open, size: 20.0, color: Colors.white),
            title: const Text(
              "Genre",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.flag_outlined,
                size: 20.0, color: Colors.white),
            title: const Text(
              "Country",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
            const Icon(Icons.lock_outline, size: 20.0, color: Colors.white),
            title: const Text(
              "Login",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
            const Icon(Icons.settings, size: 20.0, color: Colors.white),
            title: const Text(
              "Settings",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.monetization_on_outlined,
                size: 20.0, color: Colors.white),
            title: const Text(
              "Donation",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.share, size: 20.0, color: Colors.white),
            title: const Text(
              "Telegram",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}


