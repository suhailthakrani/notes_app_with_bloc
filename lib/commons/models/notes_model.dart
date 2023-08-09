import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Notes {
  List<Note> notes = [];
}

class Note {
  final String id;
  final String title;
  final String body;

  Note({
    required this.id,
    required this.title,
    required this.body,
  });

  Note copyWith({
    String? id,
    String? title,
    String? body,
    Timestamp? createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);
}
