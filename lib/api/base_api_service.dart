import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gomemo/res/storage.dart';

class BaseApiService {
  Future<Map<String, String>> getHeaders(bool mustAuthenticated) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (mustAuthenticated) {
      debugPrint("Token added");

      try {
        // Retrieve the authentication token from secure storage
        SecureStorageHelper secureStorage = SecureStorageHelper();
        String? token = await secureStorage.read('access_token');
        debugPrint(token);

        headers['Authorization'] = 'Bearer $token';
      } catch (e) {
        return headers;
      }
    }
    return headers;
  }
}
