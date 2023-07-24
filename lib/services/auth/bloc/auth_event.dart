import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogin extends AuthEvent {
  final String Email;
  final String password;
  const AuthEventLogin(this.Email, this.password);
}

class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();
}
