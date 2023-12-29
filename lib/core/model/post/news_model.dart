class NewsModel {
  Counters counters;
  DateTime createdAt;
  RatingCounter expertRatingCounter;
  RatingCounter userRatingCounter;
  String source;
  String url;
  String id;
  String title;
  String description;

  NewsModel(
      {this.counters,
      this.createdAt,
      this.expertRatingCounter,
      this.userRatingCounter,
      this.source,
      this.url,
      this.id,
      this.title, this.description});

  NewsModel.fromJson(Map<String, dynamic> json) {
    counters = json['counters'] != null
        ? new Counters.fromJson(json['counters'])
        : null;
    createdAt = json['createdAt'] is  DateTime?json['createdAt'] :
    json['createdAt'] is String ? DateTime.parse(json['createdAt']) : DateTime
        .parse(json['createdAt'].toDate().toString());
    expertRatingCounter = json['expertRatingCounter'] != null
        ? new RatingCounter.fromJson(json['expertRatingCounter'])
        : null;
    userRatingCounter = json['userRatingCounter'] != null
        ? new RatingCounter.fromJson(json['userRatingCounter'])
        : null;
    source = json['source'];
    url = json['url'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.counters != null) {
      data['counters'] = this.counters.toJson();
    }
    data['createdAt'] = this.createdAt ?? DateTime.now();
    if (this.expertRatingCounter != null) {
      data['expertRatingCounter'] = this.expertRatingCounter.toJson();
    }
    if (this.userRatingCounter != null) {
      data['userRatingCounter'] = this.userRatingCounter.toJson();
    }
    data['source'] = this.source;
    data['url'] = this.url;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

  class Counters {
  int expertsValidations;
  int usersValidations;

  Counters({this.expertsValidations, this.usersValidations});

  Counters.fromJson(Map<String, dynamic> json) {
    expertsValidations = json['expertsValidations'];
    usersValidations = json['usersValidations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expertsValidations'] = this.expertsValidations;
    data['usersValidations'] = this.usersValidations;
    return data;
  }
}

class RatingCounter {
  int trueRating;
  int mostlyTrue;
  int falseRating;
  int mostlyFalse;
  int mixMix;
  int outdated;
  int scam;
  int miscaptioned;
  int rumour;
  int unproven;

  RatingCounter(
      {this.trueRating, this.mostlyTrue, this.falseRating, this.mostlyFalse, this.mixMix, this.outdated, this.scam, this.miscaptioned, this.rumour, this.unproven});

  RatingCounter.fromJson(Map<String, dynamic> json) {
    print(json['id']);
    trueRating = json['1'];
    mostlyTrue = json['2'];
    falseRating = json['3'];
    mostlyFalse = json['4'];
    mixMix = json['5'];
    outdated = json['6'];
    scam = json['7'];
    miscaptioned = json['8'];
    rumour = json['9'];
    unproven = json['10'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.trueRating;
    data['2'] = this.mostlyTrue;
    data['3'] = this.falseRating;
    data['4'] = this.mostlyFalse;
    data['5'] = this.mixMix;
    data['6'] = this.outdated;
    data['7'] = this.scam;
    data['8'] = this.miscaptioned;
    data['9'] = this.rumour;
    data['10'] = this.unproven;
    return data;
  }
}

