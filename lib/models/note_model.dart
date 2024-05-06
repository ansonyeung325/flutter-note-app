import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple/models/user_profile_model.dart';
import 'package:couple/utils/modelKeys/base_model_keys.dart';
import 'package:couple/utils/modelKeys/note_model_keys.dart';
import 'package:couple/models/base_model.dart';

class NoteModel extends BaseModel {
  String? title;
  String? content;
  String owner;
  List<dynamic>? sharedUsers;
  bool? readOnly;

  NoteModel(
      {this.title = "Untitled",
      this.content = "",
      required this.owner,
      this.readOnly = true,
      this.sharedUsers = const [],
      required Timestamp createdAt,
      Timestamp? updatedAt,
      required String docId})
      : super(docId: docId, createdAt: createdAt, updatedAt: createdAt);

  NoteModel.copy(NoteModel note)
      : this(
          title: note.title,
          content: note.content,
          owner: note.owner,
          readOnly: note.readOnly,
          sharedUsers: note.sharedUsers,
          createdAt: note.createdAt,
          docId: note.docId,
        );

  Map<String, dynamic> toJson() {
    return {
      NoteModelKeys.title: title,
      NoteModelKeys.content: content,
      NoteModelKeys.owner: owner,
      NoteModelKeys.readOnly: readOnly,
      NoteModelKeys.sharedUsers: sharedUsers,
      BaseModelKeys.docId: docId,
      BaseModelKeys.createdAt: createdAt,
      BaseModelKeys.updatedAt: updatedAt,
    };
  }

  factory NoteModel.fromSnapshot(DocumentSnapshot docSnapshot) {
    return NoteModel(
      title: docSnapshot.get(NoteModelKeys.title),
      content: docSnapshot.get(NoteModelKeys.content),
      owner: docSnapshot.get(NoteModelKeys.owner),
      sharedUsers: docSnapshot.get(NoteModelKeys.sharedUsers),
      readOnly: docSnapshot.get(NoteModelKeys.readOnly),
      docId: docSnapshot.get(BaseModelKeys.docId),
      createdAt: docSnapshot.get(BaseModelKeys.createdAt),
      updatedAt: docSnapshot.get(BaseModelKeys.updatedAt),
    );
  }
}
