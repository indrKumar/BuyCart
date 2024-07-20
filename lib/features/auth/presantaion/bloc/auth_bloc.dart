import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:vFASHU/features/auth/data/models/loginotpmodal.dart';
import 'package:vFASHU/features/auth/domain/model.dart';
import '../../userparams.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;

  AuthBloc({
    required UserLogin userLogin,
  })  : _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthLogin>(_onAuthLogin);
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userLogin(UserLoginParams(
      number: event.contact,
    ));
    log("message");
    res!.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }
  void _emitAuthSuccess(
      UserSendOTP user,
      Emitter<AuthState> emit,
      ) {
    // _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
