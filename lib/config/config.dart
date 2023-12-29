
import 'package:flutter/material.dart';

const MAX_SMALL_SCREEN = 660;

const BASE_URL = 'https://uat.hmgwebservices.com/Services';

const GET_PROJECT = '/Lists.svc/REST/GetProject';


class AppGlobal {
  static var context;
  static  LinearGradient linearGradient= LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xFFBF0053),
      Color(0xFF4F0127),
    ],
//  stops: [0.0, 1.0],
  );

}

