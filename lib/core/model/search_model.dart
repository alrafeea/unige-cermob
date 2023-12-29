import 'package:certifyapp/uitl/rating_utils.dart';

class SearchModel {
  String searchText;
  RatingModel expertRatingModel;
  RatingModel userRatingModel;
  bool onlyValidatedPost;
  bool onlyMyPost;

  SearchModel(
      {this.searchText,
        this.expertRatingModel,
        this.onlyValidatedPost = false,
        this.onlyMyPost =  false});

  SearchModel.fromJson(Map<String, dynamic> json) {
    searchText = json['searchText'];
    onlyValidatedPost = json['onlyValidatedPost'];
    onlyMyPost = json['onlyMyPost'];
    expertRatingModel = json['expertRatingModel'] != null
        ? new RatingModel.fromJson(json['expertRatingModel'])
        : null;
    userRatingModel = json['userRatingModel'] != null
        ? new RatingModel.fromJson(json['userRatingModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchText'] = this.searchText;
    data['expertRatingModel'] = this.expertRatingModel;
    data['onlyValidatedPost'] = this.onlyValidatedPost;
    data['onlyMyPost'] = this.onlyMyPost;
    if (this.expertRatingModel != null) {
      data['expertRatingModel'] = this.expertRatingModel.toJson();
    }
    if (this.userRatingModel != null) {
      data['expertRatingModel'] = this.userRatingModel.toJson();
    }
    return data;
  }
}
