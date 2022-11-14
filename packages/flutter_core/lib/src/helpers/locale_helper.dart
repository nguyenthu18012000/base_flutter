import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'shared_pref_helper.dart';

class LocaleHelper {
  LocaleHelper._();

  static LocaleHelper get instance => LocaleHelper._();
  static Locale locale = const Locale(LocaleConstants.japanese);

  bool isEnglish(BuildContext context) {
    final currentLocale = locale.toString();
    return currentLocale == LocaleConstants.english ||
        currentLocale == LocaleConstants.enUS;
  }

  List<Locale> get supportedLocales =>
      const [Locale(LocaleConstants.japanese), Locale(LocaleConstants.english)];

  Locale get fallbackLocale => const Locale(LocaleConstants.japanese);

  Future<Locale> getDefaultLocale() async {
    final cachedLocale =
        await SharePrefHelper.instance.getValue(key: PrefConstants.locale);
    final newLocale = Locale(cachedLocale ?? LocaleConstants.japanese);
    locale = newLocale;
    return newLocale;
  }

  void setDefaultLocale(BuildContext context, {required String localeString}) {
    SharePrefHelper.instance.setValue(localeString, key: PrefConstants.locale);
    final newLocale = Locale(localeString);
    locale = newLocale;
    context.setLocale(newLocale);
  }
}
