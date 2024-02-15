import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:tr_cart/ui/cart_screen.dart';
import 'package:tr_cart/ui/product_detail_page.dart';
import '../base/base_state.dart';
import '../components/button_component.dart';
import '../components/text_component.dart';
import '../controller/issue_controller.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
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
    _productController.getAllIssue();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Issues', isNavigate: false, actions: [
        IconButton(
            onPressed: () => Get.to(()=> CartScreen()),
            icon: const Icon(
              Icons.filter_alt_off,
              color: Colors.white,
            ))
      ]),
      body: GetBuilder<IssueController>(
        builder: (controller) {

          var posts = controller.productList;

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
                        Get.to(()=>const ProductDetailScreen(),arguments: posts[index]);
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
                              const SizedBox(
                                height: 12,
                              ),
                              ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      topLeft: const Radius.circular(10.0)),
                                  child: Container(
                                    color: Colors.white,
                                    child: item.image != null
                                        ? AspectRatio(
                                            aspectRatio: 3 / 2,
                                            child: Image.network(
                                              item.image!,
                                              //height: 100,
                                              //fit: BoxFit.fill,
                                            ),
                                          )
                                        : AspectRatio(
                                            aspectRatio: 3 / 2,
                                            child: Image.asset(
                                              'assets/images/content_placeHolder.png',
                                              //height: 100,
                                              //fit: BoxFit.fill,
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
                                  padding: const EdgeInsets.only(
                                      top: 0.0, bottom: 0.0, left: 0.0),
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
                                  ? ButtonComponent(
                                    text: 'Add to Cart',
                                    fontSize: k13FontSize,
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    onPressed: () {

                                      _productController.cartList.add(item);

                                    },
                                  )
                                  : const TextComponent("Out of Stock",
                                      color: kErrorColor,
                                      padding: EdgeInsets.zero),
                              /*Visibility(
                                visible: !productItem.isVisible,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  if (productItem.quantity <=
                                                      1) {
                                                    showMessage(
                                                        'Can\'t be lower than 1');
                                                  } else {
                                                    setState(() {
                                                      productItem.quantity !=
                                                              null
                                                          ? productItem
                                                              .quantity--
                                                          : null;
                                                    });

                                                    updateQuantity(
                                                        productItem.id,
                                                        productItem.quantity);

                                                    // _productController
                                                    //     .addInCart(
                                                    //         productItem);
                                                  }
                                                },
                                                child: SvgPicture.asset(
                                                    Assets.icons.iconMinus)),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: TextComponent(
                                            productItem.quantity.toString(),
                                            maxLines: 1,
                                            fontWeight: boldFontWeight,
                                            fontSize: smallestFontSize,
                                            isTranslatable: false,
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                              onTap: () {
                                                if (productItem.quantity > 0) {
                                                  setState(() {
                                                    productItem.quantity != null
                                                        ? productItem.quantity++
                                                        : null;
                                                  });

                                                  updateQuantity(productItem.id,
                                                      productItem.quantity);
                                                  //_productController.addInCart(productItem);
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                  Assets.icons.iconPlus))),
                                    ],
                                  ),
                                ),
                              ),*/
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
        },
      ),
    );
  }
}
