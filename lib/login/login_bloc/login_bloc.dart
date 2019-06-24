import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:floom/login/user.dart';
import 'package:floom/login/validators.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
  User _user;
  
  LoginBloc({
    @required User user
  }): assert(user != null),
  _user = user;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transform(Stream<LoginEvent> events, Stream<LoginState> Function(LoginEvent event) next) {
    final observableStream = events as Observable<LoginEvent>;
    final nonDebounceStream = observableStream.where((event){
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event){
      return(event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _user.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

   Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _user.signInWithCredentials(email, password);
      yield LoginState.success();
      _user.email = email;
    } catch (_) {
      yield LoginState.failure();
    }
  }


}
