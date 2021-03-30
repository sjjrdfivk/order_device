import 'package:color_dart/color_dart.dart';
import 'package:flutter/material.dart';

import 'package:order_device/components/a_button/index.dart';
import 'package:order_device/route/navigator_util.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Container(
        color: hex('#fff'),
        padding: EdgeInsets.only(left: 35, right: 35, top: 87),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: 160,
              height: 144,
              child: Image.asset(
                'assets/images/heart_border.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  hintText: '请输入邮箱',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                ),
                onChanged: (e) {},
              ),
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                        hintText: "请输入验证码",
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                      onChanged: (e) {},
                    ),
                  ),
                  Container(
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(color: rgba(242, 242, 242, 1))),
                    ),
                  ),
                  buildGetEmailCode()
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              width: 350,
              child: TextButton(
                child: Text(
                  '登录',
                  style: TextStyle(fontSize: 20.0, color: hex('#fff')),
                ),
                style: TextButton.styleFrom(
                    primary: Colors.green,
                    backgroundColor: rgba(85, 122, 157, 1)),
                onPressed: () => NavigatorUtil.goBack(context),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "点击登录，即表示以阅读并同意",
                    style:
                        TextStyle(fontSize: 12, color: rgba(153, 153, 153, 1)),
                  ),
                  InkWell(
                    child: Text(
                      "《注册会员服务条款》",
                      style:
                          TextStyle(color: rgba(85, 122, 157, 1), fontSize: 12),
                    ),
                    onTap: () => NavigatorUtil.jump(context, '/user_agreement'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildGetEmailCode() {
    return Container(
      child: AButton.normal(
          child: Text("获取验证码"), color: rgba(85, 122, 157, 1), onPressed: () {}),
    );
  }
}
