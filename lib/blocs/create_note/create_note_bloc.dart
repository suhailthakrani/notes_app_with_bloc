import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notes_app_with_bloc/repositories/firebase_repository.dart';

import '../../commons/models/notes_model.dart';

part 'create_note_event.dart';
part 'create_note_state.dart';

class CreateNoteBloc extends Bloc<CreateNoteEvent, CreateNoteState> {
  final FirebaseRepository repository;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  CreateNoteBloc(
    this.repository,
  ) : super(CreateNoteInitialState()) {
    on<CreateNoteSaveButtonPressedEvent>(
        mapCreateNoteSaveButtonPressedEventToState);
    on<CreateNavigateBackPressedEvent>(
        mapCreateNavigateBackPressedEventToState);
  }
  Future<FutureOr<void>> mapCreateNoteSaveButtonPressedEventToState(
      CreateNoteSaveButtonPressedEvent event,
      Emitter<CreateNoteState> emit) async {
    final Note note = Note(
        id: '',
        title: titleController.text,
        body: descriptionController.text);
    await repository.addNote(note);
    emit(CreateNoteNavigateBackState());
  }

  FutureOr<void> mapCreateNavigateBackPressedEventToState(
      CreateNavigateBackPressedEvent event, Emitter<CreateNoteState> emit) {
    emit(CreateNoteNavigateBackState());
  }
}
