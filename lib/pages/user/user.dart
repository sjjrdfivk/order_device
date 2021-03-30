import 'package:flutter/material.dart';

// import 'package:order_device/components/custom_swiper/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  Color color = Colors.blue[300];

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("上拉加载");
            } else if (mode == LoadStatus.loading) {
              // body =  CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败！点击重试！");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("松手,加载更多!");
            } else {
              body = Text("没有更多数据了!");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
          itemExtent: 100.0,
          itemCount: items.length,
        ),
      ),
    );
    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       Stack(
    //         children: [
    //           Positioned(
    //             child: CustomSwiper(
    //               [
    //                 'assets/images/swiper1.jpg',
    //                 'assets/images/swiper2.jpg',
    //                 'assets/images/swiper3.jpg',
    //               ],
    //               // 屏幕高度
    //               height: MediaQuery.of(context).size.height > 800 ? 288 : 208,
    //             ),
    //           ),
    //         ],
    //       ),
    //       Container(
    //         padding: EdgeInsets.only(top: 30),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             buildButtonColumn(color, Icons.call, 'CALL'),
    //             buildButtonColumn(color, Icons.near_me, 'ROUTE'),
    //             buildButtonColumn(color, Icons.share, 'SHARE'),
    //             buildButtonColumn(color, Icons.monitor, 'monitor'),
    //           ],
    //         ),
    //       ),
    //       Container(
    //         padding: EdgeInsets.only(top: 30),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             buildButtonColumn(color, Icons.call, 'CALL'),
    //             buildButtonColumn(color, Icons.near_me, 'ROUTE'),
    //             buildButtonColumn(color, Icons.share, 'SHARE'),
    //             buildButtonColumn(color, Icons.monitor, 'monitor'),
    //           ],
    //         ),
    //       ),
    //       Container()
    //     ],
    //   ),
    // );
  }

  Column buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class CupertinoActivityIndicator {}
