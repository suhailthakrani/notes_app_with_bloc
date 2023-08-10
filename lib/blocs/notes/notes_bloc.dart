// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';


import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_with_bloc/blocs/view_note/view_note_bloc.dart';

import 'package:notes_app_with_bloc/repositories/firebase_repository.dart';

import '../../commons/models/notes_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final FirebaseRepository firebaseRepository;
  NotesBloc(
    this.firebaseRepository,
  ) : super(NotesLoadingState()) {
    on<NotesLoadNotesEvent>(mapLoadNotesEventWithState);
    on<NotesCreateNoteEvent>(mapCreateNoteEventWithState);
    on<NotesViewNoteEvent>(mapViewNoteEventWithState);
  }

  Future<FutureOr<void>> mapLoadNotesEventWithState(
      NotesLoadNotesEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    final notes = await firebaseRepository.getAllNotes();
    emit(NotesLoadedState(notes: notes));
  }

  Future<FutureOr<void>> mapCreateNoteEventWithState(
      NotesCreateNoteEvent event, Emitter<NotesState> emit) async {
    emit(NotesNavigateToCreateNoteState());
  }

  FutureOr<void> mapViewNoteEventWithState(
      NotesViewNoteEvent event, Emitter<NotesState> emit) {
    emit(NotesNavigateToViewNoteState(note: event.note));
  }

  @override
  void onTransition(Transition<NotesEvent, NotesState> transition) {
    if (transition.nextState is NotesLoadingState) {
      add(const NotesLoadNotesEvent());
    }
    if (transition.nextState is NotesNavigateToCreateNoteState) {
      add(const NotesLoadNotesEvent());
    }
    if (transition.nextState is NotesNavigateToViewNoteState) {
      add(const NotesLoadNotesEvent());
    }
    super.onTransition(transition);
  }
}
