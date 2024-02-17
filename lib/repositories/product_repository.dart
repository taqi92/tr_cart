import 'dart:developer';

import '../../utils/constants.dart';
import '../model/product_response.dart';
import '../network/api_client.dart';
import '../utils/helper.dart';

class ProductRepository {
  final ApiClient _apiClient = ApiClient.apiClient;
  static final ProductRepository _productRepository = ProductRepository._internal();

  ProductRepository._internal();

  factory ProductRepository() {
    return _productRepository;
  }

  void getProduct(
      String url, ResponseCallback<List<ProductResponse>?, String?> callback) {
    _apiClient.getRequest(url, (response, error) {
      if (response != null) {

        List<ProductResponse> issues = getItemsFromJson(response, (x) => ProductResponse.fromJson(x));

        callback(issues, null);

      } else {
        callback(null, error);
      }
    });
  }
}
