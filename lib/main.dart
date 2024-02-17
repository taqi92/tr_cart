import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tr_cart/ui/splash_screen.dart';

import 'db_adapter/product_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  var path;

  final directory = await getApplicationDocumentsDirectory();

  path = directory.path;

  final hiveDirectory = Directory('$path/hive_data');


  Hive
    ..init(hiveDirectory.path)
    ..registerAdapter(ProductAdapter());

  runApp(
    EasyLocalization(
      path: 'assets/locales',
      supportedLocales: const [Locale('en', 'US'),],
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: EasyLoading.init(),
      theme: ThemeData(
        hintColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 1,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
