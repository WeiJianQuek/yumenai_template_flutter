import 'package:flutter/material.dart';

import '../../../view/template/screen_template_view.dart';
import '../../controller/entry/splash_entry_controller_route.dart';

class SplashEntryScreenRoute extends StatefulWidget {
  final SplashEntryControllerRoute controller;

  const SplashEntryScreenRoute({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SplashEntryScreenRoute> createState() => _SplashEntryScreenRouteState();
}

class _SplashEntryScreenRouteState extends State<SplashEntryScreenRoute> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.onInitialise(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView.avatar();
  }
}
