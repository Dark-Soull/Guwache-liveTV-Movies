import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
                            "Favorite",
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

                const SizedBox(
                  height: 200,
                  child: Center(child: Text("No Item Here",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                )
                //
                // FutureBuilder<List<TvSeriesModel>>(
                //   future: _TvSeriesData,
                //   builder: (context, snapshot) {
                //     if (snapshot.hasError) {
                //       return const Center(
                //         child: Text("An error has occurred !"),
                //       );
                //     } else if (snapshot.hasData) {
                //       TvSeriesList2=snapshot.data!;
                //       return MoviesList1();
                //     } else {
                //       return const Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }
                //   },
                // ),

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
