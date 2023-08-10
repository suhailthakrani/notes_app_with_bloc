import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_with_bloc/blocs/view_note/view_note_bloc.dart';

class ViewNoteScreen extends StatelessWidget {
  const ViewNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewNoteBloc, ViewNoteState>(
      bloc: context.read<ViewNoteBloc>()..add(ViewNoteInitialEvent()),
      builder: (context, state) {
        if (state is ViewNoteInitialState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is ViewNoteLoadedState) {
          return Scaffold(
            appBar: AppBar(),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  state.note.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                  softWrap: true,
                ),
                Text(
                  state.note.body,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                  softWrap: true,
                ),
              ],
            ),
          );
        }
        return const Scaffold();
      },
    );
  }
}
