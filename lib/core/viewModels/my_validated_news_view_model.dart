import 'dart:async';

import 'package:certifyapp/core/enum/viewstate.dart';
import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'base_view_model.dart';

class
MyValidatedNewsViewModel extends BaseViewModel {

  List<NewsModel>  validatedNewsList =[];


  List<dynamic> validatedNewsIds = List();
  StreamSubscription validatedNewsListStream;
  StreamSubscription validatedNewsStream;

  bool itemsLoading = false;

  // ignore: missing_return
  Future getMyValidatedNews({@required String uid, int itemNo}) {
    setState(ViewState.Busy);
    try {
      validatedNewsListStream = Firestore.instance
          .collection("users")
          .where("uid", isEqualTo: uid)
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        validatedNewsIds.clear();
        if (snapshot.documents.length > 0) {
          snapshot.documents.forEach((element) {
            validatedNewsIds = element.data['myValidatedNews'];
          });

          if (validatedNewsIds == null) {
            setState(ViewState.Idle);
          } else {
            int end = itemNo ==null?validatedNewsIds.length:itemNo>validatedNewsIds.length?validatedNewsIds.length:itemNo;
            getValidatedNewsDetails(validatedNewsIds.sublist(validatedNewsIds.length - end,validatedNewsIds.length));
          }
        } else {
          validatedNewsIds = [];
        }
      }, onError: (e) {
        print(e);
        super.error = error;
        setState(ViewState.Error);
      });
    } catch (e) {
      super.error = error;
      setState(ViewState.Error);
      print(e);
    }
  }

  getValidatedNewsDetails(List<dynamic> validatedNewsIds) {
    try {
      validatedNewsListStream = Firestore.instance
          .collection("posts")
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        validatedNewsList.clear();
        if (snapshot.documents.length > 0) {
          snapshot.documents.forEach((element) {
            if(validatedNewsIds.indexOf(element.data['id'])>-1){
              validatedNewsList.add(NewsModel.fromJson(element.data));
            }
          });
          setState(ViewState.Idle);
          itemsLoading = false;
        } else {
          setState(ViewState.Idle);
          validatedNewsIds = [];
          itemsLoading = false;
        }
      }, onError: (e) {
        print(e);
        super.error = error;
        setState(ViewState.Error);
      });
    } catch (e) {
      print(e);
      super.error = error;
      setState(ViewState.Error);
    }
  }


  @override
  void dispose() {
    if (validatedNewsListStream != null) {
      validatedNewsListStream.cancel();
      validatedNewsListStream = null;
    }
    if (validatedNewsStream != null) {
      validatedNewsStream.cancel();
      validatedNewsStream = null;
    }
  }
}
