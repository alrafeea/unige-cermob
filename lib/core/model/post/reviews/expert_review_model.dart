import 'package:certifyapp/core/model/post/reviews/user_review_model.dart';

import '../../expert_model.dart';
import 'type_model.dart';

class ExpertReviewModel {
  List<String> claims;
  Expert expert;
  bool isTitleMisleading;
  String postId;
  String id;
  String whatIsFalse;
  String whatIsTrue;
  Type type;
  User user;

  ExpertReviewModel(
      {this.claims,
      this.expert,
      this.isTitleMisleading,
      this.postId,
      this.whatIsFalse,
      this.whatIsTrue,
      this.type});

  ExpertReviewModel.fromJson(Map<String, dynamic> json) {
    claims = json['claims']!=null?json['claims'].cast<String>():null;
    expert =
        json['expert'] != null ? new Expert.fromJson(json['expert']) : null;
    isTitleMisleading = json['isTitleMisleading'];
    postId = json['postId'];
    id = json['id'];
    whatIsFalse = json['whatIsFalse'];
    whatIsTrue = json['whatIsTrue'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claims'] = this.claims;
    if (this.expert != null) {
      data['expert'] = this.expert.toJson();
    }
    data['isTitleMisleading'] = this.isTitleMisleading;
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['whatIsFalse'] = this.whatIsFalse;
    data['whatIsTrue'] = this.whatIsTrue;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

