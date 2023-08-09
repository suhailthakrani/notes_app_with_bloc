part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();
  
  @override
  List<Object> get props => [];
}
abstract class NotesActionState extends NotesState {
  const NotesActionState();
  
  @override
  List<Object> get props => [];
}

final class NotesLoadingState extends NotesState {}

final class NotesLoadedState extends NotesState {
  final List<Note> notes;
  const NotesLoadedState({required this.notes});
  
  @override
  List<Object> get props => [notes];
}

final class NotesErrorState extends NotesState {
  final String error;
  const NotesErrorState({required this.error});
  
  @override
  List<Object> get props => [error];
}

class NotesNavigateToViewNoteState extends NotesActionState {
  final Note note;
  const NotesNavigateToViewNoteState({required this.note});
  
  @override
  List<Object> get props => [note];
}
final class NotesNavigateToCreateNoteState extends NotesActionState {}


