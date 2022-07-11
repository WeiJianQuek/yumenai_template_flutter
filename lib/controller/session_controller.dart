import 'package:flutter/material.dart';

import '../main.dart';
import '../route/controller/entry/splash_entry_controller_route.dart';

class SessionController {
  static SessionController setup() {
    return const SessionController._();
  }

  const SessionController._();

  Future<void> signOut(final BuildContext context) async {
    await service.storage.keyValue.clear();
    SplashEntryControllerRoute.navigate(context);
  }
}