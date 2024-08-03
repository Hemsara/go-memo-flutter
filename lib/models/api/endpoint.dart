import 'package:gomemo/models/api/qparam.dart';

import 'dto.dart';
import 'error.dart';

// ignore: constant_identifier_names
enum HTTPMethod { GET, POST, PATCH, DELETE, PUT }

class Endpoint<T extends DTO> {
  final String url;

  final String? description;
  final String? baseURL;

  final HTTPMethod method;
  List<QParam>? queryParameter;

  final bool isProtected;
  T? dto;
  bool dtoNullable;

  Endpoint({
    required this.url,
    this.description,
    this.baseURL,
    required this.method,
    this.queryParameter,
    this.isProtected = true,
    this.dto,
    this.dtoNullable = false,
  });

  Endpoint copyWitURL(String url) {
    return Endpoint(
      url: "${this.url}$url",
      description: description,
      baseURL: baseURL,
      method: method,
      queryParameter: queryParameter,
      isProtected: isProtected,
      dto: dto ?? dto,
      dtoNullable: dtoNullable,
    );
  }

  Endpoint copyWithDTO(T dto) {
    return Endpoint(
      url: url,
      description: description,
      baseURL: baseURL,
      method: method,
      queryParameter: queryParameter,
      isProtected: isProtected,
      dto: dto ?? this.dto,
      dtoNullable: dtoNullable,
    );
  }

  void setParams(List<QParam> params) {
    queryParameter = params;
  }

  String getHTTPMethod() {
    switch (method) {
      case HTTPMethod.DELETE:
        return "DELETE";
      case HTTPMethod.GET:
        return "GET";
      case HTTPMethod.PATCH:
        return "PATCH";
      case HTTPMethod.POST:
        return "POST";
      case HTTPMethod.PUT:
        return "PUT";
      default:
        return "GET";
    }
  }

  void checkDTO() {
    if (method == HTTPMethod.POST && !dtoNullable && dto == null) {
      throw ApiError(message: "DTO is not set for the endpoint.");
    }
  }
}
