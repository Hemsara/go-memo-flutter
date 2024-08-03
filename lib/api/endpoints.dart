import 'package:gomemo/models/api/endpoint.dart';

import 'dto/auth/login.dto.dart';

class EndPoints {
  static String baseURL = "http://localhost:8080";

  // * Auth routes
  static Endpoint<LoginDTO> login = Endpoint(
    url: "/authenticate/login",
    method: HTTPMethod.POST,
    isProtected: false,
  );
  static Endpoint<LoginDTO> profile = Endpoint(
    url: "/user/profile",
    method: HTTPMethod.GET,
  );
}
