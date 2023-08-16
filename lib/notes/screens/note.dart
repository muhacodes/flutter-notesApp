import 'package:flutter/material.dart';
import 'package:notes_app/notes/models/note.dart';
import 'package:notes_app/notes/provider/note_provider.dart';
import 'package:notes_app/notes/services/note.dart';
import 'package:notes_app/notes/widget/noteList.dart';
import 'package:provider/provider.dart';
import '../screens/notes_add.dart';

import 'package:provider/provider.dart';

class NotesApp extends StatefulWidget {
  static const routeName = '/notes';
  const NotesApp({Key? key}) : super(key: key);

  @override

  _NotesAppState createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {

   var isLoading = true;
   final service = noteService();


  @override
  void initState() {
    super.initState();
    getNotes();
  }

  getNotes() async{
    await context.read<NoteProvider>().fetch();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> refresh() async{
    await service.fetchNotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Notes App')),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: isLoading
            ? const Center(child: CircularProgressIndicator(),)
            :Consumer<NoteProvider>(
          builder: (ctx, note, _) {
            return ListView.builder(
              padding: 
                const EdgeInsets.all(10),
              itemCount: note.items.length,
              itemBuilder: (ctx, index) => NoteItem(note: note.items[index],)
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, notesAddScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}