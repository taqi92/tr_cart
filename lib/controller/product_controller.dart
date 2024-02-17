import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tr_cart/db_adapter/product_adapter.dart';
import '../model/product_response.dart';
import '../repositories/product_repository.dart';
import '../utils/constants.dart';
import '../utils/endpoints.dart';

abstract class ProductRepositoryInterface {
  void getIssue();
}

class ProductController extends GetxController {

  late final ProductRepository _productRepository;

  List<ProductResponse> productList = [];
  Set<String> labelList = {};
  List<ProductResponse> cartList = [];


  var orderSubTotal = Rxn<int>();
  var orderFee = Rxn<double>();
  var orderSalesTax = Rxn<double>();
  var orderTotal = Rxn<int>();

  final loading = false.obs;

  late Box<Product> productBox;

  List<Product> productDbList = [];

  @override
  void onInit() {
    _productRepository = ProductRepository();
    openDb();
    super.onInit();
  }

  Future<void> getProducts() async {

    loading.value = true;


    _productRepository.getProduct(fetchListEndPoints, (response, error) {
      if (response != null) {
        var payload = response;

        for (var item in payload) {
          productList.add(item);
        }

        dismissLoading();

        if(productList.isNotEmpty){

          storeLocalData();

        }

        loading.value = false;
        update();
      } else {
        loading.value = false;
        showMessage(error);
      }
    });
  }


  void clearFilter() {
    labelList.clear();
    getProducts();
  }



  removeItem(int index) {
    cartList.removeAt(index);
    update();

    if (cartList.isEmpty) {
      clearCart();
    }

    getOrderTotal();
  }

  checkout(){

    showMessage("Your Order has accepted!",isToast: true);

    Future.delayed(const Duration(milliseconds: 2000), () {

      clearCart();

    });

  }

  clearCart() {
    cartList.clear();
    cartList = [];
    update();

    orderSubTotal.value = 0;
    orderFee.value = 0.0;
    orderSalesTax.value = 0.0;
    orderTotal.value = 0;
    Get.back(result: true);

  }

  getOrderTotal() {
    int total = 0;
    for (var item in cartList) {
      total += item.userId! * item.quantity;
    }

    orderTotal.value = total;
    orderSubTotal.value = total;

    return orderTotal.value!;
  }

  void updateQuantity(int id, int newQuantity) {
    for (var item in cartList) {
      if (item.id == id) {
        item.quantity = newQuantity;
        break;
      }
    }

    getOrderTotal();
  }

  Future<void> openDb() async {
    productBox = await Hive.openBox<Product>('product');
  }

  void storeLocalData() {
    if (productList.isNotEmpty) {
      for (var element in productList) {
        productBox.put(
            element.id,
            Product(element.id, element.title, element.content, element.image,
                element.thumbnail, element.userId));
      }

      productDbList = productBox.values.toList();


    }
  }

  getDataFromDb(){

    if(productDbList.isNotEmpty){

      for (var element in productDbList) {

        log("data $element");

      }

      productList = productDbList.cast<ProductResponse>();

      loading.value = false;

    }else{

      loading.value = false;
      showMessage("no data");

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    closeDB();

    super.dispose();
  }

  Future<void> closeDB() async {
    await Hive.close();
  }
}
