import 'package:musync/core/failure/error_handler.dart';

abstract class ASplashRepository {
  Future<ErrorModel> isConnectedToInternet();
  Future<ErrorModel> isServerUp();
  Future<ErrorModel> checkConnectivityAndServer();
  Future<ErrorModel> getLoggeduser({
    bool isFirstTime = false,
    bool goHome = false,
  });
}
