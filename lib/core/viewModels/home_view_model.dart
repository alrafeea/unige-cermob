import 'dart:async';

import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {

  List<NewsModel> featuredNewsList = [];

  List<NewsModel> allNewsList = [];

  StreamSubscription allNewsListStream;
  StreamSubscription featuredNewsListStream;

  bool isGettingAllNews  = false;
  bool isGettingFeaturedNews  = false;

  HomeViewModel(){
    // getHomeData();
  }


  getHomeData(){
    getFeaturedNews();
    getAllNews();
  }



  Future getFeaturedNews() async {
    isGettingFeaturedNews = true;
    // notifyListeners();
    try {
      featuredNewsListStream = Firestore.instance
          .collection("posts")
          .orderBy("createdAt", descending: true)
          .limit(10)
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        isGettingFeaturedNews = true;
        // setState(ViewState.Busy);
        featuredNewsList.clear();
        if (snapshot.documents.length > 0) {
          snapshot.documents.forEach((element) {
            featuredNewsList.add(NewsModel.fromJson(element.data));
          });
        }
        isGettingFeaturedNews = false;
        notifyListeners();
      }, onError: (e) {
        print(e);
        isGettingFeaturedNews = false;

        notifyListeners();
      });
    } catch (e) {
      // hasError = true;
      // onFailure();
      isGettingFeaturedNews = false;

      notifyListeners();
      print(e);
    }
  }
  Future getAllNews() async {
    isGettingAllNews = true;
    // notifyListeners();

    try {
      allNewsListStream = Firestore.instance
          .collection("posts")
          .orderBy("createdAt", descending: true)
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        isGettingAllNews = true;
        // setState(ViewState.Busy);
        allNewsList.clear();
        if (snapshot.documents.length > 0) {
          snapshot.documents.forEach((element) {
            allNewsList.add(NewsModel.fromJson(element.data));
          });
        }
        isGettingAllNews = false;
        notifyListeners();
      }, onError: (e) {
        print(e);
        isGettingAllNews = false;
        notifyListeners();
      });
    } catch (e) {
      // hasError = true;
      // onFailure();
      // super.error = error;
      isGettingAllNews = false;
      notifyListeners();
      print(e);
    }
  }



  @override
  void dispose() {
    if (allNewsListStream != null) {
      allNewsListStream.cancel();
      allNewsListStream = null;
    }
    if (featuredNewsListStream != null) {
      featuredNewsListStream.cancel();
      featuredNewsListStream = null;
    }
  }
}
