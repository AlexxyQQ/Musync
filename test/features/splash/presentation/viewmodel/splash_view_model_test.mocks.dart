// Mocks generated by Mockito 5.4.2 from annotations
// in musync/test/features/splash/presentation/viewmodel/splash_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:musync/core/failure/error_handler.dart' as _i7;
import 'package:musync/core/network/hive/hive_queries.dart' as _i3;
import 'package:musync/features/auth/domain/entity/user_entity.dart' as _i8;
import 'package:musync/features/splash/domain/repository/splash_repository.dart'
    as _i2;
import 'package:musync/features/splash/domain/use_case/splash_use_case.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeISplashRepository_0 extends _i1.SmartFake
    implements _i2.ISplashRepository {
  _FakeISplashRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHiveQueries_1 extends _i1.SmartFake implements _i3.HiveQueries {
  _FakeHiveQueries_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SplashUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSplashUseCase extends _i1.Mock implements _i5.SplashUseCase {
  @override
  _i2.ISplashRepository get splashRepository => (super.noSuchMethod(
        Invocation.getter(#splashRepository),
        returnValue: _FakeISplashRepository_0(
          this,
          Invocation.getter(#splashRepository),
        ),
        returnValueForMissingStub: _FakeISplashRepository_0(
          this,
          Invocation.getter(#splashRepository),
        ),
      ) as _i2.ISplashRepository);
  @override
  _i3.HiveQueries get hiveQueries => (super.noSuchMethod(
        Invocation.getter(#hiveQueries),
        returnValue: _FakeHiveQueries_1(
          this,
          Invocation.getter(#hiveQueries),
        ),
        returnValueForMissingStub: _FakeHiveQueries_1(
          this,
          Invocation.getter(#hiveQueries),
        ),
      ) as _i3.HiveQueries);
  @override
  _i6.Future<_i4.Either<_i7.ErrorModel, _i8.UserEntity>> initialLogin() =>
      (super.noSuchMethod(
        Invocation.method(
          #initialLogin,
          [],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i7.ErrorModel, _i8.UserEntity>>.value(
                _FakeEither_2<_i7.ErrorModel, _i8.UserEntity>(
          this,
          Invocation.method(
            #initialLogin,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Either<_i7.ErrorModel, _i8.UserEntity>>.value(
                _FakeEither_2<_i7.ErrorModel, _i8.UserEntity>(
          this,
          Invocation.method(
            #initialLogin,
            [],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.ErrorModel, _i8.UserEntity>>);
}