import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple/models/base_model.dart';

class BaseService {
  ///Create common service for doc CRUD
  // Future<void> addDocument(
  //     CollectionReference<Map<String, dynamic>> ref, Map<String, dynamic> document) async {
  //   document.createdAt = Timestamp.fromDate(DateTime.now());
  //
  // }
  //
  // Future<void> updateDocument(
  //     CollectionReference<Map<String, dynamic>> ref, Map<String, dynamic> document) async {
  //   document.updatedAt = Timestamp.fromDate(DateTime.now());
  //   ref.doc(document.docId).update(document.toJson);
  // }
  //
  // Future<void> deleteDocument(
  //     CollectionReference<Map<String, dynamic>> ref, Map<String, dynamic> document) async {}
}
