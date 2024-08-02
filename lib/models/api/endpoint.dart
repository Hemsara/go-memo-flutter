import 'dart:io';

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
  List<MultiPartImageFile>? images;

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
    this.images,
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
      images: images,
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
      images: images,
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

  Endpoint<T> copyWithImages(List<MultiPartImageFile> newImages) {
    return Endpoint<T>(
      url: url,
      description: description,
      method: method,
      queryParameter: queryParameter,
      images: newImages,
      isProtected: isProtected,
      dto: dto,
      dtoNullable: dtoNullable,
    );
  }

  void checkDTO() {
    if (method == HTTPMethod.POST && !dtoNullable && dto == null) {
      throw ApiError(message: "DTO is not set for the endpoint.");
    }
  }
}

class MultiPartImageFile {
  final File file;
  final String key;

  MultiPartImageFile({required this.file, required this.key});
}
