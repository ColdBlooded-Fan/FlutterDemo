import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/util/string_util.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/login_button.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';

class Registration extends StatefulWidget {
  final VoidCallback onJumpToLogin;

  const Registration({Key key, this.onJumpToLogin}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool protect = false;
  bool loginEnable = false;

  String userName;
  String passWord;
  String resPassword;
  String imoocId;
  String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        print('right click');
      }),
      body: Container(
        child: ListView(
          //自适应键盘
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              "用户名",
              "请输入用户名",
              onchanged: (text) {
                print(">>" + text);
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              lineStrenth: true,
              obscureText: true,
              onchanged: (text) {
                print(">>" + text);
                passWord = text;
                checkInput();
              },
              foucChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              "确认密码",
              "请再次输入密码",
              lineStrenth: true,
              obscureText: true,
              onchanged: (text) {
                print(">>" + text);
                resPassword = text;
                checkInput();
              },
              foucChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              "慕课网ID",
              "请输入你的慕课网用户名ID",
              lineStrenth: true,
              obscureText: true,
              keboardType: TextInputType.number,
              onchanged: (text) {
                print(">>" + text);
                imoocId = text;
                checkInput();
              },
              foucChanged: (focus) {

              },
            ),
            LoginInput(
              "课程订单号",
              "请输入课程订单号后四位",
              keboardType: TextInputType.number,
              lineStrenth: true,
              obscureText: true,
              onchanged: (text) {
                print(">>" + text);
                orderId = text;
                checkInput();
              },
              foucChanged: (focus) {},
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton(
                title: '注册',
                enable: loginEnable,
                onPressed: checkParams,
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(passWord) &&
        isNotEmpty(resPassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return InkWell(
        onTap: () {
          if (loginEnable) {
            checkParams();
          } else {
            print("loginEnable is false");
          }
        },
        child: Text("注册"));
  }

  void send() async {
    try {
      var result =
          await LoginDao.register(userName, passWord, imoocId, orderId);
      if (result['code'] == 0) {
        print('注册成功');
        showToast('注册成功');
        if (widget.onJumpToLogin != null) {
          widget.onJumpToLogin();
        }
      } else {
        print('11' + result['msg']);
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    }
  }

  void checkParams() {
    String tips;
    if (passWord != resPassword) {
      tips = '两次密码不一致';
    } else if (orderId.length != 4) {
      tips = '请输出订单号的后四位';
    }

    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }
}
