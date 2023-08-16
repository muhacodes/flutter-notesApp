import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/constant.dart';
import 'package:notes_app/notes/models/note.dart';
import 'package:notes_app/notes/screens/note.dart';
import 'dart:convert';

import '../exception.dart';

class noteService {
  Future<void> addNote({required Note note}) async {
    const url = "$AppUrl/notes/";
    final res = await http.post(Uri.parse(url), body: {
      'title': note.title,
      'text': note.note,
    });
  }

  Future<List<Note>> fetchNotes() async {
    const url = "$AppUrl/notes/";
    final List<Note> _notes = [];

    final response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body);

    for (var note in data) {
      _notes.add(
        Note(
            id: note['id'].toString(),
            title: note['title'],
            note: note['text']),
        );
    }

    return _notes;
  }

  Future<void> updateNote({required Note note}) async {
    var url = "$AppUrl/notes/${note.id}/";
    final res = await http
        .put(Uri.parse(url), body: {'title': note.title, 'text': note.note});
  }

  Future<void> deleteNote({required Note note}) async {
    var url = "$AppUrl/notes/${note.id}/";

    final res = await http.delete(
      Uri.parse(url),
    );
  }
}
