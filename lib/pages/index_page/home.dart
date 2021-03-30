import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:order_device/components/custom_swiper/index.dart';
import 'package:order_device/route/navigator_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  Color color = Colors.blue[300];
  var spanTextStyle = new TextStyle(
    color: Colors.black,
    // fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
    fontSize: 10,
  );

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
              // body = CupertinoActivityIndicator() as Widget;
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
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: CustomSwiper(
                          [
                            'assets/images/swiper1.jpg',
                            'assets/images/swiper2.jpg',
                            'assets/images/swiper3.jpg',
                          ],
                          // 屏幕高度
                          height: MediaQuery.of(context).size.height > 800
                              ? 288
                              : 208,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButtonColumn(color, Icons.call, 'CALL'),
                        buildButtonColumn(color, Icons.near_me, 'ROUTE'),
                        buildButtonColumn(color, Icons.share, 'SHARE'),
                        buildButtonColumn(color, Icons.monitor, 'monitor'),
                        buildButtonColumn(color, Icons.monitor, 'monitor'),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButtonColumn(color, Icons.call, 'CALL'),
                        buildButtonColumn(color, Icons.near_me, 'ROUTE'),
                        buildButtonColumn(color, Icons.share, 'SHARE'),
                        buildButtonColumn(color, Icons.monitor, 'monitor'),
                        buildButtonColumn(color, Icons.monitor, 'monitor'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (c, i) => Card(
                  margin:
                      EdgeInsets.only(right: 12, left: 12, top: 10, bottom: 0),
                  child: InkWell(
                    child: buildRowList(c, i),
                    onTap: () {
                      NavigatorUtil.jump(
                          context, '/routingReference?id=${items[i]}');
                    },
                    splashColor: Colors.red[50],
                  ),
                ),
                childCount: items.length,
              ),
            )
          ],
        ),
      ),
    );
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

  Row buildRowList(c, i) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Container(
            margin: EdgeInsets.all(10),
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/swiper1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 8,
                ),
                child: Text(
                  'Oeschinen Lake Campground${items[i]}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.red[500],
                          ),
                          Text(
                            '4.1',
                            style: TextStyle(
                              color: Colors.red[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            '30分钟',
                            style: spanTextStyle,
                          ),
                          SizedBox(width: 14), // 50宽度
                          Text(
                            '4.1km',
                            style: spanTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        '人均45',
                        style: spanTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '80减4',
                        style: TextStyle(fontSize: 10, color: Colors.red),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '8折',
                        style: TextStyle(fontSize: 10, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ],
    );
  }
}

// class CupertinoActivityIndicator {}
