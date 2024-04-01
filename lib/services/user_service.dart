import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple/utils/modelKeys/user_profile_model_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:couple/models/user_profile_model.dart';
import 'package:couple/utils/firestore_collection.dart';

class UserService {
  final usersRef =
      FirebaseFirestore.instance.collection(FirestoreCollection.users);

  Future<UserProfileModel?> create(UserProfileModel newProfile) async {
    try {
      await usersRef.doc(newProfile.docId).set(newProfile.toJson());
      return newProfile;
    } catch (error) {
      debugPrint("$error");
      return null;
    }
  }

  Future<void> update() async {}

  Future<UserProfileModel?> getByUid(String uid) async {
    try {
      final snapshot =
          await usersRef.where(UserProfileModelKeys.uid, isEqualTo: uid).get();
      final profile =
          snapshot.docs.map((e) => UserProfileModel.fromSnapshot(e)).first;
      return profile;
    } catch (error) {
      debugPrint("$error");
      return null;
    }
  }

  Future<void> delete() async {}
}
