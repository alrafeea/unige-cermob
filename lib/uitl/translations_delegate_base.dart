import 'dart:async';

import 'package:certifyapp/config/localized_values.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

class TranslationBase {
  TranslationBase(this.locale);

  final Locale locale;

  static TranslationBase of(BuildContext context) {
    return Localizations.of<TranslationBase>(context, TranslationBase);
  }

  String get dashboardScreenToolbarTitle =>
      localizedValues['dashboardScreenToolbarTitle'][locale.languageCode];

  String get settings => localizedValues['settings'][locale.languageCode];

  String get language => localizedValues['language'][locale.languageCode];

  String get lanEnglish => localizedValues['lanEnglish'][locale.languageCode];

  String get lanArabic => localizedValues['lanArabic'][locale.languageCode];

  String get cancel => localizedValues['cancel'][locale.languageCode];

  String get done => localizedValues['done'][locale.languageCode];

  String get home => localizedValues['home'][locale.languageCode];

  String get services => localizedValues['services'][locale.languageCode];

  String get mySchedule => localizedValues['mySchedule'][locale.languageCode];

  String get replay2 => localizedValues['replay2'][locale.languageCode];

  String get logout => localizedValues['logout'][locale.languageCode];


}

class TranslationBaseDelegate extends LocalizationsDelegate<TranslationBase> {
  const TranslationBaseDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<TranslationBase> load(Locale locale) {
    return SynchronousFuture<TranslationBase>(TranslationBase(locale));
  }

  @override
  bool shouldReload(TranslationBaseDelegate old) => false;
}
