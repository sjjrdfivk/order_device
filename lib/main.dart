import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
// import 'package:order_device/pages/index_page/index.dart';
import 'package:order_device/pages/index_page/navigation.dart';
import 'package:order_device/route/application.dart';
import 'package:order_device/route/route.dart';
import 'package:provider/provider.dart';
import 'package:order_device/provider/order.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OrderStore()),
          // Provider(create: (context) => SomeOtherClass()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //-----------------路由主要代码start
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
    //-----------------路由主要代码end

    return Container(
      child: MaterialApp(
        title: 'fluro',
        //-----------------路由主要代码start
        onGenerateRoute: Application.router.generator,
        //-----------------路由主要代码end
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color.fromARGB(255, 78, 79, 95),
        ),
        home: NavigationPage(),
      ),
    );
  }
}
