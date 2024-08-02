import 'dart:convert';

import '../../../models/api/dto.dart';
import '../../../res/storage.dart';

class LoginDTO extends DTO {
  final String email;
  final String password;

  LoginDTO({
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  String toJson() => json.encode(toMap());
}

class TokenResponse {
  final String accessToken;

  TokenResponse({
    required this.accessToken,
  });

  static Future deleteTokens() async {
    await SecureStorageHelper().deleteAll();
  }

  Future saveTokens() async {
    await SecureStorageHelper().delete("access_token");
    await SecureStorageHelper().write("access_token", accessToken);
  }
}
