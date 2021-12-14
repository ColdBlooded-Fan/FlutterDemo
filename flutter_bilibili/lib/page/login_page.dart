import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/util/string_util.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/login_button.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;

  String userName;
  String passWord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("密码登录", "注册", () {}),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(
              protect: protect,
            ),
            LoginInput(
              "用户名",
              "请输出用户名",
              onchanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              "密码",
              "请输出密码",
              onchanged: (text) {
                passWord = text;
                checkInput();
              },
              obscureText: true,
              foucChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: LoginButton(
                  title: '登录',
                  enable: loginEnable,
                  onPressed: send,
                ))
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(passWord)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  void send()async {
    try {
      var result =
          await LoginDao.login(userName, passWord);
      if (result['code'] == 0) {
        print('登录成功');
        showToast('登录成功');
      } else {
        print(result['msg']);
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {}
  }
}
