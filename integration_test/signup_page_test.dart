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

import '../test/features/auth/presentation/viewmodel/login_unit_test.mocks.dart';
import '../test/features/splash/presentation/viewmodel/splash_view_model_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAuthUseCase mockAuthUseCase;
  late UserEntity mockUserEntity;

  setUpAll(() async {
    mockAuthUseCase = MockAuthUseCase();

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
  });

  group('test login', () {
    testWidgets('test signup with wrong email', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthViewModel>(
              create: (context) => AuthViewModel(
                authUseCase: mockAuthUseCase,
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
            initialRoute: AppRoutes.signupRoute,
            routes: AppRoutes.loggedoutRoute,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // username field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(0),
        'test',
      );

      // email field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(1),
        'testest',
      );

      // password field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(2),
        '@ppleWas01',
      );

      // confirm password field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(3),
        '@ppleWas01',
      );
      // close the keyboard
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // tap on the login button
      await tester.tap(
        find.widgetWithText(
          ElevatedButton,
          'SIGN UP',
        ),
      );

      // wait for the response
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // check if the user is logged in
      expect(
        find.text('Email is invalid'),
        findsOneWidget,
      );
    });

    testWidgets('test signup with wrong confirm password',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthViewModel>(
              create: (context) => AuthViewModel(
                authUseCase: mockAuthUseCase,
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
            initialRoute: AppRoutes.signupRoute,
            routes: AppRoutes.loggedoutRoute,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // username field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(0),
        'test',
      );

      // email field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(1),
        'test@test.com',
      );

      // password field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(2),
        '@ppleWas01',
      );

      // confirm password field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(3),
        '@ppleWas02',
      );

      // close the keyboard
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // tap on the login button
      await tester.tap(
        find.widgetWithText(
          ElevatedButton,
          'SIGN UP',
        ),
      );

      // wait for the response
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(
        find.text('Password does not match'),
        findsOneWidget,
      );
    });

    testWidgets('test signup without credentials', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthViewModel>(
              create: (context) => AuthViewModel(
                authUseCase: mockAuthUseCase,
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
            initialRoute: AppRoutes.signupRoute,
            routes: AppRoutes.loggedoutRoute,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // username field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(0),
        '',
      );

      // email field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(1),
        '',
      );

      // password field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(2),
        '',
      );

      // confirm password field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(3),
        '',
      );

      // close the keyboard
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // tap on the login button
      await tester.tap(
        find.widgetWithText(
          ElevatedButton,
          'SIGN UP',
        ),
      );

      // wait for the response
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // check if the user is logged in
      expect(
        find.text('Email is required'),
        findsOneWidget,
      );
    });
    testWidgets('test signup with proper credentials',
        (WidgetTester tester) async {
      final mockAuthUseCase = MockAuthUseCase();
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
      when(
        mockAuthUseCase.signup(
          email: 'test@example.com',
          password: '@ppleWas01',
          username: 'test',
        ),
      ).thenAnswer(
        (_) async => Right(mockUserEntity),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthViewModel>(
              create: (context) => AuthViewModel(
                authUseCase: mockAuthUseCase,
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
            initialRoute: AppRoutes.signupRoute,
            routes: AppRoutes.loggedoutRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // username field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(0),
        'test',
      );

      // email field

      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(1),
        'test@example.com',
      );

      // password field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(2),
        '@ppleWas01',
      );

      // confirm password field
      await tester.enterText(
        find
            .byType(
              TextFormField,
            )
            .at(3),
        '@ppleWas01',
      );

      // close the keyboard
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // tap on the Signup button
      await tester.tap(
        find.widgetWithText(
          ElevatedButton,
          'SIGN UP',
        ),
      );

      // wait for the response
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // check if the user is signed in
      expect(
        find.text('SIGN UP'),
        findsNothing,
      );
    });
  });
}
