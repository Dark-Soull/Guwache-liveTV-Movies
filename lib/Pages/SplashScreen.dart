import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertest/Pages/HomePage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _nevigation();
  }

  _nevigation()async{
    await Future.delayed(const Duration(milliseconds: 5000),() {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
  }

  @override
  Widget build(BuildContext context) {

    //for stopping device rotation..........
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //for background.............
          Container(
            color: Colors.blue,
          ),

          //for animation and text............
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Container(
                width: 150,
                height: 150,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(150),
                ),
                child: Lottie.asset('animations/infinite.json'),
              ),
            ),
            const Text(
              "Guwache",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
        ],
      ),
    );
  }
}
