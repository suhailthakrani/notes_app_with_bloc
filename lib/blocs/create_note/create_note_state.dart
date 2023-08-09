part of 'create_note_bloc.dart';

sealed class CreateNoteState extends Equatable {
  const CreateNoteState();
  
  @override
  List<Object> get props => [];
}

final class CreateNoteInitialState extends CreateNoteState {}

class CreateNavigateBackState extends CreateNoteState {}

final class CreateNoteNavigateBackState extends CreateNoteState {}

