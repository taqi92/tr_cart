import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppTranslations {
  late Locale locale;
  static Map<dynamic, dynamic>? _localisedValues;

  AppTranslations({
    required this.locale,
  });

  static AppTranslations? of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  static Future<AppTranslations> load(Locale locale) async {
    AppTranslations appTranslations = AppTranslations(locale: locale);
    String jsonContent = await rootBundle.loadString("assets/locales/${locale.languageCode}-${locale.countryCode}.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale.languageCode;

  String text(String key) {
    return _localisedValues?[key] ?? "$key not found";
  }
}