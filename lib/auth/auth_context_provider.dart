class AuthContextProvider {
  String? _token;

  bool get isSignedIn => _token != null;

  void signOut() => _token = null;

  void signIn(String token) => _token = token;

  String get token => _token!;
}
