import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/splash/domain/use_case/splash_use_case.dart';

import 'splash_view_model_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SplashUseCase>(),
])
void main() {
  late MockSplashUseCase mockSplashUseCase;
  late UserEntity mockUserEntity;

  setUpAll(() async {
    mockSplashUseCase = MockSplashUseCase();
  });

  group('Initial Login test with token', () {
    test('test initial login with token', () async {
      mockUserEntity = UserEntity(
        email: 'test@example.com',
        id: '1234567890',
        password: 'password',
        profilePic: 'https://something.img',
        token: 'mockToken',
        type: 'manual',
        username: 'test',
        verified: false,
      );
      when(mockSplashUseCase.initialLogin()).thenAnswer(
        (_) async => Right(
          mockUserEntity,
        ),
      );

      final result = await mockSplashUseCase.initialLogin();

      expect(result, Right(mockUserEntity));
    });

    /// This test is checking the behavior of the `initialLogin()` method when there is no token found.
    test('test initial login without token', () async {
      final mockErrorModel = ErrorModel(
        message: 'Please provide token',
        status: false,
      );

      when(mockSplashUseCase.initialLogin()).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      final result = await mockSplashUseCase.initialLogin();

      expect(
        result,
        Left(mockErrorModel),
      );
    });

    test('test initial login with invalid token', () async {
      final mockErrorModel = ErrorModel(
        message: 'Please provide valid token',
        status: false,
      );

      when(mockSplashUseCase.initialLogin()).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      final result = await mockSplashUseCase.initialLogin();

      expect(
        result,
        Left(mockErrorModel),
      );
    });
  });
}
