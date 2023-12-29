import 'dart:async';

import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/core/viewModels/home_view_model.dart';
import 'package:certifyapp/pages/RootPage.dart';
import 'package:certifyapp/values/values.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool _isInit = false;
  Widget image;


  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      HomeViewModel homeViewModel = Provider.of(context,listen:false);
      AuthViewModel authViewModel = Provider.of(context);

      homeViewModel.getHomeData();
      authViewModel.loadAuthInfo();
      startTime();

      _isInit = true;
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    image = Image.asset('assets/images/Certify-icon-B-3.png', height: 170,width: 170,);

  }

  //

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FractionallySizedBox(
                widthFactor: 0.89,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 60
                          : 50,
                    ),
                    Container(child:image,),
                    JumpingDotsProgressIndicator(fontSize: 35, color: AppColors.primaryColor),
                    SizedBox(height: 32.0),


                    SizedBox(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 300
                          : 50,
                    )
                  ],
                ),
              ),
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.80,
                  child: Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Powered by Certify",
                                      style: TextStyle(
                                          fontSize: 13, color: AppColors.blackShade7),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 10
                                      : 5,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RootPage(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // gifController.dispose();
    super.dispose();
  }
}
