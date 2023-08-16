import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:notes_app/notes/provider/note_provider.dart';
import 'package:notes_app/notes/screens/note.dart';

import '../models/note.dart';
import '../services/note.dart';
import 'package:provider/provider.dart';

class notesAddScreen extends StatefulWidget {
  static const routeName = 'notes-add';
  late Note? note;
  late bool? edit;

  notesAddScreen({this.note, this.edit});

  @override
  _notesAddScreenState createState() => _notesAddScreenState();
}

class _notesAddScreenState extends State<notesAddScreen> {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var loading = false;
  noteService _services = noteService();

  void add() async {
    if (_form.currentState!.validate()) {
      final _note = Note(
          id: widget.note?.id,
          title: titleController.text,
          note: noteController.text);
      setState(() {
        loading = true;
      });
      if (widget.note == null) {
        // add note
        await context.read<NoteProvider>().addNote(note: _note);
        Navigator.of(context).pushReplacementNamed(NotesApp.routeName);
      } else {
        await context.read<NoteProvider>().updateNote(note: _note);
        Navigator.of(context).pushReplacementNamed(NotesApp.routeName);
      }
    }
  }

  void delete() async {
    setState(() {
      loading = true;
    });
    final _note = Note(
        id: widget.note?.id,
        title: titleController.text,
        note: noteController.text);
    await context.read<NoteProvider>().deleteNote(note: _note);
    Navigator.of(context).pushReplacementNamed(NotesApp.routeName);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is Note) {
      widget.note = args;
      titleController.text = widget.note!.title;
      noteController.text = widget.note!.note;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.note);
    print(widget.note?.title);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? widget.note!.title : 'Add Note'),
        // backgroundColor: Colors.deepPurple,
      ),
      body: loading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Enter title of your note',
                        prefixIcon: const Icon(Icons.title),
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey[400]!,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'please enter a value';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: noteController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.note),
                        labelText: 'Note',
                        hintText: 'Enter your note here',
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey[400]!,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'please enter a value';
                        }
                      },
                      maxLines: 8,
                      // Set the number of lines to 8 to allow for longer notes
                      minLines:
                          4, // Set the minimum number of lines to 4 for a better user experience
                    ),
                    Expanded(child: Container()),
                    Container(
                      color: Colors.black,
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: add,
                        child: Text(
                          widget.note == null ? 'Add' : 'Save',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.note != null,
                      child: Container(
                        width: double.infinity,
                        color: Colors.red,
                        child: OutlinedButton(
                          onPressed: delete,
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
