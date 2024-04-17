import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple/models/base_model.dart';
import 'package:couple/models/image_model.dart';
import 'package:couple/utils/modelKeys/base_model_keys.dart';
import 'package:couple/utils/modelKeys/user_profile_model_keys.dart';
import 'package:flutter/foundation.dart';

class UserProfileModel extends BaseModel {
  String uid;
  String username;
  String email;
  ImageModel? profileImage;

  String? imagePath;
  UserProfileModel(
      {required this.uid,
      required this.username,
      required this.email,
      this.profileImage,
      required String docId,
      required Timestamp createdAt,
      Timestamp? updatedAt,
      this.imagePath})
      : super(docId: docId, createdAt: createdAt, updatedAt: updatedAt);

  UserProfileModel.copy(UserProfileModel profile)
      : this(
            uid: profile.uid,
            username: profile.username,
            email: profile.email,
            docId: profile.docId,
            profileImage: profile.profileImage,
            createdAt: profile.createdAt);

  Map<String, dynamic> toJson() {
    return {
      UserProfileModelKeys.uid: uid,
      UserProfileModelKeys.username: username,
      UserProfileModelKeys.email: email,
      UserProfileModelKeys.profileImage: profileImage?.name,
      UserProfileModelKeys.createdAt: createdAt,
    };
  }

  factory UserProfileModel.fromSnapshot(DocumentSnapshot docSnapshot) {
    return UserProfileModel(
      uid: docSnapshot.get(UserProfileModelKeys.uid),
      username: docSnapshot.get(UserProfileModelKeys.username),
      email: docSnapshot.get(UserProfileModelKeys.email),
      profileImage: docSnapshot.get(UserProfileModelKeys.profileImage) != null
          ? ImageModel(
              name: docSnapshot.get(UserProfileModelKeys.profileImage),
              data: null)
          : null,
      docId: docSnapshot.get(BaseModelKeys.docId),
      createdAt: docSnapshot.get(BaseModelKeys.createdAt),
      updatedAt: docSnapshot.get(BaseModelKeys.updatedAt),
    );
  }
}
