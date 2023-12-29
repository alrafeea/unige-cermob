import 'dart:async';

import 'package:certifyapp/core/enum/viewstate.dart';
import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/core/model/post/reviews/expert_review_model.dart';
import 'package:certifyapp/core/model/post/reviews/user_review_model.dart';
import 'package:certifyapp/core/service/news_service.dart';
import 'package:certifyapp/uitl/rating_utils.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../locator.dart';
import 'Auth_view_model.dart';
import 'base_view_model.dart';

class NewsViewModel extends BaseViewModel {
  NewsService _postService = locator<NewsService>();

  List<NewsModel> featuredNewsList = [];

  List<NewsModel> allNewsList = [];
    List<ExpertReviewModel> expertReviewsList = [];

  List<UserReviewModel> get userReviewsList => _postService.userReviewsList;
  RatingCounter userRatingCounterSum;
  int totalUserRating;
  NewsModel currentNews;
  RatingKey  maxUserCountRatingKey;
  int maxUserRatingCount;
  bool isGettingExpertReviewFinished = false;
  bool isGettingUserReviewFinished = false;

  StreamSubscription expertReviewsListStream;
  StreamSubscription userReviewsListStream;
  StreamSubscription getNewsByIdStream;


  Future updateNews(
      {NewsModel news,
      bool isUpdating,
      bool isExpert,
      ExpertReviewModel expertReviewModel,
      UserReviewModel userReviewModel}) async {
    setState(ViewState.BusyLocal);

    try {
      news.id = "${Utils.encryptStringByAES(string: news.url)}";

      await Firestore.instance
          .collection("posts")
          .document(news.id).setData(news.toJson(),merge: true); //.documentID.setData(post.toJson());

      if(isExpert) {
        // TODO prevent add multi review in case adding
        if (expertReviewModel.id == null || expertReviewModel.id == '') {
          final newsDoc = Firestore.instance
              .collection("posts")
              .document(news.id)
              .collection("expert-reviews")
              .document();
          expertReviewModel.id = newsDoc.documentID;
        }
        expertReviewModel.postId = news.id;
        await Firestore.instance
            .collection("posts")
            .document(news.id)
            .collection("expert-reviews")
            .document(expertReviewModel.id)
            .setData(expertReviewModel.toJson(), merge: true);
      } else {
        userReviewModel.postId = news.id;
        if (userReviewModel.id == null || userReviewModel.id == '') {
          final newsDoc = Firestore.instance
              .collection("posts").document(news.id).collection(
              "user-reviews").document();
          userReviewModel.id = newsDoc.documentID;
        }
        await Firestore.instance
            .collection("posts").document(news.id).collection(
            "user-reviews").document(userReviewModel.id).setData(
            userReviewModel.toJson(), merge: true);
      }

      setState(ViewState.Idle);
    } catch (error) {
      setState(ViewState.Idle);
      super.error = error;
      print(error);
    }
  }




  Future getNewsReviews(NewsModel news) async {
    setState(ViewState.Busy);
    await _postService.getAllNews(onSuccess: () {
      setState(ViewState.Idle);
    }, onFailure: () {
      error = _postService.error;
      setState(ViewState.Error);
    });
  }

