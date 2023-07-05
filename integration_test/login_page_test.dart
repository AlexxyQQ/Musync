import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/config/themes/app_theme.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:musync/features/splash/presentation/viewmodel/splash_view_model.dart';

import '../test/features/auth/presentation/viewmodel/login_unit_test.mocks.dart';
import '../test/features/splash/presentation/viewmodel/splash_view_model_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

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
        password: '@ppleWas01',
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
          password: '@ppleWas01',
        ),
      ).thenAnswer(
        (_) async => Right(mockUserEntity),
      );
    });

    testWidgets('test login with wrong email', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthViewModel>(
              create: (context) => AuthViewModel(
                authUseCase: mockAuthUseCase,
              ),
            ),
          ],
          child: MaterialApp(
            title: "Musync",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appLightTheme(),
            darkTheme: AppTheme.appDarkTheme(),
            themeMode: ThemeMode.system,
            initialRoute: AppRoutes.loginRoute,
            routes: AppRoutes.loggedoutRoute,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(0),
        'test',
      );

      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(1),
        '@ppleWas01',
      );

      await tester.tap(
        find.widgetWithText(
          ElevatedButton,
          'LOGIN',
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(
        find.text('Email is invalid'),
        findsOneWidget,
      );
    });

    testWidgets('test login with wrong password', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthViewModel>(
              create: (context) => AuthViewModel(
                authUseCase: mockAuthUseCase,
              ),
            ),
          ],
          child: MaterialApp(
            title: "Musync",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appLightTheme(),
            darkTheme: AppTheme.appDarkTheme(),
            themeMode: ThemeMode.system,
            initialRoute: AppRoutes.loginRoute,
            routes: AppRoutes.loggedoutRoute,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(0),
        'test@test.com',
      );

      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(1),
        'cccccc',
      );

      await tester.tap(
        find.widgetWithText(
          ElevatedButton,
          'LOGIN',
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(
        find.text('Password must be at least 8 characters'),
        findsOneWidget,
      );
    });

    testWidgets('test login without credentials', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthViewModel>(
              create: (context) => AuthViewModel(
                authUseCase: mockAuthUseCase,
              ),
            ),
          ],
          child: MaterialApp(
            title: "Musync",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appLightTheme(),
            darkTheme: AppTheme.appDarkTheme(),
            themeMode: ThemeMode.system,
            initialRoute: AppRoutes.loginRoute,
            routes: AppRoutes.loggedoutRoute,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(0),
        '',
      );

      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(1),
        '',
      );

      await tester.tap(
        find.widgetWithText(
          ElevatedButton,
          'LOGIN',
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(
        find.text('Email is required'),
        findsOneWidget,
      );
    });
    testWidgets('test login with proper credentials',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthViewModel(
                authUseCase: mockAuthUseCase,
              ),
            ),
            BlocProvider(
              create: (context) => SplashViewModel(
                splashUseCase: MockSplashUseCase(),
              ),
            ),
          ],
          child: MaterialApp(
            title: "Musync",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appLightTheme(),
            darkTheme: AppTheme.appDarkTheme(),
            themeMode: ThemeMode.system,
            initialRoute: AppRoutes.loginRoute,
            routes: AppRoutes.loggedoutRoute,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // enter aayush in the text field email
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(0),
        'test@example.com',
      );

      // enter aayush in the text field password
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(1),
        '@ppleWas01',
      );
      // tap on the login button
      await tester.tap(
        find.widgetWithText(
          ElevatedButton,
          'LOGIN',
        ),
      );

      // wait for the response
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // check if the user is logged in
      expect(
        find.widgetWithText(SnackBar, 'Login Successful'),
        findsOneWidget,
      );
    });
  });
}
