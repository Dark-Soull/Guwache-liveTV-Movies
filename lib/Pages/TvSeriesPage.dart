import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertest/APIManagers/SingleTvSeriesApi.dart';
import 'package:fluttertest/Models/SingleTvSeriesModel.dart';
import 'package:marquee/marquee.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'MoviePlayer.dart';
import 'YoutubePlayerPage.dart';

class TvSeriesPage extends StatefulWidget {
  TvSeriesPage({
    Key? key,
    required this.type,
    required this.ID,
  }) : super(key: key);

  String type;
  String ID;
  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  late Future<SingleTvSeriesModel> _TvData;

  @override
  void initState() {
    super.initState();
    _TvData = SingleTvSeriesApi().fetchSingleTvseries(widget.type, widget.ID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //for top bar and top color..............
            Container(
              // Background
              color: Colors.red[500],
              height: MediaQuery.of(context).size.height * 0.057,
              width: MediaQuery.of(context).size.width,
            ),
            FutureBuilder<SingleTvSeriesModel>(
              future: _TvData,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(
                    child: Text("An error has occurred !"),
                  );
                } else if (snapshot.hasData) {
                  return SingleTvSeriesPage(TvseriesData: snapshot.data!);
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 2.3,
                    child: Column(
                      children: [
                        //for poster and buttons..........................
                        SizedBox(
                          height: 250,
                          child: Row(
                            children: [
                              SkeletonAnimation(
                                shimmerColor: Colors.grey,
                                child: Container(
                                  height: 190,
                                  width: 140,
                                  margin: const EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                height: 160,
                                //color: Colors.red,
                                // margin: const EdgeInsets.only(left: 0.0),
                                padding: const EdgeInsets.only(top: 10, left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SkeletonAnimation(
                                      shimmerColor: Colors.grey,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        height: 28,
                                        margin: const EdgeInsets.only(top: 40),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SkeletonAnimation(
                                      shimmerColor: Colors.grey,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        height: 18,
                                        margin: const EdgeInsets.only(top: 20),
                                        color: Colors.grey,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //for description............................
                        SkeletonAnimation(
                          shimmerColor: Colors.grey,
                          child: Container(
                            margin: const EdgeInsets.only(top: 30),
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.9,
                            color: Colors.grey,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                            ),
                          ),
                        ),
                        //for director name.......................
                        SkeletonAnimation(
                          shimmerColor: Colors.grey,
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width * 0.9,
                            color:Colors.grey,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                            ),
                          ),
                        ),

                        SkeletonAnimation(
                          shimmerColor: Colors.grey,
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width * 0.9,
                            color:Colors.grey,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                            ),
                          ),
                        ),

                        SkeletonAnimation(
                          shimmerColor: Colors.grey,
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width * 0.9,
                            color:Colors.grey,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SingleTvSeriesPage extends StatefulWidget {
  SingleTvSeriesPage({
    Key? key,
    required this.TvseriesData,
  }) : super(key: key);

  final SingleTvSeriesModel TvseriesData;

  @override
  State<SingleTvSeriesPage> createState() => _SingleTvSeriesPageState();
}

class _SingleTvSeriesPageState extends State<SingleTvSeriesPage> {
  int isLogged = 1;

   late String dropdownValue;
   late int Position;

  String getGenre(List<Genre> genreList) {
    String finalWord = '';
    print(genreList[0].name);
    if (genreList[0].name.isEmpty) {
      return finalWord;
    } else {
      for (int i = 0; i < genreList.length; i++) {
        if (i == 0) {
          finalWord = finalWord + genreList[i].name;
        } else {
          finalWord = finalWord + ", " + genreList[i].name;
        }
      }
      return finalWord;
    }
  }

  String getDirector(List<Cast> directorList) {
    String finalWord = '';
    for (int i = 0; i < directorList.length; i++) {
      if (i == 0) {
        finalWord = finalWord + directorList[i].name;
      } else {
        finalWord = finalWord + ", " + directorList[i].name;
      }
    }
    return finalWord;
  }


int getItemCount(){
    for(int i=0;i<widget.TvseriesData.season.length;i++) {
      if (widget.TvseriesData.season[i].seasonsName==dropdownValue){
          Position=i;
      }
    }
    return Position;
}



  @override
  void initState() {
    dropdownValue=widget.TvseriesData.season[0].seasonsName;
    super.initState();
  }


  static final customManager=CacheManager(
    Config(
      'TvSeriesPage',
      stalePeriod: const Duration(days: 15),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // for invisible image..................
      Container(
        height: MediaQuery.of(context).size.height * 0.28,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          color: Colors.grey[50],
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.darken),
            image: NetworkImage(
              widget.TvseriesData.posterUrl,
            ),
          ),
        ),
      ),
      //for color gradient..............
      Container(
        height: MediaQuery.of(context).size.height * 0.28,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.center,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.1),
              Colors.white.withOpacity(1),
            ],
          ),
        ),
      ),
      //for all widget container....................................
      SizedBox(
        height: MediaQuery.of(context).size.height * 2.3,
        child: Column(
          children: [
            //for top bar buttons......................
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.red[400],
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.48,
                height: 10,
              ),
              Container(
                height: 40,
                width: 145,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Row(children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_outline_sharp),
                    color: Colors.red[400],
                    onPressed: () {
                      print('fav button');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.flag_outlined),
                    color: Colors.red[400],
                    onPressed: () {
                      print("report button");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    color: Colors.red[400],
                    onPressed: () {
                      print("share button");
                    },
                  ),
                ]),
              ),
            ]),
            //for gap below top bar.........................
            const SizedBox(
              height: 60,
            ),
            //for poster and buttons..........................
            SizedBox(
              height: 250,
              child: Row(
                children: [
                  Card(
                    margin: const EdgeInsets.only(left: 10.0),
                    color: Colors.grey,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:CachedNetworkImage(imageUrl: widget.TvseriesData.thumbnailUrl,
                        fit: BoxFit.fill,
                        height: 190,
                        width: 140,
                        cacheManager: customManager,
                        placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                        errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: 160,
                    //color: Colors.red,
                    // margin: const EdgeInsets.only(left: 0.0),
                    padding: const EdgeInsets.only(top: 10, left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 28,
                          child: Marquee(
                            text: widget.TvseriesData.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 23,
                            ),
                            blankSpace: 150,
                            numberOfRounds: 1,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 18,
                          child: Text(
                            getGenre(widget.TvseriesData.genre),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        trailerOption(
                            widget.TvseriesData.traillerYoutubeSource),
                      ],
                    ),
                  ),
                ],
              ),
            ),








            //for season list.............................
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    color: Colors.red, style: BorderStyle.solid, width: 0.80),
              ),

              child: Center(
                child: DropdownButton(
                  value: dropdownValue,
                  borderRadius: BorderRadius.circular(10),

                  icon: const Icon(Icons.arrow_drop_down),
                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                  isDense: true,
                  isExpanded: true,
                  items:widget.TvseriesData.season.map((season){
                    return DropdownMenuItem<String>(
                        value: season.seasonsName,
                        child: Text(season.seasonsName),);
                  }).toList(),
                  onChanged: (season){
                    setState(() {
                      dropdownValue=season.toString();
                    });
                  },
                ),
              ),
            ),

            //for season episodes...............................
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width*0.9,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              margin: const EdgeInsets.only(top: 5,),
              decoration: BoxDecoration(
                //color: Colors.red,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    color: Colors.red, style: BorderStyle.solid, width: 0.80),
              ),
              child: ListView.builder(
                  itemCount: widget.TvseriesData.season[getItemCount()].episodes.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MoviePlayer(path:widget.TvseriesData.season[getItemCount()].episodes[index].fileUrl)));
                      },
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          //color: Colors.red,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              color: Colors.black, style: BorderStyle.solid, width: 0.80),
                        ),
                        //color: Colors.yellow,
                        margin: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(imageUrl:widget.TvseriesData.season[getItemCount()].episodes[index].imageUrl,
                                fit: BoxFit.fill,
                                height: 80,
                                width: 90,
                                cacheManager: customManager,
                                placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),
                              ),
                            ),
                            Container(
                              margin:const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.TvseriesData.season[getItemCount()].episodes[index].episodesName,style: const TextStyle(fontWeight: FontWeight.bold),),
                                  Text("Season : "+dropdownValue,style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),








            //for description............................
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: 120,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  widget.TvseriesData.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                  maxLines: 6,
                ),
              ),
            ),
            //for director name.......................
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Director :  " + getDirector(widget.TvseriesData.director),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            //for realese on............
            SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text(
                      "Release On  " +
                          widget.TvseriesData.release.year.toString() +
                          "-" +
                          widget.TvseriesData.release.month.toString() +
                          "-" +
                          widget.TvseriesData.release.day.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //for genre.................
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Genre :  " + getGenre(widget.TvseriesData.genre),
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            //for cast and crew........................
            Column(
              children: [
                const Align(
                  alignment: Alignment(-0.92, 0),
                  child: Text("Cast and Crew",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16)),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                      itemCount: widget.TvseriesData.castAndCrew.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.grey[50],
                          elevation: 0,
                          margin: const EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
                              print(widget
                                  .TvseriesData.castAndCrew[index].starId);
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(90),
                                  child: CachedNetworkImage(imageUrl:widget.TvseriesData.castAndCrew[index]
                                        .imageUrl,
                                    fit: BoxFit.fill,
                                    height: 90,
                                    width: 90,
                                    cacheManager: customManager,
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
                                        widget.TvseriesData.castAndCrew[index]
                                            .name,
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
            //for you may also like
            Column(
              children: [
                const Align(
                  alignment: Alignment(-0.92, 0),
                  child: Text("You may also like",
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
                      itemCount: widget.TvseriesData.relatedTvseries.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.grey[50],
                          elevation: 0,
                          margin: const EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TvSeriesPage(type: 'tvseries', ID:widget.TvseriesData.relatedTvseries[index].videosId )));
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(imageUrl:widget.TvseriesData.relatedTvseries[index]
                                        .thumbnailUrl,
                                    fit: BoxFit.fill,
                                    height: 200,
                                    width: 140,
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
                                    text: widget.TvseriesData
                                        .relatedTvseries[index].title,
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
            //for comment box
            Column(
              children: [
                const Align(
                  alignment: Alignment(-0.92, 0),
                  child: Text("Comments",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your Comments',
                  ),
                ),
                Container(
                  height: 45,
                  width: 180,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.red[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Add Comments",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ]);
  }

  Widget trailerOption(String trailer) {
    if (trailer.isEmpty) {
      return Container();
    } else {
      return InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>YoutubePlayerPage(Url: trailer)));
        },
        child: Container(
          height: 45,
          width: 180,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.red[500],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              "TRAILER",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      );
    }
  }
}
