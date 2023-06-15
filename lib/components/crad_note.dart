import 'package:flutter/material.dart';

import '../constatnt/linkapi.dart';
import '../model/note_model.dart';

class CardNote extends StatelessWidget {
  final void Function()? ontap;
  final NoteModel noteModel;
  final void Function()? ondelet;
  const CardNote(
      {Key? key,
      required this.ontap,
      required this.noteModel,
      this.ondelet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "$linkImageRoot/${noteModel.notesImage}",
                width: 100,
                height: 100,
              ),
            ),
            Expanded(
              flex: 2,
              // ignore: prefer_const_constructors
              child: ListTile(
                title: ListTile(
                  title: Text("${noteModel.notesTitle}"),
                  subtitle: Text("${noteModel.notesContent}"),
                  trailing: IconButton(
                      onPressed: ondelet, icon: const Icon(Icons.delete)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
