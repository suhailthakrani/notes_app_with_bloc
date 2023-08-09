// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'view_note_bloc.dart';

sealed class ViewNoteEvent extends Equatable {
  const ViewNoteEvent();

  @override
  List<Object> get props => [];
}
class ViewNoteInitialEvent extends ViewNoteEvent {}

class ViewLoadNoteEvent extends ViewNoteEvent {
  final Note note;
  const ViewLoadNoteEvent(
    this.note,
  );

  @override
  List<Object> get props => [note];
}
class ViewNavigateBackNoteEvent extends ViewNoteEvent {
  const ViewNavigateBackNoteEvent();

  @override
  List<Object> get props => [];
}
