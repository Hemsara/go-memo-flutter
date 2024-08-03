import 'package:gomemo/api/api_service.dart';
import 'package:gomemo/api/dto/auth/login.dto.dart';
import 'package:gomemo/api/endpoints.dart';
import 'package:gomemo/models/api/response.dart';
import 'package:gomemo/repositories/auth/auth_interface.dart';

class AuthRepository extends IAuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  @override
  Future<TokenResponse> loginUser(LoginDTO dto) async {
    try {
      ApiResponse response = await _apiService.sendRequest(
          endpoint: EndPoints.login.copyWithDTO(dto));

      return TokenResponse(accessToken: response.data["access_token"]);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<Uri> grantGoogleAccess() async {
    try {
      ApiResponse response =
          await _apiService.sendRequest(endpoint: EndPoints.grantGoogleAccess);

      return Uri.parse(response.data["data"]["google"]);
    } catch (err) {
      rethrow;
    }
  }
}
