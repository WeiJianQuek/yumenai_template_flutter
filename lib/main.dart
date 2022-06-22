import 'package:flutter/material.dart';

import 'controller/resource_controller.dart';
import 'route/controller/entry/splash_entry_controller_route.dart';

final resource = ResourceController();

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Template',
      home: SplashEntryControllerRoute.screen(),
    ),
  );
}
