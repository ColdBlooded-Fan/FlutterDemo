import 'package:flutter_bilibili/http/request/base_request.dart';

class HiNet {
  HiNet._();

  static HiNet _instance;

  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance;
  }

  Future fire(BaseRequest request) async {
    var response = await send(request);
    var result = response["data"];
    printLog(result);

    return result;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog("url===${request.url()}");
    request.addHeader("token", "123");
    printLog("header===${request.header}");
    return Future.value({
      "statusCode": 200,
      "data": {"code": 0, "message": "success"}
    });
  }

  void printLog(log) {
    print("hi_net${log.toString()}");
  }
}
