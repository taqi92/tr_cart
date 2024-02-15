List<T> getItemsFromJson<T>(dynamic body, T Function(dynamic) fromJson) {
  if (body is List) {
    return (body)
        .map((x) => fromJson(x))
        .toList();
  }

  return [];
}


//List<IssueResponse> issues = getItemsFromJson(body, (x) => IssueResponse.fromJson(x));