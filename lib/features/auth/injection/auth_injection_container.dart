import 'package:musync/features/auth/domain/use_case/rend_verification_usecase.dart';

import '../../../injection/app_injection_container.dart';
import '../data/data_source/remote_data_source/auth_remote_data_source.dart';
import '../data/repository/auth_repository.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/use_case/delete_user_usecase.dart';
import '../domain/use_case/send_forgot_password_otp_usecase.dart';
import '../domain/use_case/change_password_usecase.dart';
import '../domain/use_case/login_usecase.dart';
import '../domain/use_case/logout_usecase.dart';
import '../domain/use_case/signup_otp_validator_usecase.dart';
import '../domain/use_case/signup_usecase.dart';
import '../domain/use_case/upload_profile_pic_usecase.dart';
import '../presentation/cubit/authentication_cubit.dart';

class AuthInjectionContainer {
  void register() {
    // Data Sources
    get.registerLazySingleton(
      () => AuthRemoteDataSource(
        api: get(),
      ),
    );

    // Repository
    get.registerLazySingleton<IAuthRepository>(
      () => AuthRepositoryImpl(
        authDataSource: get(),
      ),
    );

    // Use Cases
    get.registerLazySingleton(
      () => LoginUseCase(
        repository: get(),
        settingsHiveService: get(),
      ),
    );
    get.registerLazySingleton(
      () => SignupUseCase(
        repository: get(),
      ),
    );
    get.registerLazySingleton(
      () => OTPValidatorUsecase(
        repository: get(),
      ),
    );
    get.registerLazySingleton(
      () => DeleteUserUseCase(
        repository: get(),
      ),
    );
    get.registerLazySingleton(
      () => UploadProfilePicUseCase(
        repository: get(),
      ),
    );
    get.registerLazySingleton(
      () => LogoutUseCase(
        repository: get(),
      ),
    );
    get.registerLazySingleton(
      () => SendForgotPasswordOTPUsecase(
        repository: get(),
      ),
    );
    get.registerLazySingleton(
      () => ChangePasswordUsecase(
        repository: get(),
      ),
    );
    get.registerLazySingleton(
      () => ResendVerificationUsecase(
        repository: get(),
        settingsHiveService: get(),
      ),
    );

    // Cubit
    get.registerFactory(
      () => AuthenticationCubit(
        deleteUserUseCase: get(),
        loginUseCase: get(),
        logoutUseCase: get(),
        signupUseCase: get(),
        uploadProfilePicUseCase: get(),
        otpValidatorUsecase: get(),
        sendForgotPasswordOTPUsecase: get(),
        changePasswordUsecase: get(),
        initialLoginUseCase: get(),
        resendVerificationUsecase: get(),
      ),
    );
  }
}
