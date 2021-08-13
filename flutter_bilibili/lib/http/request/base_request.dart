enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  String authority() {
    return 'api.devio.org';
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    ///http 和 https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  ///添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {
    "course-flag": 'fa',
    "auth-token":
        "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa"
  };

  ///添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
