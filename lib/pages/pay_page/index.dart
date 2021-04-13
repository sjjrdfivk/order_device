import 'dart:async';
import 'dart:convert';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:flutter/material.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
// import 'package:amap_location/amap_location.dart';

import 'package:order_device/utils/const_config.dart';
import 'package:order_device/utils/tool/perm_util.dart';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';

class PayPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<PayPage> {
  Map<String, Object> _locationResult;

  StreamSubscription<Map<String, Object>> _locationListener;

  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();

  // static final LatLng mapCenter =
  //     const LatLng(22.569924150077508, 113.3461320322406);
  double latitude = 22.569924150077508;
  double longitude = 113.34614305287913;
  final Map<String, Marker> _initMarkerMap = <String, Marker>{};

  @override
  void initState() {
    super.initState();
    _requestLocaitonPermission();

    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      setState(() {
        _locationResult = result;
        Object mapToStr = json.encode(result);
        // print('_locationResult_locationResult${mapToStr.callbackTime}');
        // latitude = double.parse(result.latitude);
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
    // PermissionStatus status = await Permission.location.request();
    // print('permissionStatus=====> $status');
    _changeCameraPosition();
  }

  ///设置定位参数
  void _setLocationOption() {
    if (null != _locationPlugin) {
      AMapLocationOption locationOption = new AMapLocationOption();

      ///是否单次定位
      locationOption.onceLocation = false;

      ///是否需要返回逆地理信息
      locationOption.needAddress = true;

      ///逆地理信息的语言类型
      locationOption.geoLanguage = GeoLanguage.DEFAULT;

      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

      ///设置Android端连续定位的定位间隔
      locationOption.locationInterval = 2000;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('PayPage'),
        centerTitle: true,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: map,
            ),
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
            target: LatLng(22.569924150077508, 113.3461320322406),
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
