import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertest/APIManagers/SingleMovieApi.dart';
import 'package:fluttertest/Models/SingleMovieModel.dart';
import 'package:fluttertest/Pages/MoviePlayer.dart';
import 'package:fluttertest/Pages/YoutubePlayerPage.dart';
import 'package:marquee/marquee.dart';
import 'package:skeleton_text/skeleton_text.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key,required this.type, required this.ID}) : super(key: key);

  final String type,ID;
  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  late Future<SingleMovieModel> _TvData;

  @override
  void initState() {
    super.initState();
    _TvData = SingleMovieApi().fetchSingleMovie(widget.type,widget.ID);
  }

  @override
  void dispose() {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    //for stopping device rotation..........
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);


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
            FutureBuilder<SingleMovieModel>(
              future: _TvData,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(
                    child: Text("An error has occurred !"),
                  );
                } else if (snapshot.hasData) {
                  return SingleMoviePage(MovieData: snapshot.data!);
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

class SingleMoviePage extends StatelessWidget {
  const SingleMoviePage({Key? key,required this.MovieData,}) : super(key: key);

  final SingleMovieModel MovieData;

  static final customManager=CacheManager(
    Config(
      'MoviePage',
      stalePeriod: const Duration(days: 15),
    ),
  );

  final int isLogged=1;

  String getGenre(List<Genre> genreList){
    String finalWord='';
    print(genreList[0].name);
    if(genreList[0].name.isEmpty){
      print("true....");
      return finalWord;
    }else {
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

  String getDirector(List<Cast> directorList){
    String finalWord='';
    for(int i=0;i<directorList.length;i++){
      if(i==0){
        finalWord=finalWord + directorList[i].name;
      }else{
        finalWord=finalWord+", " + directorList[i].name;
      }
    }
    return finalWord;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
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
                MovieData.posterUrl,
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
          height: MediaQuery.of(context).size.height * 1.61,
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
                      color: Colors.grey[50],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(imageUrl:MovieData.thumbnailUrl,
                          fit: BoxFit.fill,
                          height: 220,
                          width: 140,
                          cacheManager: customManager,
                          placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                          errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: 250,
                      //color: Colors.red,
                      // margin: const EdgeInsets.only(left: 0.0),
                      padding: const EdgeInsets.only(top: 10,left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:MediaQuery.of(context).size.width * 0.5,
                            height: 28,
                            child: Marquee(
                              text: MovieData.title,
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
                            width:MediaQuery.of(context).size.width * 0.4,
                            height: 18,
                            child:
                            Text( getGenre(MovieData.genre),
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),),

                          ),

                          InkWell(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MoviePlayer(path:MovieData.videos[0].fileUrl)));},
                            child: Container(
                              height: 45,
                              width: 180,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.red[500],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text("WATCH NOW",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),),
                              ),
                            ),
                          ),
                          trailerOption(context,MovieData.traillerYoutubeSource),
                          downloadOption(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //for description............................
              SizedBox(
                height: 120,
                child:Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Text(MovieData.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    ),textAlign: TextAlign.start,
                    textDirection: TextDirection.ltr,
                    maxLines: 6,),
                ),
              ),
              //for director name.......................
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Text("Director :  "+getDirector(MovieData.director),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    ),),
                ),
              ),
              //for realese on............
              SizedBox(
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    children: [
                      Text("Release On  "+MovieData.release.year.toString()+"-"+MovieData.release.month.toString()+"-"+MovieData.release.day.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14,
                        ),),
                    ],
                  ),
                ),
              ),
              //for genre.................
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Text("Genre :  "+getGenre(MovieData.genre),
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    ),),
                ),
              ),
              //for cast and crew........................
              Column(
                children: [
                  const Align(
                    alignment: Alignment(-0.92,0),
                    child: Text("Cast and Crew",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16)),
                  ),

                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                        itemCount: MovieData.castAndCrew.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return Card(
                            color: Colors.grey[50],
                            elevation: 0,
                            margin: const EdgeInsets.all(20),
                            child: InkWell(
                              onTap: (){
                                print(MovieData.castAndCrew[index].starId);
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(90),
                                    child: CachedNetworkImage(imageUrl:MovieData.castAndCrew[index].imageUrl,
                                      fit: BoxFit.fill,height: 90,width: 90,
                                      cacheManager: customManager,
                                    placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),),
                                  ),
                                  const SizedBox(height: 8,),
                                  Center(
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Text(MovieData.castAndCrew[index].name,style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,)),
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
                    alignment: Alignment(-0.92,0),
                    child: Text("You may also like",style: TextStyle(
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
                        itemCount: MovieData.relatedMovie.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return Card(
                            color: Colors.grey[50],
                            elevation: 0,
                            margin: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MoviePage(type: 'movie', ID: MovieData.relatedMovie[index].videosId)));
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(imageUrl:MovieData.relatedMovie[index].thumbnailUrl,
                                      fit: BoxFit.fill,height: 200,width: 140,
                                      cacheManager: customManager,
                                    placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),),
                                  ),
                                  const SizedBox(height: 8,),

                                  SizedBox(
                                    width: 150,
                                    height: 20,
                                    child: Marquee(
                                      text: MovieData.relatedMovie[index].title,
                                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
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
                    alignment: Alignment(-0.92,0),
                    child: Text("Comments",style: TextStyle(
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
                      child: Text("Add Comments",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                      ),),
                    ),
                  )
                ],
              ),



            ],
          ),
        ),
      ]),
    );
  }

  Widget trailerOption(BuildContext context,String trailer){
    if(trailer.isEmpty){
      return Container();
    }else{
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
            child: Text("TRAILER",style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 15,
            ),),
          ),
        ),
      );
    }
  }


  Widget downloadOption(){
    if(isLogged==1){
      if(MovieData.downloadLinks.isEmpty){
        return Container();
      }else {
        return Container(
          height: 45,
          width: 180,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.red[500],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text("DOWNLOAD", style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 15,
            ),),
          ),
        );
      }
    }else{
      return Container();
    }
  }

}
