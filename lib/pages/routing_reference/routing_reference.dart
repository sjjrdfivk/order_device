import 'dart:math';
// import 'package:color_dart/color_dart.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:order_device/provider/order.dart';
import 'order.dart';

import 'shop/shop_scroll_coordinator.dart';
import 'shop/shop_scroll_controller.dart';

MediaQueryData mediaQuery;
double statusBarHeight;
double screenHeight;

class RoutingReference extends StatefulWidget {
  final String id;
  const RoutingReference({@required this.id, Key key}) : super(key: key);

  @override
  _RoutingReference createState() => _RoutingReference(id);
}

class _RoutingReference extends State<RoutingReference>
    with SingleTickerProviderStateMixin {
  ///页面滑动协调器
  ShopScrollCoordinator _shopCoordinator;
  ShopScrollController _pageScrollController;

  TabController _tabController;

  final double _sliverAppBarInitHeight = 250;
  final double _tabBarHeight = 50;
  double _sliverAppBarMaxHeight;

  final String id;
  _RoutingReference(this.id);

  @override
  void initState() {
    super.initState();
    _shopCoordinator = ShopScrollCoordinator();
    _tabController = TabController(vsync: this, length: 3);
    // _listScrollController.addListener(() {
    // int offset = _listScrollController.position.pixels.toInt();
    // print("滑动距离$offset");
    // });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _tabController?.dispose();
    _pageScrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery ??= MediaQuery.of(context);
    screenHeight ??= mediaQuery.size.height;
    statusBarHeight ??= mediaQuery.padding.top;

    _sliverAppBarMaxHeight ??= screenHeight;
    _pageScrollController ??= _shopCoordinator
        .pageScrollController(_sliverAppBarMaxHeight - _sliverAppBarInitHeight);

    _shopCoordinator.pinnedHeaderSliverHeightBuilder ??= () {
      return statusBarHeight + kToolbarHeight + _tabBarHeight;
    };
    // print('_sliverAppBarMaxHeight$_sliverAppBarMaxHeight');
    return Scaffold(
      body: Listener(
        onPointerUp: _shopCoordinator.onPointerUp,
        child: CustomScrollView(
          controller: _pageScrollController,
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              // title: Text("店铺首页", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue,
              expandedHeight: _sliverAppBarMaxHeight,
              actions: actionsHeaderRight(),
              flexibleSpace: FlexibleSpaceBar(
                background: sliverTopBar(),
              ),
            ),
            // 活动header
            // SliverPersistentHeader(
            //   pinned: false,
            //   floating: true,
            //   delegate: _SliverAppBarDelegate(
            //     maxHeight: 100,
            //     minHeight: 100,
            //     child: Center(child: Text("我是活动Header")),
            //   ),
            // ),
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: _SliverAppBarDelegate(
                maxHeight: _tabBarHeight,
                minHeight: _tabBarHeight,
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    labelColor: Colors.black,
                    controller: _tabController,
                    tabs: <Widget>[
                      Tab(text: "商品"),
                      Tab(text: "评价"),
                      Tab(text: "商家"),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  OrderPage(shopCoordinator: _shopCoordinator),
                  Text('data'),
                  Text('data1'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  var spanTextStyle = new TextStyle(
    color: Colors.black54,
    // fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
    fontSize: 11,
  );

  List<Widget> actionsHeaderRight() {
    return [
      IconButton(icon: Icon(Icons.search), onPressed: () {}),
      IconButton(icon: Icon(Icons.share), onPressed: () {}),
      IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
    ];
  }

  Container sliverTopBar() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 220,
            height: 150,
            width: mediaQuery.size.width,
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Oeschinen Lake Campground',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          '月销386',
                          style: spanTextStyle,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            '配送约30分钟',
                            style: spanTextStyle,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.red[500],
                          size: 12,
                        ),
                        Text(
                          '4.1',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.red[500],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      padding: EdgeInsets.fromLTRB(6, 0, 6, 2),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '美林假日第1名',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
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
                            padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              '80减20  |  60减10  |  20减2',
                              style: TextStyle(fontSize: 10, color: Colors.red),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              '新客减3',
                              style: TextStyle(fontSize: 10, color: Colors.red),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              '8折',
                              style: TextStyle(fontSize: 10, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        '公告：美林假日美食节!',
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    )
                  ],
                ),
              ),
              margin: EdgeInsets.only(left: 10, right: 10),
            ),
          ),
          Positioned(
            width: 50,
            height: 50,
            top: 210,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/swiper1.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => this.minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
