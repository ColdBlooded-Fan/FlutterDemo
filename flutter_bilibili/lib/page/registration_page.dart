import 'package:flutter/material.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool protect = false;
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
            LoginEffect(
              protect: protect
            ),
            LoginInput(
              "用户名",
              "请输入用户名",
              onchanged: (text) {
                print(">>" + text);
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              lineStrenth: true,
              obscureText: true,
              onchanged: (text) {
                print(">>" + text);
              },
              foucChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
