import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:common_utils/common_utils.dart';
// import 'package:order_device/provider/order.dart';
// import 'package:flutter/scheduler.dart';

import 'shop/shop_scroll_controller.dart';
import 'shop/shop_scroll_coordinator.dart';
import 'order_data.dart';
import 'package:order_device/route/navigator_util.dart';

MediaQueryData mediaQuery;

class OrderPage extends StatefulWidget {
  final ShopScrollCoordinator shopCoordinator;

  const OrderPage({@required this.shopCoordinator, Key key}) : super(key: key);

  @override
  _OrderPage createState() => _OrderPage();
}

class _OrderPage extends State<OrderPage> {
  ShopScrollCoordinator _shopCoordinator;
  ShopScrollController _listScrollController1;
  ShopScrollController _listScrollController2;

  String totalPrice = '0';
  int activeIndex = 0;
  double itemRightHeight = 150;
  double stickyHeaderHegiht = 30;
  List<double> itemRightArr = [0]; // 计算每个块高度
  int count = 1;

  @override
  void initState() {
    // SchedulerBinding.instance.addPostFrameCallback((_) => {});
    _shopCoordinator = widget.shopCoordinator;
    _listScrollController1 = _shopCoordinator.newChildScrollController();
    _listScrollController2 = _shopCoordinator.newChildScrollController();
    listData
        .map((e) => (e['list'].length * itemRightHeight))
        .reduce((value, element) {
      itemRightArr.add(value + (count * stickyHeaderHegiht));
      count++;
      return value + element;
    });
    _listScrollController2.addListener(() {
      // 滚动高亮对应menu
      int offset = _listScrollController2.position.pixels.toInt();
      for (var i = 0; i < itemRightArr.length; i++) {
        if (offset >= itemRightArr[i] && itemRightArr[i + 1] >= offset) {
          if (activeIndex != i) {
            setState(() {
              activeIndex = i;
            });
          }
        }
      }
    });
    super.initState();
  }

  void changeActiveIndex(int index) {
    setState(() {
      activeIndex = index;
    });
    _listScrollController2.jumpTo(itemRightArr[index]);
  }

  void reduceChange(int index, int i) {
    var data = listData[index]['list'][i];
    double price = double.parse(data['price']);
    setState(() {
      if (int.parse(data['num']) <= 1) {
        data['num'] = '0';
      } else {
        data['num'] = (int.parse(data['num']) - 1).toString();
      }
      totalPrice =
          (NumUtil.getNumByValueDouble(double.parse(totalPrice) - price, 2))
              .toStringAsFixed(2);
    });
  }

  void addChange(int index, int i) {
    var data = listData[index]['list'][i];
    double price = double.parse(data['price']);
    setState(() {
      if (data['num'] != null) {
        data['num'] = (int.parse(data['num']) + 1).toString();
      } else {
        data['num'] = '1';
      }
      totalPrice =
          (NumUtil.getNumByValueDouble(double.parse(totalPrice) + price, 2))
              .toStringAsFixed(2);
    });
  }

  @override
  void dispose() {
    _listScrollController1?.dispose();
    _listScrollController2?.dispose();
    _listScrollController1 = _listScrollController2 = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery ??= MediaQuery.of(context);
    return Stack(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                physics: AlwaysScrollableScrollPhysics(),
                controller: _listScrollController1,
                itemExtent: 50.0,
                itemCount: listData.length,
                itemBuilder: (context, index) => Container(
                  child: InkWell(
                    onTap: () {
                      changeActiveIndex(index);
                    },
                    child: Material(
                      // elevation: 4.0,
                      // borderRadius: BorderRadius.circular(5.0),
                      color: index == activeIndex
                          ? Colors.white
                          : Colors.grey[200],
                      child: Center(
                        child: Text(listData[index]['title']),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                physics: AlwaysScrollableScrollPhysics(),
                controller: _listScrollController2,
                itemCount: listData.length,
                itemBuilder: (context, index) => StickyHeader(
                  header: Container(
                    height: stickyHeaderHegiht,
                    color: Colors.white70,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      listData[index]['title'],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  content: Container(
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemExtent: itemRightHeight,
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listData[index]['list'].length,
                      itemBuilder: (context, i) => Container(
                        child: listBuild(index, i),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        orderForm(context),
      ],
    );
  }

  var orderFormStyle = new TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );
  var radiusCon = Radius.circular(40);

  Positioned orderForm(context) {
    return Positioned(
      height: 60,
      width: mediaQuery.size.width,
      bottom: 10,
      child: Container(
        // width: mediaQuery.size.width,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    builder: (context) {
                      return Container(
                        height: 300,
                        child: Center(
                          child: Text('下单吧!'),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: radiusCon, bottomLeft: radiusCon),
                    color: Colors.black,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: Image.asset('assets/images/settle.png'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¥$totalPrice',
                            style: orderFormStyle,
                          ),
                          Text(
                            '预估配送费¥3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: radiusCon, bottomRight: radiusCon),
                  color: Colors.yellow,
                ),
                child: InkWell(
                  onTap: () {
                    NavigatorUtil.jump(context, '/payBuyPage');
                  },
                  child: Center(
                    child: Text(
                      '去结算',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row listBuild(int index, int i) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Container(
            margin: EdgeInsets.all(10),
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                listData[index]['list'][i]['img'],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Text(
                listData[index]['list'][i]['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '这是豆子，这是豆子，这是豆子',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ),
              Text(
                '月销：999',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '¥${listData[index]['list'][i]['price']}',
                    style: TextStyle(color: Colors.red[400]),
                  ),
                  Row(
                    children: [
                      if (listData[index]['list'][i]['num'] != null &&
                          int.parse(listData[index]['list'][i]['num']) >= 1)
                        IconButton(
                          icon: Icon(Icons.do_disturb_on_sharp),
                          onPressed: () {
                            reduceChange(index, i);
                          },
                        ),
                      if (listData[index]['list'][i]['num'] != null &&
                          int.parse(listData[index]['list'][i]['num']) >= 1)
                        Text(listData[index]['list'][i]['num'] ?? '0'),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () {
                          addChange(index, i);
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
