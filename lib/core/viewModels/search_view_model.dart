import 'dart:async';

import 'package:certifyapp/core/enum/viewstate.dart';
import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/core/model/search_model.dart';
import 'package:certifyapp/uitl/rating_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Auth_view_model.dart';
import 'base_view_model.dart';

class SearchViewModel extends BaseViewModel {
  List<NewsModel> allNewsList=[];



  StreamSubscription allNewsListStream;
  StreamSubscription featuredNewsListStream;

  Future getSearchResult( SearchModel searchModel, AuthViewModel authViewModel) async {
    setState(ViewState.Busy);

    try {
      allNewsListStream = Firestore.instance
          .collection("posts")
          .orderBy("createdAt", descending: true)
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        allNewsList.clear();
        if (snapshot.documents.length > 0) {
          snapshot.documents.forEach((element) {
            NewsModel news = NewsModel.fromJson(element.data);
            if (isMatchExpertRating(news, searchModel) &&
                isMatchUserRating(news, searchModel) &&
                isInMyPost(news, searchModel, authViewModel) &&
                isPostHasValidation(news, searchModel, authViewModel)) {
              if (searchModel.searchText.isNotEmpty) {
                if (news.title != null &&
                    news.title
                        .toLowerCase()
                        .contains(searchModel.searchText.toLowerCase())) {
                  allNewsList.add(news);
                }
              } else {
                allNewsList.add(news);
              }
            }
          });
        }
        setState(ViewState.Idle);
      }, onError: (e) {
        print(e);
        super.error = error;
        setState(ViewState.Error);
      });
    } catch (e) {
      // hasError = true;
      // onFailure();
      super.error = error;
      setState(ViewState.Error);
      print(e);
    }
  }

  isMatchExpertRating(NewsModel news, SearchModel searchModel) {
    if(searchModel.expertRatingModel==null) {
      return true;
    }

    if(news.expertRatingCounter==null) {
      return false;
    }
    if (news.expertRatingCounter.trueRating != null &&
        searchModel.expertRatingModel.key == RatingKey.True
            .getRatingInof()
            .key || news.expertRatingCounter.falseRating != null &&
        searchModel.expertRatingModel.key == RatingKey.False
            .getRatingInof()
            .key || news.expertRatingCounter.mostlyFalse != null &&
        searchModel.expertRatingModel.key == RatingKey.MostlyFalse
            .getRatingInof()
            .key || news.expertRatingCounter.mostlyTrue != null &&
        searchModel.expertRatingModel.key == RatingKey.MostlyTrue
            .getRatingInof()
            .key || news.expertRatingCounter.mixMix != null &&
        searchModel.expertRatingModel.key == RatingKey.MixMix
            .getRatingInof()
            .key || news.expertRatingCounter.outdated != null &&
        searchModel.expertRatingModel.key == RatingKey.Outdated
            .getRatingInof()
            .key || news.expertRatingCounter.scam != null &&
        searchModel.expertRatingModel.key == RatingKey.Scam
            .getRatingInof()
            .key || news.expertRatingCounter.miscaptioned != null &&
        searchModel.expertRatingModel.key == RatingKey.Miscaptioned
            .getRatingInof()
            .key || news.expertRatingCounter.rumour != null &&
        searchModel.expertRatingModel.key == RatingKey.Rumour
            .getRatingInof()
            .key || news.expertRatingCounter.unproven != null &&
        searchModel.expertRatingModel.key == RatingKey.Unproven
            .getRatingInof()
            .key) {
      return true;
    }
    return false;
  }

  isMatchUserRating(NewsModel news, SearchModel searchModel) {
    if(searchModel.userRatingModel == null){
      return true;
    }
    if(news.userRatingCounter == null ) {
      return false;
    }
    if (news.userRatingCounter.trueRating != null &&
        searchModel.userRatingModel.key == RatingKey.True
            .getRatingInof()
            .key || news.userRatingCounter.falseRating != null &&
        searchModel.userRatingModel.key == RatingKey.False
            .getRatingInof()
            .key || news.userRatingCounter.mostlyFalse != null &&
        searchModel.userRatingModel.key == RatingKey.MostlyFalse
            .getRatingInof()
            .key || news.userRatingCounter.mostlyTrue != null &&
        searchModel.userRatingModel.key == RatingKey.MostlyTrue
            .getRatingInof()
            .key || news.userRatingCounter.mixMix != null &&
        searchModel.userRatingModel.key == RatingKey.MixMix
            .getRatingInof()
            .key || news.userRatingCounter.outdated != null &&
        searchModel.userRatingModel.key == RatingKey.Outdated
            .getRatingInof()
            .key || news.userRatingCounter.scam != null &&
        searchModel.userRatingModel.key == RatingKey.Scam
            .getRatingInof()
            .key || news.userRatingCounter.miscaptioned != null &&
        searchModel.userRatingModel.key == RatingKey.Miscaptioned
            .getRatingInof()
            .key || news.userRatingCounter.rumour != null &&
        searchModel.userRatingModel.key == RatingKey.Rumour
            .getRatingInof()
            .key || news.userRatingCounter.unproven != null &&
        searchModel.userRatingModel.key == RatingKey.Unproven
            .getRatingInof()
            .key) {
      return true;
    }
    return false;
  }

  isInMyPost(NewsModel news, SearchModel searchModel, AuthViewModel authViewModel){
    if(!searchModel.onlyMyPost) {
      return true;
    }
    if(authViewModel.userData.myNews == null) {
      return false;
    }

    if(authViewModel.userData.myNews.contains(news.id)){
      return true;
    }
    return false;
  }

  isPostHasValidation(NewsModel news, SearchModel searchModel,
      AuthViewModel authViewModel) {
    if (!searchModel.onlyValidatedPost) {
      return true;
    }
    if ((news.counters.expertsValidations != null &&
        news.counters.expertsValidations > 0) ||
        (news.counters.usersValidations != null ||
            news.counters.usersValidations > 0)) {
      return true;
    }
    return false;
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
