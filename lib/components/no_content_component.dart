import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../utils/size_config.dart';
import '../utils/style.dart';

class NoContentComponent extends StatelessWidget {

  const NoContentComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: SizeConfig.getScreenHeight(context),
        width: SizeConfig.getScreenWidth(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(Assets.images.noContent.path),
        ),
      ),
    );
  }
}
