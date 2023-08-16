import 'package:flutter/material.dart';
import 'package:notes_app/notes/models/note.dart';
import '../services/note.dart';
class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];


  set note(List<Note> value) {
    _notes = value;
    notifyListeners();
  }

  List<Note> get items {
    return [..._notes];
  }

  Future<void> fetch() async{
    _notes = await noteService().fetchNotes();
    notifyListeners();
  }

  Future<void> addNote({required Note note}) async{
    _notes.add(note);
    notifyListeners();
    await noteService().addNote(note: note);
  }

  Future<void> deleteNote({required Note note}) async{
    _notes.removeWhere((element) => note.id == element.id);
    notifyListeners();
    await noteService().deleteNote(note: note);
  }
  
  Future<void> updateNote({required Note note}) async{
    final loadedNote = _notes.firstWhere((element) => element.id == note.id);
    loadedNote.id = note.id;
    loadedNote.note = note.note;
    loadedNote.title = note.title;
    notifyListeners();
    noteService().updateNote(note: note);
  }




}