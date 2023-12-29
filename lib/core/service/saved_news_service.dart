import 'dart:async';

import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/core/service/base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedNewsService extends BaseService {
  List<NewsModel> savedNewsList = [];
  List<dynamic> savedNewsIds = List();
  // List<Follower> followerInfo = [];
  StreamSubscription savedNewsListStream;
  StreamSubscription savedNewsStream;
  
  bool itemsLoading = false;
  // ignore: missing_return
  Future getMySavedNews({String uid }) {
    try {
      savedNewsListStream = Firestore.instance
          .collection("users")
          .where("uid",isEqualTo: uid )
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        if (snapshot.documents.length > 0) {
          snapshot.documents.forEach((element) {
            savedNewsIds =element.data['savedNews'];
          });
          getSavedNewsDetails(savedNewsIds);
        } else {
          savedNewsIds = [];
        }
      }, onError: (e) {
        print(e);
        hasError = true;
        super.error = error;
      });
    } catch (e) {
      hasError = true;
      super.error = error;
      print(e);
    }
  }

  getSavedNewsDetails(List<dynamic> savedNewsIds) {
    try {
      savedNewsListStream = Firestore.instance
          .collection("posts")
          .where(
        'uid',
        whereIn: savedNewsIds,
      )
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        if (snapshot.documents.length > 0) {
          savedNewsList.clear();
          snapshot.documents.forEach((element) {
            savedNewsList.add(NewsModel.fromJson(element.data));
          });
          itemsLoading = false;
        } else {
          savedNewsIds = [];
          itemsLoading = false;
        }
      }, onError: (e) {
        print(e);
        hasError = true;
        super.error = error;
      });
    } catch (e) {
      print(e);
      hasError = true;
      super.error = error;
    }
  }
  //
  // saveNews({PostModel news, String uid}) async {
  //   await Firestore.instance
  //       .collection("users")
  //       .document(uid)
  //       .collection('savedNews')
  //       .add(follower.toJson());
  // }
  //
  unSaveNews({NewsModel news, String uid}) async {
    NewsModel selectedSavedNews;
    try {
      // selectedSavedNews = followerInfo
      //     .firstWhere((element) => element.followerId == follower.followerId);
    } catch (e) {
      print(e);
    }

    // await Firestore.instance
    //     .collection("users")
    //     .document(uid)
    //     .collection('savedNews')
    //     // .document(selectedSavedNews.id)
    //     // .delete()
    //     .catchError((e) {
    //   print(e);
    // }).then((value) {
    //   print('error');
    // });
  }


  bool isSaved(String uid) {
    String savedNewsId;
    try {
      savedNewsId = savedNewsIds.firstWhere((element) => element == uid);
    } catch (e) {
      print(e);
    }

    return savedNewsId != null ? true : false;
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
