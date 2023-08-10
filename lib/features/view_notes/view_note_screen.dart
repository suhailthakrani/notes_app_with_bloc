import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_with_bloc/blocs/view_note/view_note_bloc.dart';

class ViewNoteScreen extends StatelessWidget {
  const ViewNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewNoteBloc, ViewNoteState>(
      listener: (context, state) {
        if (state is ViewNoteNavigateBackState) {
          Navigator.of(context).pop();
        }
      },
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
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      context
                          .read<ViewNoteBloc>()
                          .add(const ViewNavigateBackNoteEvent());
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                body: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Text(
                      state.note.title,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      softWrap: true,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.note.body,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              );
            }
            return Scaffold(
              body: Center(
                  child: Text(
                state.toString(),
                style: const TextStyle(color: Colors.white),
              )),
            );
          },
        );
     
  }
}
