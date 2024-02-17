import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/style.dart';

class AllCampaignLoadingPage extends StatefulWidget {
  @override
  _AllCampaignLoadingPageState createState() => _AllCampaignLoadingPageState();
}

class _AllCampaignLoadingPageState extends State<AllCampaignLoadingPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[300]!,
        enabled: _enabled,
        child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          childAspectRatio: 2 / 3,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: List.generate(100, (index) {
            return const Padding(
              padding: EdgeInsets.all(4.0),
              child: Card(
                elevation: 1,
                // Change this
                shadowColor: kCardBackground,
                // Change this
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            );
          }),
        ) /*ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 0,bottom: 2.0),
                  child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        side:
                        const BorderSide(color: kCardBorderColor, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        height: SizeConfig.getScreenHeight(context) / 2.5,
                        width:  SizeConfig.getScreenWidth(context),
                      )),
                )
              )
            ],
          ),
        ),
        itemCount:100,
      ),*/
        );
  }
}
