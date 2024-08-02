import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gomemo/models/api/endpoint.dart';
import 'package:gomemo/models/api/error.dart';
import 'package:gomemo/models/api/response.dart';
import 'package:gomemo/res/toast.dart';
import 'package:gomemo/services/navigator.dart';
import 'package:http/http.dart' as http;

import 'base_api_service.dart';
import 'endpoints.dart';

class ApiService extends BaseApiService {
  Future<ApiResponse> sendMultiPartRequest({
    required Endpoint endpoint,
  }) async {
    try {
      var uri = Uri.parse("${EndPoints.baseURL}${endpoint.url}");
      if (endpoint.queryParameter != null) {
        List<Map<String, dynamic>> queryParams =
            endpoint.queryParameter!.map((e) => e.toMap()).toList();

        uri = Uri.parse('$uri')
            .replace(queryParameters: _flattenMapList(queryParams));
      }

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(await getHeaders(endpoint.isProtected));

      // Add fields from data map
      if (endpoint.dto != null) {
        log("adding fields ${endpoint.dto!.toMap()}");
        Map<String, dynamic> dtoMap = endpoint.dto!.toMap();
        Map<String, String> stringDtoMap =
            dtoMap.map((key, value) => MapEntry(key, value.toString()));

        request.fields.addAll(stringDtoMap);
        log(stringDtoMap.toString());
      }

      // Add images
      if (endpoint.images != null) {
        log("adding images");

        for (var i = 0; i < endpoint.images!.length; i++) {
          var file = endpoint.images![i].file;
          var stream = http.ByteStream(file.openRead());
          var length = await file.length();

          var multipartFile = http.MultipartFile(
            endpoint.images![i].key,
            stream,
            length,
            filename: file.path.split("/").last,
          );
          log("addded ${multipartFile.field}");

          request.files.add(multipartFile);
        }
      }

      debugPrint("=======");
      debugPrint("🗣️ Sending ${endpoint.getHTTPMethod()} request to $uri");
      var response = await request.send();
      var resData = await response.stream.bytesToString();

      debugPrint("🗣️ Status code: ${response.statusCode}");
      debugPrint("🗣️ Body: $resData");
      debugPrint("=======");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful response
        return ApiResponse(
            success: true,
            status: RequestStatus.success,
            data: (jsonDecode(resData) is List)
                ? {'data': jsonDecode(resData)}
                : jsonDecode(resData));
      }

      // Failed response
      String err =
          (jsonDecode(resData)['message'] ?? jsonDecode(resData)['error']);

      throw ApiError(message: err);
    } on SocketException {
      throw ApiError(message: "Unable to connect to the server");
    } on TimeoutException {
      throw ApiError(message: 'The request is timed out');
    } catch (e) {
      debugPrint(e.runtimeType.toString());
      debugPrint(
          'An error thrown : ${e.runtimeType == ApiError ? (e as ApiError).message : e.toString()}');
      if (e.runtimeType == ApiError) {
        rethrow;
      }
      throw ApiError(message: "Something went wrong");
    }
  }

  // Send an HTTP request and handle the response
  Future<ApiResponse> sendRequest({
    required Endpoint endpoint,
  }) async {
    try {
      var url =
          Uri.parse("${endpoint.baseURL ?? EndPoints.baseURL}${endpoint.url}");
      endpoint.checkDTO();
      if (endpoint.queryParameter != null) {
        List<Map<String, dynamic>> queryParams =
            endpoint.queryParameter!.map((e) => e.toMap()).toList();

        url = Uri.parse('$url')
            .replace(queryParameters: _flattenMapList(queryParams));
      }

      var request = http.Request(endpoint.getHTTPMethod(), url)
        ..headers.addAll(await getHeaders(endpoint.isProtected));

      if (endpoint.dto != null) {
        Map<String, dynamic> data = endpoint.dto!.toMap();

        request.body = jsonEncode(data);
      }

      // Debugging output for request and response
      debugPrint("""
╔════════════════════════════════════════════════════════════════════════════╗
║     API REQUEST                                                            ║
╠════════════════════════════════════════════════════════════════════════════╣
║ Type   :- ${endpoint.method.name}
║ URL    :- ${request.url}
║ Params :- ${endpoint.dto == null ? "N/A" : endpoint.dto!.toMap()}
╚════════════════════════════════════════════════════════════════════════════╝
""");

      http.StreamedResponse response = await request.send();
      var resData = await response.stream.bytesToString();

      debugPrint("""
╔════════════════════════════════════════════════════════════════════════════╗
║      API RESPONSE                                                          ║
╠════════════════════════════════════════════════════════════════════════════╣
║ API        :- ${endpoint.url}
║ StatusCode :- ${response.statusCode}
║ Response   :- 

$resData

╚════════════════════════════════════════════════════════════════════════════╝
""");

      // Handle unauthenticated responses
      if (response.statusCode == 401) {
        if (endpoint == EndPoints.login) {
          throw ApiError(
              message: 'Invalid Credentials', status: ErrorStatus.unauthorized);
        }
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful response
        return ApiResponse(
            success: true,
            status: RequestStatus.success,
            data: (jsonDecode(resData) is List)
                ? {'data': jsonDecode(resData)}
                : jsonDecode(resData));
      }

      String err = (jsonDecode(resData)['message'] ??
          jsonDecode(resData)['error'] ??
          fromCode(response.statusCode));

      throw ApiError(message: err, status: fromCode(response.statusCode));
    } on SocketException {
      if (NavigatorHelper.navigatorKey.currentState != null &&
          NavigatorHelper.navigatorKey.currentState!.context.mounted) {
        ToastManager.showWarningToast("No internet connection");
      }

      // Handle network connectivity errors
      throw ApiError(
          message: "Unable to connect to the server",
          status: ErrorStatus.socketError);
    } on TimeoutException {
      // Handle request timeout
      throw ApiError(
          message: 'The request is timed out', status: ErrorStatus.timeout);
    } catch (e) {
      // Handle other errors
      debugPrint('An error thrown : $e');
      if (e.runtimeType == ApiError) {
        rethrow;
      }
      throw ApiError(
          message: "Something went wrong", status: ErrorStatus.unauthorized);
    }
  }
}

Map<String, dynamic> _flattenMapList(List<Map<String, dynamic>> list) {
  Map<String, dynamic> result = {};
  for (var map in list) {
    result.addAll(map);
  }
  return result;
}
