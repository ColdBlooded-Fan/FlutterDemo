import 'package:flutter_bilibili/http/core/hi_adapter.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

///测试适配器
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future<HiNetResponse>.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(data: {
        {"code": 0, "message": "success"}
      }, statusCode: 401);
    });
  }
}
