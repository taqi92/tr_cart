enum Environment {
  STAGING,
  PRODUCTION,
}

const Environment activeProfile = Environment.PRODUCTION;

String getBaseUrl() {
  switch (activeProfile) {
    case Environment.STAGING:
      return "https://jsonplaceholder.org";

    case Environment.PRODUCTION:
      return "https://jsonplaceholder.org";
  }
}

enum HttpMethod {
  GET,
  POST,
  PUT,
}

