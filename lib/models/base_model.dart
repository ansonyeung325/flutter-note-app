import 'package:cloud_firestore/cloud_firestore.dart';

class BaseModel {
  String docId;
  Timestamp createdAt;
  Timestamp? updatedAt;

  BaseModel({required this.docId, required this.createdAt, this.updatedAt}) {
    updatedAt ??= Timestamp.fromDate(DateTime.now());
  }
}
