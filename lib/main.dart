import 'package:flutter/material.dart';
import 'package:notes_app/notes/models/note.dart';
import 'package:notes_app/notes/provider/note_provider.dart';
import 'package:notes_app/notes/screens/notes_add.dart';
import 'package:provider/provider.dart';


import 'notes/screens/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteProvider(),
      child: MaterialApp(
        title: 'Notes App',
        theme: ThemeData(

          primarySwatch: Colors.blue,

        ),
        routes: {
          // ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          NotesApp.routeName : (ctx) => const NotesApp(),
          notesAddScreen.routeName : (Ctx) =>  notesAddScreen(note: null, edit: false),
        },

        debugShowCheckedModeBanner: false,
        home: const NotesApp(),
      ),
    );
  }
}