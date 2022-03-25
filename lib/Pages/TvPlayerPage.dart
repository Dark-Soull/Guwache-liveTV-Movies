import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:fluttertest/APIManagers/SingleTvApi.dart';
import 'package:fluttertest/Models/SingleTvModel.dart';
import 'package:fluttertest/Pages/testPage.dart';
import 'package:fluttertest/VideoPlayer/PlayerForTV.dart';
import 'package:skeleton_text/skeleton_text.dart';

class TvPlayerPage extends StatefulWidget {
  TvPlayerPage({Key? key,required this.type,required this.ID}) : super(key: key);

  String type;
  String ID;
  @override
  State<TvPlayerPage> createState() => _TvPlayerPageState();
}

class _TvPlayerPageState extends State<TvPlayerPage> {
  late Future<SingleTvModel> _TvData;



  @override
  void initState() {
    _TvData = SingleTvApi().fetchSingleTv(widget.type, widget.ID);


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SingleTvModel>(
        future: _TvData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text("An error has occurred !"),
            );
          } else if (snapshot.hasData) {
            return PlayerForTV(DATA: snapshot.data!);
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 2.3,
              child: Column(
                children: [
                  Container(
                    // Background
                    color: Colors.red[500],
                    height: MediaQuery.of(context).size.height * 0.057,
                    width: MediaQuery.of(context).size.width,
                  ),
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
    );
  }
}

