import 'dart:developer';

import '../../utils/constants.dart';
import '../model/issue_response.dart';
import '../network/api_client.dart';
import '../utils/helper.dart';

class IssueRepository {
  final ApiClient _apiClient = ApiClient.apiClient;
  static final IssueRepository _issueRepository = IssueRepository._internal();

  IssueRepository._internal();

  factory IssueRepository() {
    return _issueRepository;
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
