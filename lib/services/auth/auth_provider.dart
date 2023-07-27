import 'package:flutter_application_2/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<AuthUser> login({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<void> sendEmailVerisfication();
  Future<void> sendPasswordReset({required String toEmail});
}
