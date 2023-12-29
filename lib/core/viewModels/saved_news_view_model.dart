import 'dart:async';

import 'package:certifyapp/core/enum/viewstate.dart';
import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_view_model.dart';

class SavedNewsViewModel extends BaseViewModel {

  List<NewsModel> savedNewsList = [];
  List<dynamic> savedNewsIds = List();
  StreamSubscription savedNewsListStream;
  StreamSubscription savedNewsStream;

  bool itemsLoading = false;

  // ignore: missing_return
  Future getMySavedNews({String uid, int itemNo}) {
    setState(ViewState.Busy);
    try {
      savedNewsListStream = Firestore.instance
          .collection("users")
          .where("uid", isEqualTo: uid)
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
            if(savedNewsIds != null)
            savedNewsIds.clear();

        if (snapshot.documents.length > 0) {
          snapshot.documents.forEach((element) {
            savedNewsIds = element.data['savedNews'];
          });
          if (savedNewsIds == null) {
            setState(ViewState.Idle);
          } else {
            int end = itemNo ==null?savedNewsIds.length:itemNo>savedNewsIds.length?savedNewsIds.length:itemNo;

            getSavedNewsDetails(savedNewsIds.sublist(savedNewsIds.length-end,savedNewsIds.length));

          }
        } else {
          savedNewsIds = [];
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

  getSavedNewsDetails(List<dynamic> savedNewsIds) {
    try {
      savedNewsListStream = Firestore.instance
          .collection("posts")
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        savedNewsList.clear();
        if (snapshot.documents.length > 0) {
          snapshot.documents.forEach((element) {
            if(savedNewsIds.indexOf(element.data['id'])>-1){
              savedNewsList.add(NewsModel.fromJson(element.data));

            }
          });
          setState(ViewState.Idle);
          itemsLoading = false;
        } else {
          setState(ViewState.Idle);
          savedNewsIds = [];
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
    if (savedNewsListStream != null) {
      savedNewsListStream.cancel();
      savedNewsListStream = null;
    }
    if (savedNewsStream != null) {
      savedNewsStream.cancel();
      savedNewsStream = null;
    }
  }
}
