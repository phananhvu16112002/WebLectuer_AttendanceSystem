import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String> readSecureData(String key) async {
    // print('Key:$key');

    String value = await storage.read(key: key) ?? 'No Data Found';
    // print('Data read from secure storage:$key: $value');
    return value;
  }

  Future<void> deleteSecureData(String key) async {
    await storage.delete(key: key);
  }
}
