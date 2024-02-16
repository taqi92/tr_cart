import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../model/issue_response.dart';
import '../repositories/issue_repository.dart';
import '../utils/constants.dart';
import '../utils/endpoints.dart';

abstract class IssueRepositoryInterface {
  void getIssue();
}

class IssueController extends GetxController {
  late final IssueRepository _issueRepository;

  List<ProductResponse> productList = [];
  Set<String> labelList = {};
  List<ProductResponse> cartList = [];

  int pageNo = 1;
  bool isLastPage = false;

  var orderSubTotal = Rxn<int>();
  var orderFee = Rxn<double>();
  var orderSalesTax = Rxn<double>();
  var orderTotal = Rxn<int>();

  @override
  void onInit() {
    _issueRepository = IssueRepository();
    super.onInit();
  }

  Future<void> getAllIssue(
      {int pageSize = 20,
      bool isFromLoadNext = false,
      bool isLabeled = false}) async {
    if (!isFromLoadNext) {
      productList = [];
      pageNo = 1;
    }

    loading();

    late String url;

    //url = "${fetchListEndPoints}page=$pageNo&per_page=$pageSize";

    _issueRepository.getProduct(fetchListEndPoints, (response, error) {
      if (response != null) {
        var payload = response;

        for (var item in payload) {
          productList.add(item);
        }

        if (response.isEmpty) {
          isLastPage = true;
        }

        dismissLoading();
        update();
      } else {
        showMessage(error);
      }
    });
  }

  void loadNextPage() {
    if (!isLastPage) {
      pageNo++;
      getAllIssue(isFromLoadNext: true);
    }
  }

  void addLabelsToList(String input) {
    labelList.add(input);

    labelList.forEach((element) {
      log("label + $element");
    });

    getAllIssue(isLabeled: true);
  }

  void clearFilter() {
    labelList.clear();
    getAllIssue();
  }

  removeItem(int index) {
    cartList.removeAt(index);
    update();

    if (cartList.isEmpty) {
      clearCart();
    }

    getOrderTotal();

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
}
