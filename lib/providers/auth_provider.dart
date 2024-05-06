import 'package:couple/models/user_profile_model.dart';
import 'package:couple/providers/app_provider.dart';
import 'package:couple/services/auth_services.dart';
import 'package:couple/services/user_service.dart';
import 'package:couple/utils/components/message_toast.dart';
import 'package:couple/utils/error_handler/auth_error.dart';
import 'package:couple/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends AppProvider {
  final _authService = AuthServices();
  final _userService = UserService();

  UserProfileModel? _profile;
  bool isLoggedIn = false;

  Future<void> getCurrentUser() async {
    User? user = _authService.isLoggedIn();
    if (user != null) {
      isLoggedIn = true;
      UserProfileModel? profile = await _userService.getByUid(user.uid);
      if (profile != null) {
        setProfile(profile);
        logger(message: "User ${profile.email} loggedIn", from: "AuthProvider");
      } else {
        logger(message: "Could not find user profile", from: "AuthProvider");
      }
    } else {
      logger(
          message: "User not login yet, redirect to login screen",
          from: "AuthProvider");
    }
  }

  Future<void> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      UserProfileModel? profile = await _authService.signUp(
          username: username, email: email, password: password);
      if (profile != null) {
        setProfile(profile);
        isLoggedIn = true;
      }
      AMessageToast.showToast(msg: "SignUp successfully");
    } on FirebaseAuthException catch (e) {
      debugPrint("${e.code}: ${AuthError.getError(e.code)}");
      AMessageToast.showToast(msg: AuthError.getError(e.code));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      UserProfileModel? profile =
          await _authService.signIn(email: email, password: password);
      if (profile != null) {
        setProfile(profile);
        isLoggedIn = true;
      }
      AMessageToast.showToast(msg: "SignIn successfully");
    } on FirebaseAuthException catch (e) {
      debugPrint("${e.code}: ${AuthError.getError(e.code)}");
      AMessageToast.showToast(msg: AuthError.getError(e.code));
    }
  }

  void signOut() async {
    try {
      _authService.signOut();
      removeProfile();
      isLoggedIn = false;
    } on FirebaseAuthException catch (error) {
      debugPrint("${error.message}");
    }
  }

  void setProfile(UserProfileModel userProfile) {
    _profile = userProfile;
    notifyListeners();
  }

  void removeProfile() {
    _profile = null;
    notifyListeners();
  }

  UserProfileModel? get profile => _profile;
  String? get userId => _profile?.uid;
}
