import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tr_cart/controller/issue_controller.dart';
import 'package:tr_cart/model/issue_response.dart';
import '../../base/base_state.dart';
import 'package:get/get.dart';

import '../../components/text_component.dart';
import '../../gen/assets.gen.dart';
import '../../utils/constants.dart';
import '../../utils/style.dart';
import '../components/button_component.dart';
import '../utils/size_config.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends BaseState<ProductDetailScreen> {
  ProductResponse? data;

  int? selectedRadio;
  var selectedItem;

  String? cardRadioGroupValue;
  int? cardIndex;
  final _productController = Get.put(IssueController());

  int? _selectedIndex;

  @override
  void initState() {
    // TODO: implement initState

    if (Get.arguments != null) {
      data = Get.arguments;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: myAppBar(title: "Product Detail", actions: <Widget>[
        GestureDetector(
          onTap: () {
            if (_productController.cartList.isNotEmpty) {
              Get.to(
                () => const CartScreen(),
                transition: sendTransition,
              )?.then((val) {
                if (val == true) {
                  _productController.getAllIssue();
                }
              });
            } else {
              showMessage('Cart is empty!');
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GetBuilder<IssueController>(builder: (controller) {
                return _productController.cartList.isNotEmpty
                    ? SvgPicture.asset(
                        Assets.icons.cartFull,
                        color: Colors.white,
                      )
                    : SvgPicture.asset(
                        Assets.icons.shoppingCart,
                        color: Colors.white,
                      );
              })),
        )
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      width: SizeConfig.getScreenWidth(context),
                      color: Colors.white,
                      child: data?.image != null
                          ? AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Image.network(
                                data!.image!,
                                fit: BoxFit.fill,
                              ),
                            )
                          : AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Image.asset(
                                'assets/images/content_placeHolder.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 8,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(
                        data?.title ?? 'Sample Item',
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        padding: const EdgeInsets.only(
                            top: 16.0, bottom: 0.0, left: 16.0),
                        fontSize: textFontSize,
                        fontWeight: mediumFontWeight,
                        isTranslatable: false,
                      ),
                      TextComponent(
                        "\$${data?.userId}0",
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                        color: kSecondaryColor,
                        fontSize: k13FontSize,
                        fontWeight: mediumFontWeight,
                        isTranslatable: false,
                      ),
                      TextComponent(
                        data?.content,
                        isTranslatable: false,
                        textAlign: TextAlign.justify,
                        color: kTextColor,
                        fontSize: k13FontSize,
                        fontWeight: regularFontWeight,
                        padding: EdgeInsets.all(16.0),
                      ),
                      const TextComponent(
                        "Quantity",
                        isTranslatable: false,
                        textAlign: TextAlign.justify,
                        color: kTextColor,
                        fontSize: textSmallFontSize,
                        fontWeight: mediumFontWeight,
                        padding: EdgeInsets.only(left: 16.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          width: SizeConfig.getScreenWidth(context) / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          if ((data?.quantity ?? 1) <= 1) {
                                            showMessage(
                                                'Can\'t be lower than 1');
                                          } else {
                                            setState(() {
                                              data?.quantity != null
                                                  ? data?.quantity--
                                                  : null;
                                            });

                                            _productController.updateQuantity(
                                                data!.id!, data?.quantity ?? 1);
                                          }
                                        },
                                        child: SvgPicture.asset(
                                            Assets.icons.iconMinus)),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: TextComponent(
                                    data?.quantity.toString(),
                                    maxLines: 1,
                                    fontWeight: boldFontWeight,
                                    fontSize: textSmallFontSize,
                                  )),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    if ((data?.quantity ?? 1) > 0) {
                                      setState(() {
                                        data?.quantity != null
                                            ? data?.quantity++
                                            : null;
                                      });

                                      _productController.updateQuantity(
                                          data!.id!, data?.quantity ?? 1);
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    Assets.icons.iconPlus,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: data?.userId != 0
          ? Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ButtonComponent(
                text: 'Add to Cart',
                onPressed: () {},
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      selectedItem = val;
    });
  }
}
