import 'dart:async';

import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/core/model/post/reviews/expert_review_model.dart';
import 'package:certifyapp/core/model/post/reviews/user_review_model.dart';
import 'package:certifyapp/core/service/base_service.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class NewsService extends BaseService {
  List<NewsModel> featuredNewsList = [];
  StreamSubscription featuredNewsListStream;

  List<NewsModel> allNewsList = [];
  StreamSubscription allNewsListStream;
  List<ExpertReviewModel> expertReviewsList = [];
  List<UserReviewModel> userReviewsList = [];

  StreamSubscription expertReviewsListStream;
  StreamSubscription userReviewsListStream;

  Future addPost(NewsModel post,
      {Function() onSuccess, Function() onFailure}) async {
    try {
      // item.uid = uid;
      post.createdAt = DateTime.now();
      final newsDoc = Firestore.instance
          .collection("posts")
          .document("${Utils.encryptStringByAES(string: post.url)}"); //.documentID.setData(post.toJson());
      post.id = newsDoc.documentID;
      await newsDoc.setData(post.toJson());
      onSuccess();
    } catch (error) {
      hasError = true;
      onFailure();
      super.error = error;
      print(error);
    }
  }

  Future updateNews(NewsModel news,
      {        bool isUpdating,
        bool isExpert,ExpertReviewModel expertReviewModel,
        UserReviewModel userReviewModel,Function() onSuccess, Function() onFailure}) async {
    try {
      news.id = "${Utils.encryptStringByAES(string: news.url)}";

     await Firestore.instance
            .collection("posts")
            .document(news.id).setData(news.toJson(),merge: true); //.documentID.setData(post.toJson());

      if(isExpert) {
        // TODO prevent add multi review in case adding
        if(expertReviewModel.id == null || expertReviewModel.id =='' ) {
          final newsDoc = Firestore.instance
              .collection("posts").document(news.id).collection(
              "expert-reviews").document();
          expertReviewModel.id = newsDoc.documentID;
        }
        await Firestore.instance
            .collection("posts").document(news.id).collection(
            "expert-reviews").document(expertReviewModel.id).setData(expertReviewModel.toJson(), merge:true);
      } else {
        if(userReviewModel.id  ==null || userReviewModel.id=='') {
          final newsDoc = Firestore.instance
              .collection("posts").document(news.id).collection(
              "user-reviews").document();
          userReviewModel.id = newsDoc.documentID;
        }
        await Firestore.instance
            .collection("posts").document(news.id).collection(
            "user-reviews").document(userReviewModel.id).setData(userReviewModel.toJson(), merge: true);
      }

      onSuccess();
    } catch (error) {
      hasError = true;
      onFailure();
      super.error = error;
      print(error);
    }
  }

  getFeaturedNews({Function() onSuccess, Function() onFailure}) async {
    try {
      featuredNewsListStream = Firestore.instance
          .collection("posts")
          // todo : add condition when its clear.
          // .where("uid",isEqualTo: uid )
          .orderBy("createdAt", descending: true)
          .limit(3)
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        if (snapshot.documents.length > 0) {
          featuredNewsList.clear();
          snapshot.documents.forEach((element) {
            featuredNewsList.add(NewsModel.fromJson(element.data));
          });
          onSuccess();

        }
      }, onError: (e) {
        print(e);
        hasError = true;
        onFailure();
        super.error = error;
      });
    } catch (e) {
      onFailure();
      hasError = true;
      super.error = error;
      print(e);
    }
   }

  getAllNews({Function() onSuccess, Function() onFailure}) async {
    try {
      allNewsListStream = Firestore.instance
          .collection("posts")
      // todo : add condition when its clear.
      // .where("uid",isEqualTo: uid )
          .orderBy("createdAt", descending: true)
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        if (snapshot.documents.length > 0) {
          allNewsList.clear();
          snapshot.documents.forEach((element) {
            allNewsList.add(NewsModel.fromJson(element.data));
          });
        }
        onSuccess();

      }, onError: (e) {
        print(e);
        onFailure();
        hasError = true;
        super.error = error;
      });
    } catch (e) {
      hasError = true;
      onFailure();
      super.error = error;
      print(e);
    }
  }

  getNewsExpertReviews(
      {@required NewsModel news, Function() onSuccess, Function() onFailure}) async {
    try {
      expertReviewsListStream = Firestore.instance
          .collection("posts").document(news.id).collection(
          "expert-reviews")
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        if (snapshot.documents.length > 0) {
          expertReviewsList.clear();
          snapshot.documents.forEach((element) {
            expertReviewsList.add(ExpertReviewModel.fromJson(element.data));
          });
        }
        onSuccess();
      }, onError: (e) {
        print(e);
        onFailure();
        hasError = true;
        super.error = error;
      });
    } catch (e) {
      hasError = true;
      onFailure();
      super.error = error;
      print(e);
    }
  }

  getNewsUserReviews(
      {@required NewsModel news, Function() onSuccess, Function() onFailure}) async {
    try {
      userReviewsListStream = Firestore.instance
          .collection("posts").document(news.id).
      collection('user-reviews').
      snapshots()
          .listen((QuerySnapshot snapshot) async {
        if (snapshot.documents.length > 0) {
          userReviewsList.clear();
          snapshot.documents.forEach((element) {
            userReviewsList.add(UserReviewModel.fromJson(element.data));
          });
        }
        onSuccess();
      }, onError: (e) {
        print(e);
        onFailure();
        hasError = true;
        super.error = error;
      });
    } catch (e) {
      hasError = true;
      onFailure();
      super.error = error;
      print(e);
    }
  }

  @override
  void dispose() {
    if (featuredNewsListStream != null) {
      featuredNewsListStream.cancel();
      featuredNewsListStream = null;
    }
    if (allNewsListStream != null) {
      allNewsListStream.cancel();
      allNewsListStream = null;
    }
    if (expertReviewsListStream != null) {
      expertReviewsListStream.cancel();
      expertReviewsListStream = null;
    }
    if (userReviewsListStream != null) {
      userReviewsListStream.cancel();
      userReviewsListStream = null;
    }
  }

}
