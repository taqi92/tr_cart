import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../base/base_state.dart';
import '../../gen/assets.gen.dart';
import '../../utils/constants.dart';
import 'package:get/get.dart';

import '../utils/style.dart';
import 'product_list_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    isInternetConnected(context).then((internet) {
      if (internet) {
        // Internet Present Case

        proceed();
      } else {
        // No-Internet Case

        showWarningDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.images.appLogo.path,
                fit: BoxFit.fill,
                height: 100,
                width: 100,
              ),
              Image.asset(Assets.images.splashLoader.path),
            ],
          ),
        ));
  }

  showWarningDialog(BuildContext context) {
    Widget continueButton = TextButton(
      child: const Text("Retry"),
      onPressed: () {
        Navigator.pop(context);
        isInternetConnected(context).then((internet) {
          internet ? proceed() : showWarningDialog(context);
        });
      },
    );

    Widget cancelButton = TextButton(
      child: const Text("Exit"),
      onPressed: () => Platform.isAndroid ? SystemNavigator.pop() : exit(0),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: const Text("No Internet connection!"),
                content:
                    const Text("Please connect your device to the internet."),
                actions: [cancelButton, continueButton],
              )
            : AlertDialog(
                elevation: 2,
                title: const Text("No Internet connection!"),
                content:
                    const Text("Please connect your device to the internet."),
                actions: [cancelButton, continueButton],
              );
      },
    );
  }

  void proceed() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Get.offAll(() => const ProductListPage(), transition: sendTransition);
    });
  }
}
