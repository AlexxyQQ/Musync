import 'package:musync/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:musync/features/auth/data/repository/auth_repository.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';
import 'package:musync/features/auth/domain/use_case/delete_user_usecase.dart';
import 'package:musync/features/auth/domain/use_case/google_login_usecase.dart';
import 'package:musync/features/auth/domain/use_case/login_usecase.dart';
import 'package:musync/features/auth/domain/use_case/logout_usecase.dart';
import 'package:musync/features/auth/domain/use_case/signup_usecase.dart';
import 'package:musync/features/auth/domain/use_case/upload_profile_pic_usecase.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:musync/injection/app_injection_container.dart';

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
      ),
    );
    get.registerLazySingleton(
      () => SignupUseCase(
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
      () => GoogleLoginUseCase(
        repository: get(),
      ),
    );
    get.registerLazySingleton(
      () => LogoutUseCase(
        repository: get(),
      ),
    );
    // ViewModels
    get.registerFactory(
      () => AuthViewModel(
        splashUseCase: get(),
        deleteUserUseCase: get(),
        googleLoginUseCase: get(),
        loginUseCase: get(),
        logoutUseCase: get(),
        signupUseCase: get(),
        uploadProfilePicUseCase: get(),
      ),
    );
  }
}
