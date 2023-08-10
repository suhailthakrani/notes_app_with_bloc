import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_with_bloc/blocs/create_note/create_note_bloc.dart';
import 'package:notes_app_with_bloc/blocs/view_note/view_note_bloc.dart';
import 'package:notes_app_with_bloc/commons/widgets/note_card.dart';
import 'package:notes_app_with_bloc/features/view_notes/view_note_screen.dart';

import '../../blocs/notes/notes_bloc.dart';
import '../../commons/models/notes_model.dart';
import '../add_notes/add_notes_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          "Notes",
          style:
              TextStyle(fontWeight: FontWeight.w600, fontSize: 28, height: 1.5),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<NotesBloc, NotesState>(
          bloc: BlocProvider.of(context)..add(const NotesLoadNotesEvent()),
          listener: (context, state) {
            if (state is NotesNavigateToCreateNoteState) {
              final route = MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => CreateNoteBloc(
                      context.read<NotesBloc>().firebaseRepository),
                  child: const AddNoteScreen(),
                ),
              );
              Navigator.push(context, route);
            } else if (state is NotesNavigateToViewNoteState) {
              final route = MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) =>
                      ViewNoteBloc()..add(ViewLoadNoteEvent(state.note)),
                  child: const ViewNoteScreen(),
                ),
              );
              Navigator.push(context, route);
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case NotesLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case NotesLoadedState:
                final loadedState = state as NotesLoadedState;
                final notes = loadedState.notes;
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                
                      SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none),
                            hintText: 'Search Notes',
                            filled: true,
                            fillColor: const Color(0xFF252329),
                            hintStyle: const TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.separated(
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            Note note = notes[index];

                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<NotesBloc>()
                                    .add(NotesViewNoteEvent(note));
                              },
                              child: NoteCard(note: note),
                            );
                          },
                          separatorBuilder: (_, int index) =>
                              const SizedBox(height: 8),
                        ),
                      ),
                    ],
                  ),
                );
              case NotesErrorState:
                final errorState = state as NotesErrorState;
                return Center(
                  child: Text(errorState.error),
                );
              default:
                print(state);
                return Center(
                  child: Text(state.toString()),
                );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff17c90a),
        onPressed: () {
          context.read<NotesBloc>().add(const NotesCreateNoteEvent());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
