//login exception
class UserNotFoudAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//register exceptiom
class EmailAlreadyInUseAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

//generic Exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
