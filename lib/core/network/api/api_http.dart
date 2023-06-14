// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class ApiHttp {
//   static const String baseURL = "http://192.168.1.78:3001/api";
//   static const Map<String, String> defaultHeaders = {
//     "Content-Type": "application/json",
//     'apisecret': "Apple"
//   };

//   http.Client _client = http.Client();
//   final Uri _baseUri = Uri.parse(baseURL);

//   ApiHttp() {
//     _client = http.Client();
//   }

//   Future<ApiResponse> sendRequest(
//     String url, {
//     String method = 'GET',
//     dynamic body,
//     Map<String, String>? headers,
//   }) async {
//     final uri = _baseUri.resolve(url);
//     final requestHeaders = {...defaultHeaders, ...?headers};

//     final request = http.Request(method, uri);
//     request.headers.addAll(requestHeaders);
//     request.body = (body != null ? jsonEncode(body) : null)!;

//     final response =
//         await _client.send(request).timeout(const Duration(seconds: 3));

//     final responseData = await response.stream.transform(utf8.decoder).join();
//     final jsonResponse = jsonDecode(responseData);

//     return ApiResponse.fromResponse(jsonResponse);
//   }
// }

// class ApiResponse {
//   bool success;
//   dynamic data;
//   String? message;

//   ApiResponse({required this.success, this.data, this.message});

//   factory ApiResponse.fromResponse(http.Response response) {
//     final data = response.body as Map<String, dynamic>;
//     return ApiResponse(
//       success: data["success"],
//       data: data["data"],
//       message: data["message"] ?? "Unexpected error",
//     );
//   }
// }
