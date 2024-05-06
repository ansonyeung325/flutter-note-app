import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple/models/base_model.dart';
import 'package:couple/models/image_model.dart';
import 'package:couple/models/setting_model.dart';
import 'package:couple/utils/modelKeys/base_model_keys.dart';
import 'package:couple/utils/modelKeys/user_profile_model_keys.dart';
import 'package:flutter/foundation.dart';

class UserProfileModel extends BaseModel {
  String uid;
  String username;
  String email;
  ImageModel? profileImage;
  SettingModel setting;

  UserProfileModel({
    required this.uid,
    required this.username,
    required this.email,
    this.profileImage,
    required this.setting,
    required String docId,
    required Timestamp createdAt,
    Timestamp? updatedAt,
  }) : super(docId: docId, createdAt: createdAt, updatedAt: updatedAt);

  UserProfileModel.copy(UserProfileModel profile)
      : this(
            uid: profile.uid,
            username: profile.username,
            email: profile.email,
            docId: profile.docId,
            profileImage: profile.profileImage,
            setting: profile.setting,
            createdAt: profile.createdAt,
            updatedAt: profile.updatedAt);

  Map<String, dynamic> toJson() {
    return {
      UserProfileModelKeys.uid: uid,
      UserProfileModelKeys.username: username,
      UserProfileModelKeys.email: email,
      UserProfileModelKeys.setting: setting.toJson(),
      UserProfileModelKeys.profileImage: profileImage?.name,
      BaseModelKeys.createdAt: createdAt,
      BaseModelKeys.updatedAt: updatedAt,
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
      setting: SettingModel.fromObject(
          docSnapshot.get(UserProfileModelKeys.setting)),
      docId: docSnapshot.get(BaseModelKeys.docId),
      createdAt: docSnapshot.get(BaseModelKeys.createdAt),
      updatedAt: docSnapshot.get(BaseModelKeys.updatedAt),
    );
  }
}
