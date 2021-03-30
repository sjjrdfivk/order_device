import 'package:flutter/material.dart';
import 'package:order_device/pages/detail/component/buildButtonColumn.dart';

Color color = Colors.blue[300];
Widget buttonSection = Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      buildButtonColumn(color, Icons.call, 'CALL'),
      buildButtonColumn(color, Icons.near_me, 'ROUTE'),
      buildButtonColumn(color, Icons.share, 'SHARE'),
    ],
  ),
);