  Future getNewsExpertReviews(NewsModel news, {Function onSuccess}) async {
    setState(ViewState.Busy);
    try {
      expertReviewsListStream = await Firestore.instance
          .collection("posts").document(news.id).collection(
          "expert-reviews")
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        expertReviewsList.clear();
        if (snapshot.documents.length > 0) {

          snapshot.documents.forEach((element) {
            expertReviewsList.add(ExpertReviewModel.fromJson(element.data));
          });
        }
        if (onSuccess != null)
          onSuccess();
        new Future.delayed(const Duration(milliseconds: 250), () {
          isGettingExpertReviewFinished = true;
          setState(ViewState.Idle);
        });

      }, onError: (e) {
        print(e);
        super.error = error;
        isGettingExpertReviewFinished = true;
        setState(ViewState.Error);
      });
    } catch (e) {
      super.error = error;
      setState(ViewState.Error);
      print(e);
    }
  }

  Future getNewsUserReviews(NewsModel news, {Function onSuccess}) async {
    setState(ViewState.Busy);
    try {
      userReviewsListStream = Firestore.instance
          .collection("posts").document(news.id).collection(
          "user-reviews")
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        userReviewsList.clear();
        if (snapshot.documents.length > 0) {

          snapshot.documents.forEach((element) {
            userReviewsList.add(UserReviewModel.fromJson(element.data));
          });
        }
        if (onSuccess != null)
          onSuccess();
        new Future.delayed(const Duration(milliseconds: 250), () {
          isGettingUserReviewFinished = true;
          setState(ViewState.Idle);
        });

      }, onError: (e) {
        print(e);
        isGettingUserReviewFinished = true;
        setState(ViewState.Error);
        super.error = error;
      });
    } catch (e) {
      isGettingUserReviewFinished = true;
      setState(ViewState.Error);
      super.error = error;
      print(e);
    }
  }


  Future getNewsById(NewsModel news, AuthViewModel authViewModel,
      {Function onSuccess}) async {
    setState(ViewState.Busy);
    try {
      getNewsByIdStream = Firestore.instance
          .collection("posts")
          .where("id", isEqualTo: news.id)
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        currentNews = null;
        if (snapshot.documents.length > 0) {
          // snapshot.documents.forEach((element) {
          currentNews = NewsModel.fromJson(snapshot.documents[0].data);
          // });
          if (currentNews != null) {
            if (authViewModel.isExpert) {
              getNewsExpertReviews(
                  news, onSuccess: onSuccess(currentNews, true));
            } else {
              getNewsUserReviews(news, onSuccess: onSuccess(currentNews, true));
            }
          }else{
            onSuccess(news, false);

          }
        }else{
          onSuccess(news, false);

        }

        getNewsByIdStream.cancel();
      }, onError: (e) {
        print(e);
        getNewsByIdStream.cancel();

        super.error = error;
        setState(ViewState.Error);
      });
    } catch (e) {
      // hasError = true;
      // onFailure();
      getNewsByIdStream.cancel();
      super.error = error;
      setState(ViewState.Error);
      print(e);
    }
  }


  getUserValidationSum() {
    totalUserRating = 0;
     maxUserRatingCount = 0;
    userRatingCounterSum = RatingCounter(
        falseRating: 0,
        miscaptioned: 0,
        mixMix: 0,
        mostlyFalse: 0,
        mostlyTrue: 0,
        outdated: 0,
        rumour: 0,
        scam: 0,
        trueRating: 0,
        unproven: 0);
    userReviewsList.forEach((element) {
      switch (element.type.id.toString()) {
        case "1":
          totalUserRating++;
          userRatingCounterSum.trueRating++;
          if(userRatingCounterSum.trueRating > maxUserRatingCount) {
            maxUserRatingCount = userRatingCounterSum.trueRating;
            maxUserCountRatingKey =  RatingKey.True;
          }
          break;
        case "2":
          totalUserRating++;
          userRatingCounterSum.mostlyTrue++;
          if(userRatingCounterSum.mostlyTrue > maxUserRatingCount) {
            maxUserRatingCount = userRatingCounterSum.mostlyTrue;
            maxUserCountRatingKey =  RatingKey.MostlyTrue;
          }
          break;
        case "3":
          totalUserRating++;
          userRatingCounterSum.falseRating++;
          if(userRatingCounterSum.falseRating > maxUserRatingCount) {
            maxUserRatingCount = userRatingCounterSum.falseRating;
            maxUserCountRatingKey =  RatingKey.False;
          }
          break;
        case "4":
          totalUserRating++;
          userRatingCounterSum.mostlyFalse++;
          if(userRatingCounterSum.mostlyFalse > maxUserRatingCount) {
            maxUserRatingCount = userRatingCounterSum.mostlyFalse;
            maxUserCountRatingKey =  RatingKey.MostlyFalse;
          }
          break;
        case "5":
          totalUserRating++;
          userRatingCounterSum.mixMix++;
          if(userRatingCounterSum.mixMix > maxUserRatingCount) {
            maxUserRatingCount = userRatingCounterSum.mixMix;
            maxUserCountRatingKey =  RatingKey.MixMix;
          }
          break;
        case "6":
          totalUserRating++;
          userRatingCounterSum.outdated++;
          if(userRatingCounterSum.outdated > maxUserRatingCount) {
            maxUserRatingCount = userRatingCounterSum.outdated;
            maxUserCountRatingKey =  RatingKey.Outdated;
          }
          break;
        case "7":
          totalUserRating++;
          userRatingCounterSum.scam++;
          if(userRatingCounterSum.scam > maxUserRatingCount) {
            maxUserRatingCount = userRatingCounterSum.scam;
            maxUserCountRatingKey =  RatingKey.Scam;
          }
          break;
        case "8":
          totalUserRating++;
          userRatingCounterSum.miscaptioned++;
          if(userRatingCounterSum.miscaptioned > maxUserRatingCount) {
            maxUserRatingCount = userRatingCounterSum.miscaptioned;
            maxUserCountRatingKey =  RatingKey.Miscaptioned;
          }
          break;
        case "9":
          totalUserRating++;
          userRatingCounterSum.rumour++;
          if(userRatingCounterSum.rumour > maxUserRatingCount) {
            maxUserRatingCount = userRatingCounterSum.rumour;
            maxUserCountRatingKey =  RatingKey.Rumour;
          }
          break;
        case "10":
          totalUserRating++;
          userRatingCounterSum.unproven++;
          if(userRatingCounterSum.unproven > maxUserRatingCount) {
            maxUserRatingCount = userRatingCounterSum.unproven;
            maxUserCountRatingKey =  RatingKey.Unproven;
          }
          break;
      }
    });
  }


  @override
  void dispose() {
    if (expertReviewsListStream != null) {
      expertReviewsListStream.cancel();
      expertReviewsListStream = null;
    }
    if (userReviewsListStream != null) {
      userReviewsListStream.cancel();
      userReviewsListStream = null;
    }
    if (getNewsByIdStream != null) {
      getNewsByIdStream.cancel();
      getNewsByIdStream = null;
    }
  }
}
