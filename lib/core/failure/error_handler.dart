class ErrorModel {
  final String message;
  final dynamic data;
  final bool status;

  ErrorModel({
    required this.message,
    required this.status,
    this.data,
  });
}
