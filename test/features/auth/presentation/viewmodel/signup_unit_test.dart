import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import 'login_unit_test.mocks.dart';

void main() {
  late MockAuthUseCase mockAuthUseCase;
  late UserEntity mockUserEntity;

  setUpAll(() async {
    mockAuthUseCase = MockAuthUseCase();
  });

  group('test register', () {
    setUpAll(() {
      /// Creating a proper mock user for signing up
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

      /// if provided certain credential returen the proper mock user
      when(
        mockAuthUseCase.signup(
          email: 'test@example.com',
          password: 'password',
          username: 'test',
        ),
      ).thenAnswer(
        (_) async => Right(mockUserEntity),
      );
    });

    test('test signup with proper cradential', () async {
      // Call the login method
      final result = await mockAuthUseCase.signup(
        email: 'test@example.com',
        password: 'password',
        username: 'test',
      );

      // Verify the expected result
      expect(result, Right(mockUserEntity));
    });

    test('test signup with invalid credentials', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = ErrorModel(
        message: 'Please enter valid email',
        status: false,
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockAuthUseCase.signup(
          email: 'test@as',
          password: '44444444444444444444444444444444444444444',
          username: '465465465a4s465da54s@#321',
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      // Call the login method
      final result = await mockAuthUseCase.signup(
        email: 'test@as',
        password: '44444444444444444444444444444444444444444',
        username: '465465465a4s465da54s@#321',
      );

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });

    test('test signup with no credentials', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = ErrorModel(
        message: 'Please enter email',
        status: false,
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockAuthUseCase.signup(
          email: null,
          password: null,
          username: null,
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );
      // Call the login method
      final result = await mockAuthUseCase.signup(
        email: null,
        password: null,
        username: null,
      );

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });
  });
}
