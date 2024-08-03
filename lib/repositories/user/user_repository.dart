import 'package:gomemo/api/api_service.dart';
import 'package:gomemo/api/endpoints.dart';
import 'package:gomemo/models/api/response.dart';
import 'package:gomemo/models/user/user.model.dart';
import 'package:gomemo/repositories/user/user_interface.dart';

class UserRepository extends IUserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  @override
  Future<User> getCurrentUser() async {
    try {
      ApiResponse response =
          await _apiService.sendRequest(endpoint: EndPoints.profile);

      var data = response.data["data"]["profile"];

      return User(
          id: 0, //for now
          fullName: data["FullName"],
          email: data["Email"],
          isGoogleAuthenticated: data["IsLinkedWithGoogle"]);
    } catch (err) {
      rethrow;
    }
  }
}
