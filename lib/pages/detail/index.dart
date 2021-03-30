import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({Key key, this.id}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        centerTitle: true,
      ),
    );
  }
}
