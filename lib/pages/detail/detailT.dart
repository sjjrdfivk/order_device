import 'package:flutter/material.dart';
import 'package:order_device/pages/detail/component/titleSection.dart';
import 'package:order_device/pages/detail/component/buttonSection.dart';
import 'package:order_device/pages/detail/component/textSection.dart';
import 'package:order_device/pages/detail/component/imageSection.dart';

class DetailPageT extends StatefulWidget {
  @override
  _DetailT createState() => _DetailT();
}

class _DetailT extends State<DetailPageT> {
  // bool _isFavorited = true;
  // int _favoriteCount = 41;

  // void _toggleFavorite() {
  //   setState(() {
  //     if (_isFavorited) {
  //       _favoriteCount -= 1;
  //       _isFavorited = false;
  //     } else {
  //       _favoriteCount += 1;
  //       _isFavorited = true;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          imageSection,
          titleSection,
          buttonSection,
          textSection,
          titleSection,
          buttonSection,
          textSection
        ],
      ),
    );
  }
}
