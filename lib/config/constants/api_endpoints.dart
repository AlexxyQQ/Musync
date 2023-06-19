class ApiEndpoints {
  static const String baseURL = "http://192.168.1.78:3001/api";
  static const Map<String, dynamic> defaultHeaders = {
    'apisecret': "Apple",
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  static const Duration connectionTimeout = Duration(seconds: 5);
  static const Duration receiveTimeout = Duration(seconds: 10);

  // Endpoints
  static const String baseRoute = "/";
  static const String loginWithTokenRoute = "/users/loginWithToken";
  static const String loginRoute = "/users/login";
  static const String signupRoute = "/users/signup";
  static const String addAllSongsRoute = '/music/addAllSongs';
  static const String getAllSongsRoute = '/music/getAllSongs';
  static const String uploadAlbumArtRoute = '/music/uploadAlbumArt';
}
