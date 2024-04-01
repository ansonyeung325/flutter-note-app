import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple/utils/modelKeys/base_model_keys.dart';
import 'package:couple/utils/modelKeys/note_model_keys.dart';
import 'package:couple/models/base_model.dart';

class NoteModel extends BaseModel {
  String title;
  String? content;
  NoteModel(
      {required this.title,
      this.content,
      required Timestamp createdAt,
      Timestamp? updatedAt,
      required String docId})
      : super(docId: docId, createdAt: createdAt, updatedAt: createdAt);

  Map<String, dynamic> toJson() {
    return {
      NoteModelKeys.title: title,
      NoteModelKeys.content: content,
      BaseModelKeys.docId: docId,
      BaseModelKeys.createdAt: createdAt,
      BaseModelKeys.updatedAt: updatedAt,
    };
  }

  factory NoteModel.fromSnapshot(DocumentSnapshot docSnapshot) {
    return NoteModel(
      title: docSnapshot.get(NoteModelKeys.title),
      content: docSnapshot.get(NoteModelKeys.content),
      docId: docSnapshot.get(BaseModelKeys.docId),
      createdAt: docSnapshot.get(BaseModelKeys.createdAt),
      updatedAt: docSnapshot.get(BaseModelKeys.updatedAt),
    );
  }
}
