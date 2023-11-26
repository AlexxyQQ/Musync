import 'package:musync/features/auth/domain/entity/user_entity.dart';

class AuthState {
  final UserEntity? loggedUser;
  final bool isLoading;
  final String? errorMsg;
  final bool isError;
  final bool isLogin;
  final bool isSignUp;
  final bool isLogout;
  final String? token;
  final bool isFirstTime;
  final bool goHome;
  final bool supportBioMetricState;
  final bool allowLoginWithBiometric;

  AuthState({
    required this.loggedUser,
    required this.isLoading,
    this.errorMsg,
    required this.isError,
    required this.isLogin,
    required this.isSignUp,
    required this.isLogout,
    this.token,
    required this.isFirstTime,
    required this.goHome,
    required this.supportBioMetricState,
    required this.allowLoginWithBiometric,
  });

  factory AuthState.initial() {
    return AuthState(
      loggedUser: UserEntity(
        id: "0",
        username: 'Guest',
        email: 'Guest',
        password: 'Guest',
        token: '',
        profilePic: 'assets/default_profile.jpeg',
        verified: false,
        type: 'guest',
      ),
      isLoading: false,
      errorMsg: null,
      isLogin: false,
      isSignUp: false,
      isLogout: false,
      token: null,
      isError: false,
      isFirstTime: true,
      goHome: false,
      supportBioMetricState: false,
      allowLoginWithBiometric: false,
    );
  }

  AuthState copyWith({
    UserEntity? loggedUser,
    bool? isLoading,
    String? errorMsg,
    bool? isError,
    bool? isLogin,
    bool? isSignUp,
    bool? isLogout,
    String? token,
    bool? isFirstTime,
    bool? goHome,
    bool? supportBioMetricState,
    bool? allowLoginWithBiometric,
  }) {
    return AuthState(
      loggedUser: loggedUser ?? this.loggedUser,
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      isError: isError ?? this.isError,
      isLogin: isLogin ?? this.isLogin,
      isSignUp: isSignUp ?? this.isSignUp,
      isLogout: isLogout ?? this.isLogout,
      token: token ?? this.token,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      goHome: goHome ?? this.goHome,
      supportBioMetricState:
          supportBioMetricState ?? this.supportBioMetricState,
      allowLoginWithBiometric:
          allowLoginWithBiometric ?? this.allowLoginWithBiometric,
    );
  }

  @override
  String toString() {
    return 'AuthState{\n'
        '  loggedUser: $loggedUser,\n'
        '  isLoading: $isLoading,\n'
        '  errorMsg: $errorMsg,\n'
        '  isError: $isError,\n'
        '  isLogin: $isLogin,\n'
        '  isSignUp: $isSignUp,\n'
        '  isLogout: $isLogout,\n'
        '  token: $token,\n'
        '  isFirstTime: $isFirstTime,\n'
        '  goHome: $goHome,\n'
        '  supportBioMetricState: $supportBioMetricState,\n'
        '  allowLoginWithBiometric: $allowLoginWithBiometric\n'
        '}';
  }
}
