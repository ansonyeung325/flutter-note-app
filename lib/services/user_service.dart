import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple/models/image_model.dart';
import 'package:couple/models/setting_model.dart';
import 'package:couple/services/media_service.dart';
import 'package:couple/utils/logger.dart';
import 'package:couple/utils/modelKeys/user_profile_model_keys.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:couple/models/user_profile_model.dart';
import 'package:couple/utils/firestore_collection.dart';
import 'package:provider/provider.dart';

class UserService {
  final usersRef =
      FirebaseFirestore.instance.collection(FirestoreCollection.users);
  final mediaService = MediaService();

  Future<UserProfileModel?> create(UserProfileModel newProfile) async {
    try {
      await usersRef.doc(newProfile.docId).set(newProfile.toJson());
      return newProfile;
    } catch (error) {
      logger(from: "User Service create method error",message: "$error");
      return null;
    }
  }

  // Future<SettingModel?> updateSetting(String uid, SettingModel setting) async {
  //   try {} catch (error) {
  //     logger(from: "UserService updateSetting", message: "$error");
  //   }
  // }

  Future<UserProfileModel?> update(UserProfileModel newProfile) async {
    ImageModel? profileImage;

    newProfile.updatedAt = Timestamp.fromDate(DateTime.now());
    try {
      if (newProfile.profileImage != null) {
        await mediaService.uploadImage(newProfile.profileImage!);
        profileImage =
            await mediaService.getImage(newProfile.profileImage!.name);
      }
      await usersRef.doc(newProfile.docId).update(newProfile.toJson());
      UserProfileModel? updatedProfile = await getByUid(newProfile.uid);
      updatedProfile?.profileImage = profileImage;
      return updatedProfile;
    } catch (error) {
      logger(from: "User Service update method error",message: "$error");
      return null;
    }
  }

  Future<UserProfileModel?> getByUid(String uid) async {
    try {
      final snapshot =
          await usersRef.where(UserProfileModelKeys.uid, isEqualTo: uid).get();
      final profile =
          snapshot.docs.map((e) => UserProfileModel.fromSnapshot(e)).first;
      if (profile.profileImage != null) {
        final profileImage =
            await mediaService.getImage(profile.profileImage!.name);
        profile.profileImage = profileImage;
      }
      return profile;
    } catch (error) {
      logger(from: "User Service GET method error",message: "$error");
      return null;
    }
  }

  Future<void> delete() async {}
}
