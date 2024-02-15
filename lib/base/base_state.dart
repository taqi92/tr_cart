import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../components/text_component.dart';
import '../utils/size_config.dart';
import '../utils/style.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  Text? _getTitle(String? title, bool isTranslatable) {
    if (title != null && title != "") {
      var textStyle = GoogleFonts.getFont(
        primaryFont,
        fontWeight: titleFontWeight,
        color: Colors.white,
        fontSize: titleFontSize,
      );

      if (isTranslatable) {
        return Text(
          title,
          style: textStyle,
        ).tr();
      } else {
        return Text(
          title,
          style: textStyle,
        );
      }
    }

    return null;
  }

  AppBar myAppBar({
    String? title,
    bool isNavigate = true,
    bool isCenterTitle = true,
    bool isTranslatable = true,
    bool backToProviderHome = false,
    bool backToCustomerHome = false,
    List<Widget>? actions,
  }) {
    return AppBar(
      elevation: isNavigate ? 1.4 : 0,
      iconTheme: const IconThemeData(color: kPrimaryColor),
      centerTitle: isCenterTitle,
      title: _getTitle(title, isTranslatable),
      backgroundColor: kPrimaryColor,
      shadowColor: Colors.transparent,
      leading: isNavigate
          ? GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
              ),
            )
          : null,
      actions: actions,
    );
  }

  void resetGetXValues(List<Rxn<dynamic>?>? args) {
    if (args != null) {
      for (var arg in args) {
        arg?.value = null;
      }
    }
  }

  bool isBlank(List<dynamic>? args) {
    if (args != null) {
      for (var arg in args) {
        if (arg == null) {
          return true;
        } else if (arg is String && arg.trim().isEmpty) {
          return true;
        }
      }
    }

    return false;
  }

  Widget noDataFoundWidget({
    String? message,
    double divider = 1,
  }) {
    return SizedBox(
      height: SizeConfig.getScreenHeight(context) / divider,
      width: SizeConfig.getScreenWidth(context),
      child: Center(
        child: TextComponent(
          message ?? "No data has found",
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
