import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/use_case/auth_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import 'login_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late MockAuthUseCase mockAuthUseCase;
  late UserEntity mockUserEntity;

  setUpAll(() async {
    mockAuthUseCase = MockAuthUseCase();
  });

  group('test login', () {
    setUpAll(() async {
      /// Creating a proper mock user for loggin in
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
        mockAuthUseCase.login(
          email: 'test@example.com',
          password: 'password',
        ),
      ).thenAnswer(
        (_) async => Right(mockUserEntity),
      );
    });

    test('test login with proper credentials', () async {
      // Call the login method
      final result = await mockAuthUseCase.login(
        email: 'test@example.com',
        password: 'password',
      );

      // Verify the expected result
      expect(result, Right(mockUserEntity));
    });

    test('test login with invalid email', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = ErrorModel(
        message: 'User with email not found',
        status: false,
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockAuthUseCase.login(
          email: 'test22@example.com',
          password: 'password',
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      // Call the login method
      final result = await mockAuthUseCase.login(
        email: 'test22@example.com',
        password: 'password',
      );

      // Verify the expected result
      expect(result, Left(mockErrorModel));
    });

    test('test login with invalid password', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = ErrorModel(
        message: 'Invalid Password',
        status: false,
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockAuthUseCase.login(
          email: 'test@example.com',
          password: 'password000',
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      // Call the login method
      final result = await mockAuthUseCase.login(
        email: 'test@example.com',
        password: 'password000',
      );

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });

    test('test login with null email', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = ErrorModel(
        message: 'Please enter email',
        status: false,
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockAuthUseCase.login(
          email: null, 
          password: 'password',
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      // Call the login method
      final result = await mockAuthUseCase.login(
        email: null,
        password: 'password',
      );

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });

    test('test login with null password', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = ErrorModel(
        message: 'Please enter password',
        status: false,
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockAuthUseCase.login(
          email: 'test@example.com',
          password: null,
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      // Call the login method
      final result = await mockAuthUseCase.login(
        email: 'test@example.com',
        password: null,
      );

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });
  });
}
