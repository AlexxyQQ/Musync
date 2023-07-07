import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/config/themes/app_theme.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../test/features/auth/presentation/viewmodel/login_unit_test.mocks.dart';
import '../test/features/splash/presentation/viewmodel/splash_view_model_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  group('Initial Login test with token', () {
    late MockSplashUseCase mockSplashUseCase;
    late UserEntity mockUserEntity;
    late ErrorModel mockErrorModel;

    setUp(() {
      mockSplashUseCase = MockSplashUseCase();
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
    });

    testWidgets('test initial login with token', (WidgetTester tester) async {
      when(mockSplashUseCase.initialLogin()).thenAnswer(
        (_) async => Right(mockUserEntity),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthViewModel>(
              create: (context) => AuthViewModel(
                splashUseCase: mockSplashUseCase,
                authUseCase: MockAuthUseCase(),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Musync',
            theme: AppTheme.appDarkTheme(),
            routes: AppRoutes.loggedinRoute,
            initialRoute: AppRoutes.splashRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('test initial login without token',
        (WidgetTester tester) async {
      mockErrorModel = ErrorModel(
        status: false,
        message: 'Please provide a token',
      );
      when(mockSplashUseCase.initialLogin()).thenAnswer(
        (_) async => Left(mockErrorModel),
      );
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthViewModel>(
              create: (context) => AuthViewModel(
                splashUseCase: mockSplashUseCase,
                authUseCase: MockAuthUseCase(),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Musync',
            theme: AppTheme.appDarkTheme(),
            routes: AppRoutes.loggedinRoute,
            initialRoute: AppRoutes.splashRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(
        find.text('Please provide a token'),
        findsOneWidget,
      );
    });

    testWidgets('test initial login with invalid token',
        (WidgetTester tester) async {
      mockErrorModel = ErrorModel(
        status: false,
        message: 'Please provide a valid token',
      );
      when(mockSplashUseCase.initialLogin()).thenAnswer(
        (_) async => Left(mockErrorModel),
      );
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthViewModel>(
              create: (context) => AuthViewModel(
                splashUseCase: mockSplashUseCase,
                authUseCase: MockAuthUseCase(),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Musync',
            theme: AppTheme.appDarkTheme(),
            routes: AppRoutes.loggedinRoute,
            initialRoute: AppRoutes.splashRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(
        find.text('Please provide a valid token'),
        findsOneWidget,
      );
    });
  });
}
