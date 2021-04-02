import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:flutter/material.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
// import 'package:amap_location/amap_location.dart';

import 'package:order_device/utils/const_config.dart';
import 'package:order_device/utils/tool/perm_util.dart';

class PayPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<PayPage> {
  static final LatLng mapCenter =
      const LatLng(22.569924150077508, 113.3461320322406);
  final Map<String, Marker> _initMarkerMap = <String, Marker>{};

  @override
  void initState() {
    super.initState();
    _requestLocaitonPermission();
  }

  @override
  void reassemble() {
    super.reassemble();
    _requestLocaitonPermission();
  }

  void _requestLocaitonPermission() async {
    if (!(await PermUtil.locationPerm())) return; // 权限申请
    LatLng position = LatLng(mapCenter.latitude, mapCenter.longitude);
    Marker marker = Marker(position: position);
    _initMarkerMap[marker.id] = marker;
    // PermissionStatus status = await Permission.location.request();
    // print('permissionStatus=====> $status');
    _changeCameraPosition();
  }

  @override
  void dispose() {
    super.dispose();
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
