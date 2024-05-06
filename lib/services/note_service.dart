import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple/models/image_model.dart';
import 'package:couple/models/note_model.dart';
import 'package:couple/services/media_service.dart';
import 'package:couple/utils/logger.dart';
import 'package:couple/utils/modelKeys/note_model_keys.dart';
import 'package:couple/utils/modelKeys/user_profile_model_keys.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:couple/utils/firestore_collection.dart';

class NoteService {
  final notesRef =
      FirebaseFirestore.instance.collection(FirestoreCollection.notes);

  Future<NoteModel?> create(NoteModel newNote) async {
    try {
      await notesRef.doc(newNote.docId).set((newNote.toJson()));
      return newNote;
    } catch (error) {
      logger(from: "Note Service create method", message: '$error');
      return null;
    }
  }

  Future<NoteModel?> update(NoteModel updatedNote) async {
    updatedNote.updatedAt = Timestamp.fromDate(DateTime.now());

    try {
      await notesRef.doc(updatedNote.docId).update(updatedNote.toJson());
      return updatedNote;
    } catch (error) {
      logger(from: "Note Service update method", message: '$error');
      return null;
    }
  }

  Future<void> delete(String noteId) async {
    try {
      await notesRef.doc(noteId).delete();
      return;
    } catch (error) {
      logger(from: "Note Service delete method", message: '$error');
    }
  }

  Future<List<NoteModel>?> getByUserId(String userId) async {
    try {
      final snapshot =
          await notesRef.where(NoteModelKeys.owner, isEqualTo: userId).get();
      final notes =
          snapshot.docs.map((e) => NoteModel.fromSnapshot(e)).toList();
      return notes;
    } catch (error) {
      logger(from: "Note Service GET method", message: '$error');
      return null;
    }
  }
}
