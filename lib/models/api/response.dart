enum RequestStatus { success, failed, unauthorized }

class ApiResponse {
  final Map<String, dynamic> data;
  final RequestStatus status;
  final bool success;

  ApiResponse({
    required this.data,
    required this.success,
    required this.status,
  });
}
