// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class NotesLoadNotesEvent extends NotesEvent {
  const NotesLoadNotesEvent();

  @override
  List<Object> get props => [];
}

class NotesCreateNoteEvent extends NotesEvent {
  const NotesCreateNoteEvent();

  @override
  List<Object> get props => [];
}
class NotesViewNoteEvent extends NotesEvent {
  final Note note;
  const NotesViewNoteEvent(
    this.note,
  );

  @override
  List<Object> get props => [note];
}


