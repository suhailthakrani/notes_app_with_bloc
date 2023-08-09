part of 'view_note_bloc.dart';

sealed class ViewNoteState extends Equatable {
  const ViewNoteState();
  
  @override
  List<Object> get props => [];
}

final class ViewNoteInitialState extends ViewNoteState {}
final class ViewNoteLoadedState extends ViewNoteState {
  final Note note;
  const ViewNoteLoadedState({required this.note});
  
  @override
  List<Object> get props => [note];
}
final class ViewNoteNavigateBackState extends ViewNoteState {}
