import 'dart:async';
// import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:order_device/utils/const_config.dart';
import 'package:order_device/utils/tool/perm_util.dart';

import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';

MediaQueryData mediaQuery;

class PayPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<PayPage> {
  Map<String, Object> _locationResult;

  StreamSubscription<Map<String, Object>> _locationListener;

  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();

  double latitude = 39.909187;
  double longitude = 116.397451;
  final Map<String, Marker> _initMarkerMap = <String, Marker>{};

  @override
  void initState() {
    super.initState();
    // _requestLocaitonPermission();

    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      setState(() {
        _locationResult = result;
        _locationResult.forEach((key, value) {
          if (key == 'latitude') {
            latitude = value;
          } else if (key == 'longitude') {
            longitude = value;
          }
        });
        _requestLocaitonPermission();
      });
    });
    _startLocation();
  }

  @override
  void reassemble() {
    super.reassemble();
    _requestLocaitonPermission();
  }

  void _requestLocaitonPermission() async {
    if (!(await PermUtil.locationPerm())) return; // 位置权限申请
    LatLng position = LatLng(latitude, longitude);
    Marker marker = Marker(position: position);
    _initMarkerMap[marker.id] = marker;
    _changeCameraPosition();
  }

  ///设置定位参数
  void _setLocationOption() {
    if (null != _locationPlugin) {
      AMapLocationOption locationOption = new AMapLocationOption();

      ///是否单次定位
      locationOption.onceLocation = true;

      ///是否需要返回逆地理信息
      locationOption.needAddress = true;

      ///逆地理信息的语言类型
      locationOption.geoLanguage = GeoLanguage.DEFAULT;

      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

      ///设置Android端连续定位的定位间隔
      locationOption.locationInterval = 20000;

      ///设置Android端的定位模式<br>
      ///可选值：<br>
      ///<li>[AMapLocationMode.Battery_Saving]</li>
      ///<li>[AMapLocationMode.Device_Sensors]</li>
      ///<li>[AMapLocationMode.Hight_Accuracy]</li>
      locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

      locationOption.desiredAccuracy = DesiredAccuracy.Best;

      ///将定位参数设置给定位插件
      _locationPlugin.setLocationOption(locationOption);
    }
  }

  ///开始定位
  void _startLocation() {
    if (null != _locationPlugin) {
      ///开始定位之前设置定位参数
      _setLocationOption();
      _locationPlugin.startLocation();
    }
  }

  ///停止定位
  // ignore: unused_element
  void _stopLocation() {
    if (null != _locationPlugin) {
      _locationPlugin.stopLocation();
    }
  }

  @override
  void dispose() {
    super.dispose();

    ///移除定位监听
    if (null != _locationListener) {
      _locationListener.cancel();
    }

    ///销毁定位
    if (null != _locationPlugin) {
      _locationPlugin.destroy();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      apiKey: ConstConfig.amapApiKeys,
      markers: Set<Marker>.of(_initMarkerMap.values),
      touchPoiEnabled: true,
      onMapCreated: onMapCreated,
    );
    mediaQuery ??= MediaQuery.of(context);

    return Scaffold(
      body: Listener(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              // title: Text("店铺首页", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(child: map),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (c, i) => Column(
                          children: [
                            Container(
                              child: Card(
                                margin: EdgeInsets.only(
                                    right: 12, left: 12, top: 10, bottom: 0),
                                child: Container(
                                  height: 300,
                                ),
                              ),
                            ),
                            Container(
                              child: Card(
                                margin: EdgeInsets.only(
                                    right: 12, left: 12, top: 10, bottom: 0),
                                child: Container(
                                  height: 300,
                                ),
                              ),
                            ),
                            Container(
                              child: Card(
                                margin: EdgeInsets.only(
                                    right: 12, left: 12, top: 10, bottom: 0),
                                child: Container(
                                  height: 300,
                                ),
                              ),
                            ),
                          ],
                        ),
                    childCount: 1))
          ],
        ),
      ),
    );
  }

  AMapController _mapController;
  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
      _changeCameraPosition();
    });
  }

  void _changeCameraPosition() {
    _mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            //中心点
            target: LatLng(latitude, longitude),
            //缩放级别
            zoom: 16,
            //俯仰角0°~45°（垂直与地图时为0）
            tilt: 40,
            //偏航角 0~360° (正北方为0)
            bearing: 0),
      ),
      animated: true,
    );
  }
}
