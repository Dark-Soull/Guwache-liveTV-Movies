import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertest/APIManagers/TvChannelApi.dart';
import 'package:fluttertest/Models/TvModel.dart';
import 'package:fluttertest/Pages/TvPlayerPage.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:skeleton_text/skeleton_text.dart';

class TvChannelsPage extends StatefulWidget {
  const TvChannelsPage({Key? key}) : super(key: key);

  @override
  State<TvChannelsPage> createState() => _TvChannelsPageState();
}

class _TvChannelsPageState extends State<TvChannelsPage> {
  late Future<List<TvModel>> _TvData;
  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

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
    _TvData = TvChannelApi().fetchTvChannel();
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
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Stack(
                    children: [
                      //for top background color.............
                      Container(
                        // Background
                        color: Colors.red[400],
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width,
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
                            tooltip: MaterialLocalizations.of(context)
                                .openAppDrawerTooltip,
                          ),
                          primary: false,
                          title: Text(
                            "Live TV",
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



                FutureBuilder<List<TvModel>>(
                  future: _TvData,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("An error has occurred !"),
                      );
                    } else if (snapshot.hasData) {

                      return TvListPage(TvList: snapshot.data!);
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
        ),
      ),
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
            children:[
              SizedBox(
                height: 110,
                width: 150,
                child: Image.asset('Assets/logo.png',fit: BoxFit.fill,),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  "Guwache - Live TV & Movies",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),

          ListTile(
            onTap: () {},
            leading: const Icon(Icons.home, size: 20.0, color: Colors.white),
            title: const Text("Home"),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.folder_open,
                size: 20.0, color: Colors.white),
            title: const Text("Genre"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.flag_outlined,
                size: 20.0, color: Colors.white),
            title: const Text("Country"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.lock_outline,
                size: 20.0, color: Colors.white),
            title: const Text("Login"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
            const Icon(Icons.settings, size: 20.0, color: Colors.white),
            title: const Text("Settings"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
            const Icon(Icons.monetization_on_outlined, size: 20.0, color: Colors.white),
            title: const Text("Donation"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
            const Icon(Icons.share, size: 20.0, color: Colors.white),
            title: const Text("Telegram"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }


}


class TvListPage extends StatelessWidget {
  const TvListPage({Key? key, required this.TvList,}) : super(key: key);

  final List<TvModel> TvList;
  static final customManager=CacheManager(
    Config(
      'TvChannelsPage',
      stalePeriod: const Duration(days: 15),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:MediaQuery.of(context).size.height * 0.79,
      child: ListView.builder(
          itemCount: TvList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index){
            return SizedBox(
              height: 200,
              child: Column(
                children: [
                  Align(
                    alignment: const Alignment(-0.9,0),
                    child: Text(TvList[index].title,style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20)),
                  ),
                  SizedBox(
                    height: 155,
                    child: ListView.builder(
                        itemCount: TvList[index].channels.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index2){
                          return Card(
                            color: Colors.grey[50],
                            elevation: 0,
                            margin: const EdgeInsets.all(20),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (builder)=>TvPlayerPage(type: 'tv', ID: TvList[index].channels[index2].liveTvId)));
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(imageUrl: TvList[index].channels[index2].posterUrl,
                                      fit: BoxFit.fill,height: 60,width: 90,
                                      cacheManager: customManager,
                                    placeholder: (context,url)=> const Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context,url,error)=>const Center(child: Icon(Icons.error,color: Colors.red,)),),
                                  ),
                                  const SizedBox(height: 8,),
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(TvList[index].channels[index2].tvName,style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
