import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class testPage extends StatefulWidget {
  const testPage({Key? key}) : super(key: key);

  @override
  State<testPage> createState() => _testPageState();
}

class _testPageState extends State<testPage> {

  List rad=[0,1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.red[400],

          child: Column(
            children: [
              Container(
                height: 280,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(15),bottomRight: Radius.circular(15)),
                color: Colors.black,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width:MediaQuery.of(context).size.width/2+40,
                      child: Column(
                        children:  [
                          Container(
                              margin: const EdgeInsets.only(top: 70,),
                              height: 50,
                              width: 170,
                              child: const Center(
                                child: Text('JOIN',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 35,
                                    color: Colors.white,decoration: TextDecoration.none,
                                fontFamily: 'Marion'
                                   ),
                                ),
                              )
                          ),
                          const SizedBox(
                              height: 30,
                              width: 170,
                              child: Center(
                                child: Text('To',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,
                                    color: Colors.white,decoration: TextDecoration.none,
                                    fontFamily: 'Marion'
                                ),
                                ),
                              )
                          ),
                          const SizedBox(
                              height: 50,
                              width: 220,
                              child: Text('GUWACHE',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,
                                  color: Colors.white,decoration: TextDecoration.none,
                                  fontFamily: 'PaytoneOne'
                              ),
                              )
                          ),
                          const SizedBox(
                              height: 40,
                              width: 170,
                              child: Center(
                                child: Text('Family',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,
                                    color: Colors.white,decoration: TextDecoration.none,
                                    fontFamily: 'Marion'
                                ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width:MediaQuery.of(context).size.width/2-40,
                        child: Lottie.asset('animations/WatchMovie.json'),
                      ),
                    )
                  ],
                )
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height-280,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width-100,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.yellow,
                          labelText: 'Username',
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width-100,
                      child: TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.start,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusColor: Colors.white,
                          labelText: 'Password',
                        ),
                      ),

                    ),

                    // const ListTile(
                    //   title: Text('Remember Me'),
                    //   leading: Radio(
                    //     value: rad.first,
                    //     groupValue: -1,
                    //     onChanged:(){print()},
                    //   ),
                    // ),
                  ],
                ),
              )
              // Container(
              //   height: 400,
              //   color: Colors.black,
              // )
            ],
          ),

        ),
      ),
    );
  }
}
