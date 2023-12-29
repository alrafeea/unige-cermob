import 'dart:async';

import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/pages/landing/statistic_page.dart';
import 'package:certifyapp/pages/my_account/profile_page.dart';
import 'package:certifyapp/pages/search/search_page.dart';
import 'package:certifyapp/uitl/translations_delegate_base.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/widgets/bottom_navigation/bottom_nav_bar.dart';
import 'package:certifyapp/widgets/news/add_news/add_news_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'home_page.dart';

class LandingPage extends StatefulWidget {
  final int index;
  String url;
  bool preventListeningToSharing;

  LandingPage({Key key, this.index, this.url, this.preventListeningToSharing=false}) : super(key: key);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  StreamSubscription _intentDataStreamSubscription;

  int currentTab = 0;
  PageController pageController;
  NewsModel addNews = NewsModel();
  TextEditingController urlController = TextEditingController();

  _changeCurrentTab(int tab, {bool makeUrlEmpty = true}) {
    setState(() {
      if (makeUrlEmpty) {
        widget.url = null;
        addNews = new NewsModel();
        urlController = TextEditingController();
      }
      currentTab = tab;
      pageController.jumpToPage(tab);
    });
  }

  @override
  void initState() {
    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
          if(value != null && value.isNotEmpty&&!widget.preventListeningToSharing  ) {
            print("eeeeeeeeeeeeeeeee");
            handleUrlFromLanding(value, "in");

          }
        }, onError: (err) {
          print("getLinkStream error: $err");
        });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      if(value != null && value.isNotEmpty &&!widget.preventListeningToSharing ) {
        print("rrrrrrrrrrrrr");
        handleUrlFromLanding(value, "out");

      } else {
        setState(() {
          widget.preventListeningToSharing = false;
        });

      }

    });


    if(widget.url != null) {
      currentTab = 2;
      pageController = PageController(keepPage: false,initialPage:currentTab );

      handelUrl(widget.url);

    } else {
        currentTab = 0;
        pageController = PageController(keepPage: false,initialPage:currentTab );

    }
    super.initState();

  }
  handelUrl(String url){
    if( Uri
        .parse(url)
    .isAbsolute) {
      widget.url = url;

      var uri = Uri.parse(url);
      addNews.source = uri.host;
      addNews.url = url;
      urlController.text = url;
      // _changeCurrentTab(2, makeUrlEmpty: false);
    }
  }

  handleUrlFromLanding(String url, String loc ) {
    handelUrl(url);
    _changeCurrentTab(2, makeUrlEmpty: false);
    // showDialog(
    //     context: context,
    //     builder: (_) =>
    //     new AlertDialog(
    //       shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(10.0))
    //       ),
    //       content:Container(child: Text(url +  "Landing Page $loc"),),
    //     )
    // );

  }

  // handel
  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils.changeBottomBarSysStyle(context:context );
    return Scaffold(
      extendBody: true,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomePage(),
          SearchPage(),
          AddNewsPage(url: widget.url,
            addNews: addNews,
            changeCurrentTab: _changeCurrentTab,urlController:urlController),
          StatisticPage(changeCurrentTab: _changeCurrentTab),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentTab: currentTab,changeIndex: _changeCurrentTab),
    );
  }

  getText(currentTab) {
    switch (currentTab) {
      case 0:
        return TranslationBase.of(context).home;
      case 1:
        return 'asd';
      case 2:
        return TranslationBase.of(context).mySchedule;
      case 3:
        return TranslationBase.of(context).services;
    }
  }
}
