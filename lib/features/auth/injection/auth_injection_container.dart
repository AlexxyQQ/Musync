import '../../../injection/app_injection_container.dart';
import '../data/data_source/remote_data_source/auth_remote_data_source.dart';
import '../data/repository/auth_repository.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/use_case/delete_user_usecase.dart';
import '../domain/use_case/forgot_password_otp_sender_usecase.dart';
import '../domain/use_case/forgot_password_otp_validator_usecase.dart';
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
        hiveQueries: get(),
      ),
    );
    get.registerLazySingleton(
      () => SignupUseCase(
        repository: get(),
      ),
    );
    get.registerLazySingleton(
      () => SignupOTPValidatorUsecase(
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
      () => ForgotPasswordOTPSenderUsecase(
        repository: get(),
      ),
    );
    get.registerLazySingleton(
      () => ForgotPasswordOTPValidatorUsecase(
        repository: get(),
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
        signupOTPValidatorUsecase: get(),
        forgotPasswordOTPSenderUsecase: get(),
        forgotPasswordOTPValidatorUsecase: get(),
        initialLoginUseCase: get(),
      ),
    );
  }
}
