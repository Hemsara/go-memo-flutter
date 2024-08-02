import 'package:gomemo/models/api/endpoint.dart';

import 'dto/auth/login.dto.dart';

class EndPoints {
  static String baseURL = "https://dev-api.medlearning.io";

  // * Auth routes
  static Endpoint<LoginDTO> login = Endpoint(
    url: "/auth/user/login",
    method: HTTPMethod.POST,
    isProtected: false,
  );
}
