import 'package:couple/models/setting_model.dart';
import 'package:couple/models/user_profile_model.dart';
import 'package:couple/providers/app_provider.dart';
import 'package:couple/services/user_service.dart';
import 'package:couple/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? isLoggedIn() {
    User? user = _firebaseAuth.currentUser;
    return user;
  }

  Future<UserProfileModel?> signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserProfileModel newProfile = UserProfileModel(
          uid: credential.user!.uid,
          docId: credential.user!.uid,
          username: username,
          email: email,
          setting: SettingModel(isNotificationOn: false),
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now());
      await UserService().create(newProfile);
      debugPrint("User signIn: ${credential.user?.email}");
      return newProfile;
    } catch (error) {
      debugPrint("Service Error: $error");
      return null;
    }
  }

  Future<UserProfileModel?> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      debugPrint("User signIn: ${credential.user?.email}");
      UserProfileModel? profile =
          await UserService().getByUid(credential.user!.uid);
      logger(
          message:
              "Snapshot From User Collection: ${profile?.setting.isNotificationOn}");
      return profile;
    } catch (error) {
      debugPrint("Service Error: $error");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      debugPrint("User signOut");
    } catch (error) {
      debugPrint("Service Error: $error");
    }
  }
}
