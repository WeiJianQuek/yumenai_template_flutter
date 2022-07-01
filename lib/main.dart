import 'package:flutter/material.dart';

import 'controller/app_controller.dart';
import 'view/template/app_template_view.dart';

final app = AppController();

ResourceApp get resource {
  return app.resource;
}

void main() {
  runApp(
    AppTemplateView(
      appController: app,
    ),
  );
}
