import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/app_controller.dart';
import 'view/template/app_template_view.dart';

late final AppController app;

ResourceApp get resource => app.resource;

ServiceApp get service => app.service;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Disable landscape mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  app = await AppController.setup();

  runApp(
    AppTemplateView(
      appController: app,
    ),
  );
}
