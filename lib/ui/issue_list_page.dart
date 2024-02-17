import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:tr_cart/ui/cart_screen.dart';
import 'package:tr_cart/ui/loading_view/all_campaign_shimmer.dart';
import 'package:tr_cart/ui/product_detail_page.dart';
import '../base/base_state.dart';
import '../components/button_component.dart';
import '../components/text_component.dart';
import '../controller/issue_controller.dart';
import '../gen/assets.gen.dart';
import '../utils/constants.dart';
import '../utils/style.dart';

class IssueListPage extends StatefulWidget {
  const IssueListPage({super.key});

  @override
  State<IssueListPage> createState() => _IssueListState();
}

class _IssueListState extends BaseState<IssueListPage> {
  final _productController = Get.put(IssueController());

  @override
  void initState() {


    isInternetConnected(context).then((internet) {
      if (internet) {
        _productController.getAllIssue();
      } else {
        _productController.getDataFromDb();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: 'Issues',
        isNavigate: false,
        actions: <Widget>[
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
        ],
      ),
      body: GetBuilder<IssueController>(
        builder: (controller) {
          var posts = controller.productList;

          if(controller.loading.value){

            return AllCampaignLoadingPage();

          }else{

            if (posts.isNotEmpty) {
              return LazyLoadScrollView(
                isLoading: controller.isLastPage,
                onEndOfPage: () {
                  controller.loadNextPage();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    childAspectRatio: 2 / 3,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children:
                    List.generate(controller.productList.length, (index) {
                      var item = posts[index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(() => const ProductDetailScreen(),
                              arguments: posts[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 1,
                            // Change this
                            shadowColor: kCardBackground,
                            // Change this
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0)),
                                    child: Container(
                                      color: Colors.white,
                                      child: item.image != null
                                          ? AspectRatio(
                                        aspectRatio: 3 / 2,
                                        child: Image.network(
                                          item.image!,
                                          //height: 100,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                          : AspectRatio(
                                        aspectRatio: 3 / 2,
                                        child: Image.asset(
                                          'assets/images/content_placeHolder.png',
                                          //height: 100,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0, top: 4.0),
                                  child: TextComponent(
                                    item.title ?? 'Sample Item',
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    padding: EdgeInsets.zero,
                                    fontSize: 16,
                                    fontWeight: titleFontWeight,
                                    isTranslatable: false,
                                  ),
                                ),
                                TextComponent(
                                  "\$${item.userId}0",
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  padding: const EdgeInsets.only(top: 4.0),
                                  color: kSecondaryColor,
                                  fontSize: k14FontSize,
                                  fontWeight: mediumFontWeight,
                                  isTranslatable: false,
                                ),
                                item.userId != 0
                                    ? Visibility(
                                  visible: item.isVisible,
                                  child: ButtonComponent(
                                    text: 'Add to Cart',
                                    fontSize: k13FontSize,
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    onPressed: () {
                                      setState(() {
                                        _productController.cartList
                                            .add(item);

                                        item.isVisible = !item.isVisible;
                                      });
                                    },
                                  ),
                                )
                                    : const TextComponent("Out of Stock",
                                    color: kErrorColor,
                                    padding: EdgeInsets.zero),
                                Visibility(
                                  visible: !item.isVisible,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                            flex: 1,
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
                                                    });

                                                    controller.updateQuantity(
                                                        item.id!, item.quantity);
                                                  }
                                                },
                                                child: SvgPicture.asset(
                                                    Assets.icons.iconMinus))),
                                        Expanded(
                                            flex: 2,
                                            child: TextComponent(
                                              item.quantity.toString(),
                                              maxLines: 1,
                                              fontWeight: boldFontWeight,
                                              fontSize: k13FontSize,
                                              isTranslatable: false,
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                                onTap: () {
                                                  if (item.quantity > 0) {
                                                    setState(() {
                                                      item.quantity != 0
                                                          ? item.quantity++
                                                          : null;
                                                    });

                                                    controller.updateQuantity(
                                                        item.id!, item.quantity);
                                                    //_productController.addInCart(productItem);
                                                  }
                                                },
                                                child: SvgPicture.asset(
                                                    Assets.icons.iconPlus))),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              );
            } else {
              return noDataFoundWidget(divider: 1.25);
            }

          }
        },
      ),
    );
  }
}
