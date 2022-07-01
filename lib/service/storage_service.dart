import 'storage/key_value_storage_service.dart';

class StorageService {
  static Future<StorageService> setup() async {
    return StorageService._(
      keyValue: await KeyValueStorageService.setup(),
    );
  }

  final KeyValueStorageService keyValue;

  const StorageService._({
    required this.keyValue,
  });
}