import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/values/values.dart';
import 'package:flutter/cupertino.dart';

enum RatingKey {
  True,
  MostlyTrue,
  False,
  MostlyFalse,
  MixMix,
  Outdated,
  Scam,
  Miscaptioned,
  Rumour,
  Unproven,
}

extension SelectedRatingKey on RatingKey {
  // ignore: missing_return
  RatingModel getRatingInof() {
    switch (this) {
      case RatingKey.True:
        return RatingModel(icon: CertifyIcon.true_icon, key: 1,label: "True", activeColor: Color(0xFF8BC540) );
        break;
      case RatingKey.MostlyTrue:
        return RatingModel(icon: CertifyIcon.true_mostly, key: 2,label: "Mostly True", activeColor: Color(0xFF9FA13B) );
        break;
      case RatingKey.False:
        return RatingModel(icon: CertifyIcon.false_icon, key: 3,label: "False" , activeColor: Color(0xFFBE1E2D));
        break;
      case RatingKey.MostlyFalse:
        return RatingModel(icon: CertifyIcon.false_mostly, key: 4,label: "Mostly False", activeColor: Color(0xFFB65931) );
        break;
      case RatingKey.MixMix:
        return RatingModel(icon: CertifyIcon.mix, key: 5,label: "Mix - Mix", activeColor: Color(0xFFFAAF40) );
        break;
      case RatingKey.Outdated:
        return RatingModel(icon: CertifyIcon.outdated, key: 6,label: "Outdated" , activeColor: Color(0xFF9E1F63));
        break;
      case RatingKey.Scam:
        return RatingModel(icon: CertifyIcon.scam, key: 7,label: "Scam" , activeColor: Color(0xFFBAA58F));
        break;
      case RatingKey.Miscaptioned:
        return RatingModel(
            icon: CertifyIcon.miscaptioned,
            key: 8,
            label: "Miscaptioned",
            activeColor: Color(0xFFF9EC31));
        break;
      case RatingKey.Rumour:
        return RatingModel(
            icon: CertifyIcon.legend,
            key: 9,
            label: "Rumour",
            activeColor: Color(0xFF9E1F63));
        break;
      case RatingKey.Unproven:
        return RatingModel(
            icon: CertifyIcon.unproven,
            key: 10,
            label: "Unproven",
            activeColor: Color(0xFF8FD0B9));
        break;
    }
  }


}

class RatingUtils{
  // ignore: missing_return
  static RatingModel getRatingInofById(String id) {
    switch (id) {
      case "1":
        return RatingModel(icon: CertifyIcon.true_icon, key: 1,label: "True", activeColor: Color(0xFF8BC540) );
        break;
      case "2":
        return RatingModel(icon: CertifyIcon.true_mostly, key: 2,label: "Mostly True", activeColor: Color(0xFF9FA13B) );
        break;
      case "3":
        return RatingModel(icon: CertifyIcon.false_icon, key: 3,label: "False" , activeColor: Color(0xFFBE1E2D));
        break;
      case "4":
        return RatingModel(icon: CertifyIcon.false_mostly, key: 4,label: "Mostly False", activeColor: Color(0xFFB65931) );
        break;
      case "5":
        return RatingModel(icon: CertifyIcon.mix, key: 5,label: "Mix - Mix", activeColor: Color(0xFFFAAF40) );
        break;
      case "6":
        return RatingModel(icon: CertifyIcon.outdated, key: 6,label: "Outdated" , activeColor: Color(0xFF9E1F63));
        break;
      case "7":
        return RatingModel(icon: CertifyIcon.scam, key: 7,label: "Scam" , activeColor: Color(0xFFBAA58F));
        break;
      case "8":
        return RatingModel(icon: CertifyIcon.miscaptioned, key: 8,label: "Miscaptioned" , activeColor: Color(0xFFF9EC31));
        break;
      case "9":
        return RatingModel(icon: CertifyIcon.legend, key: 9,label: "Rumour", activeColor: Color(0xFF9E1F63) );
        break;
      case "10":
        return RatingModel(icon: CertifyIcon.unproven, key: 10,label: "Unproven" , activeColor: Color(0xFF8FD0B9));
        break;
    }
  }

  // ignore: missing_return
  static RatingKey getRatingKeyById(dynamic x ) {
    int id = (x is String)?int.parse(x):x;
    switch (id) {
      case 1:
        return RatingKey.True;
        break;
      case 2:
        return RatingKey.MostlyTrue;
        break;
      case 3:
        return RatingKey.False;
        break;
      case 4:
        return RatingKey.MostlyFalse;
        break;
      case 5:
        return RatingKey.MixMix;
        break;
      case 6:
        return RatingKey.Outdated;
        break;
      case 7:
        return RatingKey.Scam;
        break;
      case 8:
        return RatingKey.Miscaptioned;
        break;
      case 9:
        return RatingKey.Rumour;
        break;
      case 10:
        return RatingKey.Unproven;
        break;
    }
  }
}



class RatingModel {
  IconData icon;
  int key;
  String label;
  Color activeColor;
  Color disabledColor;

  RatingModel({this.icon, this.key, this.label, this.activeColor, this.disabledColor = AppColors.grey});

  RatingModel.fromJson(Map<String, dynamic> json) {
    icon = json['Icon'];
    key = json['key'];
    activeColor = json['activeColor'];
    disabledColor = json['disabledColor'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Icon'] = this.icon;
    data['key'] = this.key;
    data['label'] = this.label;
    data['activeColor'] = this.activeColor;
    data['disabledColor'] = this.disabledColor;

    return data;
  }
}
