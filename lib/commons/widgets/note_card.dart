// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/notes_model.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  const NoteCard({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration:  BoxDecoration(
        color: Color(0xFF252329),
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title, 
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w600, 
              fontSize: 18,
              height: 1.5
            ),
          ),
           Text(
            note.body,
           overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
            fontWeight: FontWeight.w400, 
            fontSize: 12,
            color: Colors.white54,
      
          ),
          )
        ],
      ),
    );
  }
}
