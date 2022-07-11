import '../service/storage_service.dart';

class ServiceController {
  static Future<ServiceController> setup() async {
    return ServiceController._(
      storage: await StorageService.setup(),
    );
  }

  final StorageService storage;

  const ServiceController._({
    required this.storage,
  });
}