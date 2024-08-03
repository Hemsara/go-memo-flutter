import 'package:gomemo/models/user/user.model.dart';

abstract class IUserRepository {
  Future<User> getCurrentUser();
}
