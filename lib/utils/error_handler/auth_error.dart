class AuthError {
  static String getError(String errorCode) {
    switch (errorCode) {
      case "email-already-in-use":
        return "This email address is already in use, use a different email or signIn.";
      case "too-many-requests":
        return "Fail to login multiple times,try again later.";
      case "user-not-found:":
        return "Email address or password incorrect.";
      case "wrong-password":
        return "Email address or password incorrect.";
      default:
        return "Something went wrong, try again later.";
    }
  }
}
