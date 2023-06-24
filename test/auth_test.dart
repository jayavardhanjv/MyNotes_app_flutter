import 'package:flutter_application_2/services/auth/auth_exception.dart';
import 'package:flutter_application_2/services/auth/auth_provider.dart';
import 'package:flutter_application_2/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authprovider', () {
    final provider = MockAuthProvider();
    test('should not be initialized to begine with', () async {
      expect(provider._isInitialized, false);
    });

    test('cannot logout if not initialized', () {
      expect(provider.logout(), throwsA(const TypeMatcher<NotInitialized>()));
    });
    test('should not be initialized to begine with', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test('User should not be null after initialized', () {
      expect(provider.currentUser, null);
    });
    test(
      'should be able to initialized in less than 2 seons',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );
    test('Create User should delegate  to login funtion', () async {
      final badEmailUser = provider.createUser(
        email: 'foo@bar.com',
        password: 'anypassword',
      );
      expect(
          badEmailUser, throwsA(const TypeMatcher<UserNotFoudAuthException>()));

      final badPasswordUser = provider.createUser(
        email: 'someone@bar.com',
        password: 'foobar',
      );
      expect(badPasswordUser,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));

      final user = await provider.createUser(
        email: 'foo',
        password: 'bar',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('Login user should be able to get verified', () {
      provider.sendEmailVerisfication();
      final user = provider.currentUser;
      expect(user!.isEmailVerified, true);
    });
    test('should be able to logout and login ahain', () async {
      await provider.logout();
      await provider.login(
        email: 'email',
        password: 'password',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitialized implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitialized();
    await Future.delayed(const Duration(seconds: 1));
    return login(
      email: email,
      password: password,
    );
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    // TODO: implement initialize
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitialized();
    if (email == 'foo@bar.com') throw UserNotFoudAuthException();
    if (password == 'foobar') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logout() async {
    if (!isInitialized) throw NotInitialized();
    if (_user == null) throw UserNotFoudAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerisfication() async {
    if (!isInitialized) throw NotInitialized();
    final user = _user;
    if (user == null) throw UserNotFoudAuthException();
    const newuser = AuthUser(isEmailVerified: true);
    _user = newuser;
  }
}
