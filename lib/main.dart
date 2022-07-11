import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/resource_controller.dart';
import 'controller/session_controller.dart';
import 'controller/service_controller.dart';
import 'view/template/app_template_view.dart';

late final ResourceController resource;

late final ServiceController service;

late final SessionController session;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Disable landscape mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  resource = ResourceController.setup();

  service = await ServiceController.setup();

  session = SessionController.setup();

  runApp(
    AppTemplateView(
      controller: resource,
    ),
  );
}
