import 'package:gomemo/res/storage.dart';

class TokenResponse {
  final String accessToken;

  TokenResponse({required this.accessToken});

  Future saveTokens() async {
    await SecureStorageHelper().write("token", accessToken);
  }
}
