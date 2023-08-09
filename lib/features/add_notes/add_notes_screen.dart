import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_with_bloc/blocs/create_note/create_note_bloc.dart';
import 'package:notes_app_with_bloc/blocs/notes/notes_bloc.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocProvider.of<CreateNoteBloc>(context),
      child: BlocConsumer<CreateNoteBloc, CreateNoteState>(
        listener: (context, state) {
          if (state is CreateNoteNavigateBackState) {
            context.read<NotesBloc>().add(const NotesLoadNotesEvent());
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CreateNoteInitialState:
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      context
                          .read<CreateNoteBloc>()
                          .add(CreateNavigateBackPressedEvent());
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.indigo.shade600,
                    ),
                  ),
                  title: Text(
                    'Add New Note',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                 
                  actions: [
                    InkWell(
                      onTap: () async {
                        context
                            .read<CreateNoteBloc>()
                            .add(CreateNoteSaveButtonPressedEvent());
                      },
                      child: Icon(
                        Icons.done,
                        color: Colors.indigo.shade800,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller:
                            context.read<CreateNoteBloc>().titleController,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.indigo.shade800,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: context
                              .read<CreateNoteBloc>()
                              .descriptionController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: 'Note something down',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

            default:
              return Scaffold();
          }
        },
      ),
    );
  }
}
