import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class secureStorage {
  final storage = const FlutterSecureStorage();

  final String _keyId = 'id';
  final String _keyToken = 'token';

  Future<void> setId(String id) async {
    // print("Id" + id);
    await storage.write(key: _keyId, value: id);
  }

  Future<String?> getId() async {
    String? ID = await storage.read(key: _keyId) ?? "";
    // print(ID);
    return ID;
  }

  Future<void> setToken(String token) async {
    // print("Token" + token);
    await storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    String? to = await storage.read(key: _keyToken) ?? "";
    // print(to);

    return to;
  }

  Future<void> deleteToken() async {
    await storage.delete(key: _keyToken);
  }

  Future<void> deleteId() async {
    await storage.delete(key: _keyId);
  }
}
