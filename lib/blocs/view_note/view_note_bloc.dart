import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../commons/models/notes_model.dart';

part 'view_note_event.dart';
part 'view_note_state.dart';

class ViewNoteBloc extends Bloc<ViewNoteEvent, ViewNoteState> {
  ViewNoteBloc() : super(ViewNoteInitialState()) {
    on<ViewNoteInitialEvent>(mapViewNoteInitialEventToState);
    on<ViewLoadNoteEvent>(mapViewLoadEventToState);
    on<ViewNavigateBackNoteEvent>(mapViewNavigateBackEventToState);

  }

  FutureOr<void> mapViewLoadEventToState(ViewLoadNoteEvent event, Emitter<ViewNoteState> emit) {
    
    emit(ViewNoteLoadedState(note: event.note));
    
  }

  FutureOr<void> mapViewNavigateBackEventToState(ViewNavigateBackNoteEvent event, Emitter<ViewNoteState> emit) {
    emit(ViewNoteNavigateBackState());
  }

  FutureOr<void> mapViewNoteInitialEventToState(ViewNoteInitialEvent event, Emitter<ViewNoteState> emit) {

  }
}
