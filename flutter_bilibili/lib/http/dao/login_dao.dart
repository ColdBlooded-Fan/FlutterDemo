import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/login_request.dart';
import 'package:flutter_bilibili/http/request/register_request.dart';

class LoginDao {
  static login(String username, String password) {
    return _send(username, password);
  }

  static register(
      String username, String password, String imoocId, String orderId) {
    return _send(username, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String username, String password, {imoocId, orderId}) async {
    BaseRequest request;

    if (imoocId != null && orderId != null) {
      request = RegisterRequest();
    } else {
      request = LoginRequest();
    }
    request.add("userName", username);
    request.add("password", password);
    request.add("imoocId", imoocId);
    request.add("orderId", orderId);



    var result = await HiNet.getInstance().fire(request);
  }
}
