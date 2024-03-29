// Mocks generated by Mockito 5.4.0 from annotations
// in flutter_clean_architecture/test/data/repositories/advice_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:flutter_clean_architecture/data/datasource/advice_remote_data_source.dart'
    as _i4;
import 'package:flutter_clean_architecture/data/models/advice_model.dart'
    as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAdviceModel_1 extends _i1.SmartFake implements _i3.AdviceModel {
  _FakeAdviceModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AdviceRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdviceRemoteDataSourceImpl extends _i1.Mock
    implements _i4.AdviceRemoteDataSourceImpl {
  @override
  _i2.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
        returnValueForMissingStub: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
      ) as _i2.Client);
  @override
  _i5.Future<_i3.AdviceModel> getRandomAdviceFromApi() => (super.noSuchMethod(
        Invocation.method(
          #getRandomAdviceFromApi,
          [],
        ),
        returnValue: _i5.Future<_i3.AdviceModel>.value(_FakeAdviceModel_1(
          this,
          Invocation.method(
            #getRandomAdviceFromApi,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.AdviceModel>.value(_FakeAdviceModel_1(
          this,
          Invocation.method(
            #getRandomAdviceFromApi,
            [],
          ),
        )),
      ) as _i5.Future<_i3.AdviceModel>);
}
