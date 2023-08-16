
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:notes_app/notes/services/note.dart';

class Note{
  String? id;
  String title;
  String note;

  Note({this.id, required this.title, required this.note});
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      note: json['note'],
      title: json['title'],
    );
  }
}