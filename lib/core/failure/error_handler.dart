class ErrorModel {
  final String message;
  final dynamic data;
  final bool status;

  ErrorModel({
    required this.message,
    required this.status,
    this.data,
  });

  @override
  String toString() {
    return 'ErrorModel(message: $message, data: $data, status: $status)';
  }
}
