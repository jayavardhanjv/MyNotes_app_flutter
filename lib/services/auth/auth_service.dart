import 'package:flutter_application_2/services/auth/auth_user.dart';
import 'package:flutter_application_2/services/auth/auth_provider.dart';
import 'package:flutter_application_2/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(
        email: email,
        password: password,
      );

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerisfication() => provider.sendEmailVerisfication();

  @override
  Future<void> initialize() => provider.initialize();
}
