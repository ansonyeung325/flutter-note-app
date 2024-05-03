import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple/models/base_model.dart';
import 'package:couple/utils/modelKeys/base_model_keys.dart';
import 'package:couple/utils/modelKeys/setting_model_keys.dart';

class SettingModel {
  bool? isNotificationOn = true;

  SettingModel({this.isNotificationOn});

  SettingModel.copy(SettingModel setting)
      : this(isNotificationOn: setting.isNotificationOn);

  Map<String, dynamic> toJson() {
    return {
      SettingModelKeys.isNotificationOn: isNotificationOn,
    };
  }

  factory SettingModel.fromSnapshot(DocumentSnapshot docSnapshot) {
    return SettingModel(
      isNotificationOn: docSnapshot.get(SettingModelKeys.isNotificationOn),
    );
  }
}
