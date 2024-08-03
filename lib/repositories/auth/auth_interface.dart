import 'package:gomemo/api/dto/auth/login.dto.dart';

abstract class IAuthRepository {
  Future<TokenResponse> loginUser(LoginDTO dto);
  Future<Uri> grantGoogleAccess();
}
