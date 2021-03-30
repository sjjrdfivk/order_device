import 'package:flutter/material.dart';
import 'package:order_device/route/navigator_util.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fluro'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              MaterialButton(
                child: Text(
                  '正常路由跳转',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                minWidth: 300.0,
                height: 50.0,
                color: Colors.blueAccent,
                onPressed: () => NavigatorUtil.jump(context, '/normalPage'),
              ),
              SizedBox(height: 10.0),
              MaterialButton(
                child: Text(
                  '路由传参：200',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                minWidth: 300.0,
                height: 50.0,
                color: Colors.blueAccent,
                onPressed: () =>
                    NavigatorUtil.jump(context, '/routingReference?id=200'),
              ),
              SizedBox(height: 10.0),
              MaterialButton(
                child: Text(
                  '跳转登陆页并删除当前路由',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                minWidth: 300.0,
                height: 50.0,
                color: Colors.blueAccent,
                onPressed: () => NavigatorUtil.goToLoginRemovePage(context),
              ),
              SizedBox(height: 10.0),
              MaterialButton(
                child: Text(
                  '跳转登陆页',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                minWidth: 300.0,
                height: 50.0,
                color: Colors.blueAccent,
                onPressed: () => NavigatorUtil.jump(context, '/login'),
              ),
              SizedBox(height: 10.0),
              MaterialButton(
                child: Text(
                  '跳转详情测试',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                minWidth: 300.0,
                height: 50.0,
                color: Colors.blueAccent,
                onPressed: () => NavigatorUtil.jump(context, '/detailT'),
              ),
              SizedBox(height: 10.0),
              MaterialButton(
                child: Text(
                  '测试列表',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                minWidth: 300.0,
                height: 50.0,
                color: Colors.blueAccent,
                onPressed: () => NavigatorUtil.jump(context, '/list_test_page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
