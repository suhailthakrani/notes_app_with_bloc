import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_with_bloc/blocs/create_note/create_note_bloc.dart';
import 'package:notes_app_with_bloc/blocs/view_note/view_note_bloc.dart';
import 'package:notes_app_with_bloc/features/view_notes/view_note_screen.dart';

import '../../blocs/notes/notes_bloc.dart';
import '../../commons/models/notes_model.dart';
import '../add_notes/add_notes_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
            print(state);

            switch (state.runtimeType) {
              case NotesLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case NotesLoadedState:
                final loadedState = state as NotesLoadedState;
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none),
                          hintText: 'Search Notes',
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ListView.separated(
                          itemCount: loadedState.notes.length,
                          itemBuilder: (context, index) {
                            Note note = loadedState.notes[index];

                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<NotesBloc>()
                                    .add(NotesViewNoteEvent(note));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              note.title,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              softWrap: true,
                                            ),
                                            Text(
                                              note.body,
                                              maxLines: 2,
                                              textAlign: TextAlign.justify,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.delete,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, int index) => const Divider(),
                        ),
                      ),
                    ),
                  ],
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
        // backgroundColor:

        //     Theme.of(context).floatingActionButtonTheme.backgroundColor,
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

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hi, Suhail Thakrani",
            style: textTheme.headlineSmall,
          ),
          const Icon(
            CupertinoIcons.person_alt_circle,
          )
        ],
      ),
    );
  }
}
