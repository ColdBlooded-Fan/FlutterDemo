import 'package:flutter/material.dart';

//登录输入框 自定义widget
class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String> onchanged;
  final ValueChanged<bool> foucChanged;
  final bool lineStrenth;
  final bool obscureText;
  final TextInputType keboardType;

  const LoginInput(this.title, this.hint,
      {Key key,
      this.onchanged,
      this.foucChanged,
      this.lineStrenth = false,
      this.obscureText = false,
      this.keboardType})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //是否获取光标 todo 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
    _focusNode.addListener(() {
    print("has focus:${_focusNode.hasFocus}");
      if (widget.foucChanged != null) {
        widget.foucChanged(_focusNode.hasFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 15),
                  width: 100,
                  child: Text(widget.title, style: TextStyle(fontSize: 16))),
              _input()
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: !widget.lineStrenth ? 15 : 0),
            child: Divider(
              height: 1,
              thickness: 0.5,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onchanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keboardType,
      autofocus: !widget.obscureText,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
          contentPadding:EdgeInsets.only(left: 20, right: 20),
          border: InputBorder.none,
          hintText: widget.hint ?? '',
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    ));
  }
}
