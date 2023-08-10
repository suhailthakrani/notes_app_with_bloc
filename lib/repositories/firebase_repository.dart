import 'package:cloud_firestore/cloud_firestore.dart';

import '../commons/models/notes_model.dart';

class FirebaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Note>> getAllNotes() async {
    try {
      final notesQuery = _firebaseFirestore.collection('notes');
      final notes = await notesQuery.get();
      return notes.docs.map((doc) => Note.fromMap(doc.data())).toList();
    } on Exception catch (e) {
      print("[ERROR in loading notes]: $e");
      return [];
    }
  }

  Future<void> addNote(Note note) async {
    try {
      DocumentReference docReference =  _firebaseFirestore.collection('notes').doc();
      note = note.copyWith(id: docReference.id);
      docReference.set(note.toMap());
    } on Exception catch (e) {
      print("[ERROR in creating notes]: $e");
    }
  }

  // Will be added later
  Future<void> deleteNote(String noteId) async {
    try {
      await _firebaseFirestore.collection('notes').doc(noteId).delete();
    } catch (e) {
      print("[ERROR in deleting notes]: $e");
    }
    
  }
}
