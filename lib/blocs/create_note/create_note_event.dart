part of 'create_note_bloc.dart';

sealed class CreateNoteEvent extends Equatable {
  const CreateNoteEvent();

  @override
  List<Object> get props => [];
}

class CreateNavigateBackPressedEvent extends CreateNoteEvent {}
class CreateNoteSaveButtonPressedEvent extends CreateNoteEvent {}

