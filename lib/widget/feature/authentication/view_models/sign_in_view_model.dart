import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/utils.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/repos/authentication_repo.dart';

import 'package:go_router/go_router.dart';

class SignInViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> signin(
    String email,
    String password,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async => await _repository.emailLogin(
        email,
        password,
      ),
    );

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go("/home");
    }
  }
}

final signinForm = StateProvider((ref) => {});

final signinProvider = AsyncNotifierProvider<SignInViewModel, void>(
  () => SignInViewModel(),
);
