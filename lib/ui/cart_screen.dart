import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:tr_cart/controller/product_controller.dart';
import '../../base/base_state.dart';
import '../components/button_component.dart';
import '../components/text_component.dart';
import '../gen/assets.gen.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../utils/style.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends BaseState<CartScreen> {
  final borderRadius = BorderRadius.circular(15.0); // Image border


  final _productController = Get.put(ProductController());

  @override
  void initState() {
    // TODO: implement initState

    _productController.getOrderTotal();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCardBackground,
      appBar: myAppBar(title: 'Cart', actions: <Widget>[
        GestureDetector(
          onTap: () {
            _clearCartAlertDialog();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(Assets.icons.trash),
          ),
        )
      ]),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: SizedBox(
                height: SizeConfig.getScreenHeight(context) / 2,
                child: GetBuilder<ProductController>(builder: (controller) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _productController.cartList.length,
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var item = _productController.cartList[index];

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          // Border width
                                          decoration: BoxDecoration(
                                              color: Colors.white54,
                                              borderRadius: borderRadius),
                                          child: ClipRRect(
                                            borderRadius: borderRadius,
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(36),
                                              // Image radius
                                              child: item.image != null
                                                  ? AspectRatio(
                                                      aspectRatio: 1 / 1,
                                                      child: Image.network(
                                                          item.image!,
                                                          fit: BoxFit.fill),
                                                    )
                                                  : AspectRatio(
                                                      aspectRatio: 1 / 1,
                                                      child: Image.asset(
                                                          'assets/images/content_placeHolder_43.png',
                                                          fit: BoxFit.fill),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextComponent(
                                            item.title,
                                            maxLines: 3,
                                            fontSize: textSmallFontSize,
                                            fontWeight: titleFontWeight,
                                            isTranslatable: false,
                                            textAlign: TextAlign.start,
                                            padding: const EdgeInsets.only(
                                                left: 16.0,
                                                top: 4.0,
                                                bottom: 4.0,
                                                right: 8.0),
                                          ),
                                          TextComponent("\$${item.userId}0",
                                              fontSize: 14,
                                              fontWeight: titleFontWeight,
                                              color: kSecondaryColor,
                                              isTranslatable: false,
                                              padding: const EdgeInsets.only(
                                                  left: 16.0, top: 0.0,bottom: 4.0)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 24.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              _productController
                                                  .removeItem(index);

                                              showMessage("Item Has removed",
                                                  isToast: true);
                                            },
                                            child: SvgPicture.asset(
                                                Assets.icons.trash),
                                          ),
                                        ))),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            if (item.quantity <= 1) {
                                              showMessage(
                                                  'Can\'t be lower than 1');
                                            } else {
                                              setState(() {
                                                item.quantity != 0
                                                    ? item.quantity--
                                                    : null;

                                                //_productController.addProductToCart();

                                                updateQuantity(item.id!, item.quantity);
                                              });
                                            }
                                          },
                                          child: SvgPicture.asset(
                                              Assets.icons.iconMinus)),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: TextComponent(
                                        item.quantity.toString(),
                                        maxLines: 1,
                                        fontWeight: boldFontWeight,
                                        fontSize: k13FontSize,
                                        padding: EdgeInsets.all(0.0))),
                                Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                        onTap: () {
                                          if (item.quantity > 0) {
                                            setState(() {
                                              item.quantity != 0
                                                  ? item.quantity++
                                                  : null;

                                              //_productController.addProductToCart();

                                              updateQuantity(
                                                  item.id!, item.quantity);
                                            });
                                          }
                                        },
                                        child: SvgPicture.asset(
                                            Assets.icons.iconPlus))),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Divider(
                              height: 1,
                              color: kDashboardCardsTextColor.withOpacity(0.5),
                            ),
                          ],
                        );
                      });
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Wrap(
        alignment: WrapAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: Card(
                color: kCartCardBackgroundColor,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent('Order Summary',
                        fontWeight: boldFontWeight,
                        fontSize: k13FontSize,
                        padding:
                            EdgeInsets.only(left: 20, top: 16.0, bottom: 4.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          'Subtotal',
                          fontSize: 12,
                          fontWeight: regularFontWeight,
                          isTranslatable: false,
                        ),
                        Obx(() => TextComponent(
                            _productController.orderSubTotal.value != null
                                ? "\$${_productController.orderSubTotal.value}0"
                                : "0.00",
                            fontSize: k13FontSize,
                            fontWeight: mediumFontWeight),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          'Fees',
                          fontSize: 12,
                          fontWeight: regularFontWeight,
                          isTranslatable: false,
                        ),
                        TextComponent(
                          "0.00",
                          fontSize: k13FontSize,
                          fontWeight: mediumFontWeight,
                          isTranslatable: false,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          'Sales Tax',
                          fontSize: 12,
                          fontWeight: regularFontWeight,
                          isTranslatable: false,
                        ),
                        TextComponent(
                          "0.00",
                          fontSize: k13FontSize,
                          fontWeight: mediumFontWeight,
                          isTranslatable: false,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent(
                            'Total',
                            fontSize: 12,
                            fontWeight: regularFontWeight,
                            isTranslatable: false,
                          ),
                          Obx(
                            () => TextComponent(
                                _productController.orderTotal.value != null
                                    ? "\$${_productController.orderTotal.value}0"
                                    : "0.00",
                                fontSize: textSmallFontSize,
                                fontWeight: boldFontWeight),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ButtonComponent(
            text: 'Checkout',
            onPressed: () {},
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          )
        ],
      ),
    );
  }

  void updateQuantity(int id, int newQuantity) {
    for (var item in _productController.cartList) {
      if (item.id == id) {
        item.quantity = newQuantity;
        break;
      }
    }
    // Recalculate order total
    int newTotal = _productController.getOrderTotal();
  }

  void _clearCartAlertDialog() {
    Get.defaultDialog(
      title: "Cart Alert",
      textConfirm: "Remove",
      textCancel: "Cancel",
      radius: 14,
      content: const TextComponent(
        "Are sure you want to clear the cart?",
        textAlign: TextAlign.center,
      ),
      confirmTextColor: Colors.white,
      buttonColor: kPrimaryColor,
      cancelTextColor: kPrimaryColor,
      titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      contentPadding: const EdgeInsets.all(16),
      onConfirm: () {
        Navigator.pop(context);
        _productController.clearCart();
      },
    );
  }
}
