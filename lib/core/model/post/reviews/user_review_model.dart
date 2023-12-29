import 'type_model.dart';

class UserReviewModel {
  String postId;
  String id;
  Type type;
  User user;

  UserReviewModel({this.postId, this.type, this.user});

  UserReviewModel.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}



class User {
  String displayName;
  String email;
  String photoURL;
  String uid;

  User({this.displayName, this.email, this.photoURL, this.uid});

  User.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    photoURL = json['photoURL'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['photoURL'] = this.photoURL;
    data['uid'] = this.uid;
    return data;
  }
}
