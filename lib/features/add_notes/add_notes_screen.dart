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
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text(
                    'Add New Note',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                       color: Colors.white,
                    ),
                  ),
                 
                  actions: [
                    InkWell(
                      onTap: () async {
                        context
                            .read<CreateNoteBloc>()
                            .add(CreateNoteSaveButtonPressedEvent());
                      },
                      child: const Icon(
                        Icons.done,
                         color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller:
                              context.read<CreateNoteBloc>().titleController,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color:  Colors.white,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: 'Add Title to Your Note',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
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
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: 'Please add description for your ease in future!',
                            hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white54)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

            default:
              return const Scaffold();
          }
        },
      ),
    );
  }
}
