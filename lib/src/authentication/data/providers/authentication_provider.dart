import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:musync/src/authentication/data/models/user_model.dart';
import 'package:musync/src/authentication/data/repositories/authentication_repository.dart';
import 'package:musync/src/common/data/models/error_model.dart';
import 'dart:convert';

import 'package:musync/src/common/data/repositories/local_storage_repository.dart';
import 'package:musync/src/utils/constants.dart';

final authenticationProvider = Provider((ref) => AuthenticationProvider(
      googleSignIn: GoogleSignIn(),
      localStorageRepository: LocalStorageRepository(),
    ));

class AuthenticationProvider extends AuthenticationRepository {
  final GoogleSignIn _googleSignIn;
  final LocalStorageRepository _localStorageRepository;
  AuthenticationProvider({
    required GoogleSignIn googleSignIn,
    required LocalStorageRepository localStorageRepository,
  })  : _googleSignIn = googleSignIn,
        _localStorageRepository = localStorageRepository;

  @override
  Future<ErrorModel> getUserData() async {
    debugPrint('Get Data Running...');
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );

    try {
      String? token = await _localStorageRepository.getValue(
        boxName: 'users',
        key: 'token',
        defaultValue: "",
      ) as String;
      final resLoginWithToken = await http.get(
        Uri.parse("$host/users/loginWithToken"),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token'
        },
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response(
            json.encode({
              'error': 'Connection timed out or server is down.',
            }),
            408,
          );
        },
      );
      if (resLoginWithToken.statusCode == 200) {
        // Save user data to local storage
        final loggeduser = UserModel.fromJson(
          jsonEncode(
            jsonDecode(resLoginWithToken.body)['user'],
          ),
        ).copyWith(
          token: jsonDecode(resLoginWithToken.body)['token'],
        );
        // If login is successful, then save the user's token to local storage
        error = ErrorModel(error: null, data: loggeduser);
        _localStorageRepository.setValue(
          boxName: 'users',
          key: 'token',
          value: jsonDecode(resLoginWithToken.body)['token'],
        );
        // print(loggeduser);
      } else {
        error = ErrorModel(
          error: jsonDecode(resLoginWithToken.body)['error'],
          data: null,
        );
      }
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }

  @override
  Future<ErrorModel> signInManual(
      {required String email, required String password}) async {
    debugPrint('Sign in Manual Running...');
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );
    try {
      final userAcc = {
        'email': email,
        'password': password,
      };
      // save user to database
      final resLogin = await http.post(
        Uri.parse("$host/users/login"),
        body: json.encode(userAcc),
        headers: {'Content-Type': 'application/json'},
      );

      if (resLogin.statusCode == 200) {
        final loggeduser = UserModel.fromJson(
          jsonEncode(
            jsonDecode(resLogin.body)['user'],
          ),
        ).copyWith(
          token: jsonDecode(resLogin.body)['token'],
        );
        // If login is successful, then save the user's token to local storage
        error = ErrorModel(error: null, data: loggeduser);
        _localStorageRepository.setValue(
          boxName: 'users',
          key: 'token',
          value: jsonDecode(resLogin.body)['token'] as String,
        );
        debugPrint("$loggeduser");
      }
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }

  @override
  void signOut() async {
    debugPrint('Sign out Running...');
    await _googleSignIn.signOut();
    _localStorageRepository.deleteValue(boxName: 'users', key: 'token');
  }

  @override
  Future<ErrorModel> signUpGoogle() async {
    debugPrint('Sign up Google Running...');
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );
    try {
      // Sign in with Google
      final user = await _googleSignIn.signIn();
      // If user is not null, then sign in with the user's email and password
      if (user != null) {
        final userAcc = UserModel(
          email: user.email,
          password: "VerySecretPassword@100",
          confirmPassword: "VerySecretPassword@100",
          username: user.displayName ?? '',
          profilePic: user.photoUrl ?? 'https://i.imgur.com/Eyzrkg3.jpeg',
          uid: '',
          token: '',
          type: 'google',
        );
        // save user to database
        final resSignup = await http.post(
          Uri.parse("$host/users/signup"),
          body: json.encode({
            "email": userAcc.email,
            "password": userAcc.password,
            "confirmPassword": userAcc.confirmPassword,
            "username": userAcc.username.toLowerCase(),
            "profilePic": userAcc.profilePic,
            "type": userAcc.type,
          }),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        if (resSignup.statusCode == 200) {
          // Login with user's email and password
          final resLogin = await http.post(
            Uri.parse("$host/users/login"),
            body: json.encode({
              'email': userAcc.email,
              'password': "VerySecretPassword@100",
            }),
            headers: {'Content-Type': 'application/json'},
          );

          // If login is successful, then save the user's token to local storage
          final newUser = userAcc.copyWith(
            uid: jsonDecode(resSignup.body)['_id'],
            token: jsonDecode(resLogin.body)['token'],
          );
          error = ErrorModel(error: null, data: newUser);
          _localStorageRepository.setValue(
            boxName: 'users',
            key: 'token',
            value: newUser.token,
          );
        } else if (resSignup.statusCode == 400) {
          // Login with user's email and password
          final resLogin = await http.post(
            Uri.parse("$host/users/login"),
            body: json.encode({
              'email': userAcc.email,
              'password': "VerySecretPassword@100",
            }),
            headers: {'Content-Type': 'application/json'},
          );

          if (resLogin.statusCode == 200) {
            // If login is successful, then save the user's token to local storage
            final newUser = userAcc.copyWith(
              uid: jsonDecode(resSignup.body)['_id'],
              token: jsonDecode(resLogin.body)['token'],
            );
            error = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setValue(
              boxName: 'users',
              key: 'token',
              value: newUser.token,
            );
          } else {
            if (jsonDecode(resLogin.body)['error'] == 'Incorrect Password.') {
              error = ErrorModel(
                error: 'User already exists. Please login with your password.',
                data: null,
              );
            } else if (jsonDecode(resLogin.body)['error'] ==
                "Please login with Google!") {
              final resLoginG = await http.post(
                Uri.parse("$host/users/login"),
                body: json.encode({
                  'email': userAcc.email,
                  'password': "VerySecretPassword@100",
                }),
                headers: {'Content-Type': 'application/json'},
              );
              debugPrint(resLoginG.body);
              if (resLoginG.statusCode == 200) {
                // If login is successful, then save the user's token to local storage
                final newUser = userAcc.copyWith(
                  uid: jsonDecode(resSignup.body)['_id'],
                  token: jsonDecode(resLogin.body)['token'],
                );
                error = ErrorModel(error: null, data: newUser);
                _localStorageRepository.setValue(
                  boxName: 'users',
                  key: 'token',
                  value: newUser.token,
                );
              } else {
                error = ErrorModel(
                  error: jsonDecode(resLogin.body)['error'],
                  data: null,
                );
              }
            } else {
              error = ErrorModel(
                error: jsonDecode(resLogin.body)['error'],
                data: null,
              );
            }
          }
        } else {
          error = ErrorModel(
            error: jsonDecode(resSignup.body)['error'],
            data: null,
          );
        }
      }
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }

    return error;
  }

  @override
  Future<ErrorModel> signUpManual(
      {required String email,
      required String password,
      required String confirmPassword,
      required String username,
      String? profilePic,
      required String type}) async {
    debugPrint('Sign up Manual Running...');
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );
    try {
      // save user to database
      final resSignup = await http.post(
        Uri.parse("$host/users/signup"),
        body: json.encode({
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "username": username.toLowerCase(),
          "profilePic": profilePic ?? 'https://i.imgur.com/Eyzrkg3.jpeg',
          "type": type,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (resSignup.statusCode == 200) {
        error = ErrorModel(
          data: jsonDecode(resSignup.body)['message'],
          error: null,
        );
      } else {
        error = ErrorModel(
          error: jsonDecode(resSignup.body)['error'],
          data: null,
        );
      }
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }
}
