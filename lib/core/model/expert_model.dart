class Expert {
  String uid;
  String logo;
  String name;
  String profileUrl;

  Expert({this.uid, this.logo, this.name});

  Expert.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    logo = json['logo'];
    name = json['name'];
    profileUrl = json['profileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['logo'] = this.logo;
    data['name'] = this.name;
    data['profileUrl'] = this.profileUrl;
    return data;
  }
}