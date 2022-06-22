import 'package:flutter/material.dart';

import '../data/resource/image_resource_data.dart';

class ResourceController extends ChangeNotifier {
  ImageResourceData image;

  ResourceController()
      : image = const ImageResourceData.light();
}