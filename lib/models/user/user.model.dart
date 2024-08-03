class User {
  final int id;
  final String fullName;
  final String email;
  final bool isGoogleAuthenticated;

  User(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.isGoogleAuthenticated});
}
