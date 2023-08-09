import 'package:cloud_firestore/cloud_firestore.dart';

import '../commons/models/notes_model.dart';

class FirebaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Note>> getAllNotes() async {
    try {
      final notesQuery = _firebaseFirestore.collection('notes');
      final notes = await notesQuery.get();
      print(notes.docs.first.data().entries);
      return notes.docs.map((doc) => Note.fromMap(doc.data())).toList();
    } on Exception catch (e) {
      print("[ERROR in loading notes]: $e");
      return [];
    }
  }

  Future<void> addNote(Note note) async {
    DocumentReference docReference =
        _firebaseFirestore.collection('notes').doc();
    note.copyWith(id: docReference.id);
    docReference.set(note.toMap());
  }

  Future<void> deleteNote(String noteId) async {
    await _firebaseFirestore.collection('notes').doc(noteId).delete();
  }
}
