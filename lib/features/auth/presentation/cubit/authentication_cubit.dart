// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/features/auth/domain/use_case/rend_verification_usecase.dart';
import 'package:musync/features/auth/presentation/view/change_password_page.dart';
import 'package:musync/features/auth/presentation/view/otp_page.dart';

import '../../../../core/common/custom_widgets/custom_snackbar.dart';
import '../../../splash/domain/use_case/splash_use_case.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/use_case/delete_user_usecase.dart';
import '../../domain/use_case/send_forgot_password_otp_usecase.dart';
import '../../domain/use_case/change_password_usecase.dart';
import '../../domain/use_case/login_usecase.dart';
import '../../domain/use_case/logout_usecase.dart';
import '../../domain/use_case/signup_otp_validator_usecase.dart';
import '../../domain/use_case/signup_usecase.dart';
import '../../domain/use_case/upload_profile_pic_usecase.dart';
import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final LogoutUseCase logoutUseCase;
  final UploadProfilePicUseCase uploadProfilePicUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final OTPValidatorUsecase otpValidatorUsecase;
  final SendForgotPasswordOTPUsecase sendForgotPasswordOTPUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  final InitialLoginUseCase initialLoginUseCase;
  final ResendVerificationUsecase resendVerificationUsecase;
  AuthenticationCubit({
    required this.loginUseCase,
    required this.signupUseCase,
    required this.logoutUseCase,
    required this.uploadProfilePicUseCase,
    required this.deleteUserUseCase,
    required this.otpValidatorUsecase,
    required this.sendForgotPasswordOTPUsecase,
    required this.changePasswordUsecase,
    required this.initialLoginUseCase,
    required this.resendVerificationUsecase,
  }) : super(AuthenticationState.initial());

  Future<void> signup({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        eror: null,
        isSuccess: false,
      ),
    );
    final data = await signupUseCase.call(
      SignupParams(
        email: email,
        password: password,
        username: username,
      ),
    );
    data.fold(
      (l) {
        emit(
          state.copyWith(
            isLoading: false,
            eror: l,
            isSuccess: false,
          ),
        );
        kShowSnackBar(context: context, message: l.message, isError: true);
      },
      (r) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            eror: null,
            isFirstTime: false,
            loggedUser: UserEntity().copyWith(email: email),
          ),
        );
        kShowSnackBar(context: context, message: 'OTP sent to your email');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => OTPPage(
              email: email,
            ),
          ),
          (route) => false,
        );
      },
    );
  }

  Future<void> otpValidator({
    required String email,
    required String otp,
    required BuildContext context,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        eror: null,
        isSuccess: false,
      ),
    );
    final data = await otpValidatorUsecase.call(
      SignupOTPValidatorParams(
        email: email,
        otp: otp,
      ),
    );
    data.fold(
      (l) {
        emit(
          state.copyWith(
            isLoading: false,
            eror: l,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            eror: null,
            isLoading: false,
            isSuccess: true,
            loggedUser: state.loggedUser!.copyWith(
              verified: true,
            ),
            isFirstTime: false,
          ),
        );
        Navigator.of(context).pushNamed('/login');
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        eror: null,
        isSuccess: false,
      ),
    );

    final data = await loginUseCase.call(
      LoginParams(
        email: email,
        password: password,
      ),
    );

    if (data.isLeft()) {
      emit(
        state.copyWith(
          isLoading: false,
          eror: data.fold((l) => l, (r) => null),
        ),
      );
      kShowSnackBar(
        context: context,
        message: data.fold((l) => l.message, (r) => ''),
        isError: true,
      );
    } else {
      emit(
        state.copyWith(
          eror: null,
          isLoading: false,
          loggedUser: data.fold((l) => null, (r) => r),
          isSuccess: true,
          isFirstTime: false,
          goHome: true,
        ),
      );

      kShowSnackBar(context: context, message: 'Logged in successfully');
    }
  }

  Future<void> initialLogin({
    required BuildContext context,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        eror: null,
        isSuccess: false,
      ),
    );

    final data = await initialLoginUseCase.call(null);

    if (data.isLeft()) {
      emit(
        state.copyWith(
          isLoading: false,
          eror: data.fold((l) => l, (r) => null),
        ),
      );
      kShowSnackBar(
        context: context,
        message: data.fold((l) => l.message, (r) => ''),
        isError: true,
        duration: const Duration(milliseconds: 400),
      );
    } else {
      emit(
        state.copyWith(
          eror: null,
          isLoading: false,
          loggedUser: data.fold((l) => null, (r) => r),
          isSuccess: true,
          isFirstTime: false,
          goHome: true,
        ),
      );
      kShowSnackBar(context: context, message: 'Logged in successfully');
    }
  }

  Future<void> logoutUser() async {
    emit(
      state.copyWith(
        isLoading: true,
        eror: null,
        isSuccess: false,
      ),
    );

    final data = await logoutUseCase.call(null);
    data.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          eror: l,
        ),
      ),
      (r) => emit(
        state.copyWith(
          eror: null,
          isLoading: false,
          isSuccess: true,
          loggedUser: null,
        ),
      ),
    );
  }

  Future<void> uploadProfilePic({
    required String path,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        eror: null,
        isSuccess: false,
      ),
    );

    final data = await uploadProfilePicUseCase.call(
      UploadProfilePicParams(
        token: state.loggedUser!.token!,
        profilePicPath: path,
      ),
    );

    data.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          eror: l,
          isSuccess: false,
        ),
      ),
      (r) => emit(
        state.copyWith(
          eror: null,
          isLoading: false,
          loggedUser: r,
          isSuccess: true,
        ),
      ),
    );
  }

  Future<void> deleteUser() async {
    emit(
      state.copyWith(
        isLoading: true,
        eror: null,
        isSuccess: false,
      ),
    );

    final data = await deleteUserUseCase.call(
      state.loggedUser!.token!,
    );

    data.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          eror: l,
          isSuccess: false,
        ),
      ),
      (r) => emit(
        state.copyWith(
          eror: null,
          isLoading: false,
          isSuccess: true,
          loggedUser: null,
        ),
      ),
    );
  }

  Future<void> sendForgetPasswordOTP({
    required String email,
    required BuildContext context,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        eror: null,
        isSuccess: false,
      ),
    );

    final data = await sendForgotPasswordOTPUsecase.call(email);

    data.fold(
      (l) {
        emit(
          state.copyWith(
            isSuccess: false,
            isLoading: false,
            eror: l,
          ),
        );
        kShowSnackBar(context: context, message: l.message, isError: true);
      },
      (r) {
        emit(
          state.copyWith(
            eror: null,
            isLoading: false,
            isSuccess: true,
          ),
        );
        kShowSnackBar(context: context, message: 'OTP sent to your email');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => ChangePasswordPage(
              email: email,
            ),
          ),
          (route) => false,
        );
      },
    );
  }

  Future<void> changePassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmNewPassword,
    required BuildContext context,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        eror: null,
        isSuccess: false,
      ),
    );

    final data = await changePasswordUsecase.call(
      ChagePasswordParams(
        email: email,
        otp: otp,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      ),
    );

    data.fold(
      (l) {
        emit(
          state.copyWith(
            isSuccess: false,
            isLoading: false,
            eror: l,
          ),
        );
        kShowSnackBar(context: context, message: l.message, isError: true);
      },
      (r) {
        emit(
          state.copyWith(
            eror: null,
            isLoading: false,
            isSuccess: true,
          ),
        );
        kShowSnackBar(
          context: context,
          message: 'Password changed successfully',
        );
        Navigator.of(context).pushNamed('/login');
      },
    );
  }
}
