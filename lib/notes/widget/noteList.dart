import 'package:flutter/material.dart';
import 'package:notes_app/notes/models/note.dart';
import '../screens/notes_add.dart';

class NoteItem extends StatefulWidget {

  final Note note;
  const NoteItem({required this.note});

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  void detailsPage(){
    Navigator.pushNamed(context, notesAddScreen.routeName, arguments: widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: detailsPage,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration:  BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              spreadRadius: 2,
            )
          ]
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(widget.note.id.toString()),
          ),
          title: Text(
            widget.note.title,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: (){},
            icon: const Icon(Icons.arrow_right_outlined),
            iconSize: 26,
          ),
        ),
      ),
    );
  }
}
