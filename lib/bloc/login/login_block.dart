import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:quela/bloc/auth/auth.dart';
import 'package:quela/bloc/auth/auth_block.dart';
import 'package:quela/bloc/auth/event.dart';
import 'package:quela/bloc/login/event.dart';
import 'package:quela/bloc/login/state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final Auth auth;
  final AuthBloc authBloc;

  LoginBloc({
    @required this.auth,
    @required this.authBloc,
  })  : assert(auth != null),
        assert(authBloc != null);

  @override
  LoginStates get initialState => BeforeLogin();

  @override
  Stream<LoginStates> mapEventToState(
    LoginStates currentState,
    LoginEvents event,
  ) async* {
    if (event is ButtonPressed) {
      yield Loading();
      try {
        final token = await auth.signIn(
          email: event.email,
          password: event.password,
        );

        authBloc.dispatch(LoggedIn(token: token));
        yield BeforeLogin();
      } catch (error) {
        yield Failure(error: error.toString());
      }
    }
  }
}
