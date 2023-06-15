// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously, avoid_print, sort_child_properties_last, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/crud.dart';
import '../../components/custom_text_form.dart';
import '../../components/valid.dart';
import '../../constatnt/linkapi.dart';

class EditNotes extends StatefulWidget {
  final dynamic notes;
  const EditNotes({this.notes, super.key});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> with Crud {
  bool isloading = false;
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  // TextEditingController id = TextEditingController();
  editnotes() async {
    if (formstate.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response;
      if (myfile == null) {
        response = await postRequest(linkEditNotes, {
          "title": title.text,
          "content": content.text,
          "id": widget.notes['notes_id'].toString(),
          "imagename": widget.notes['notes_image'].toString(),
        });
      } else {
        response = await postRequestWithFile(
            linkEditNotes,
            {
              "title": title.text,
              "content": content.text,
              "id": widget.notes['notes_id'].toString(),
              "imagename": widget.notes['notes_image'].toString(),
            },
            myfile!);
      }

      isloading = false;
      setState(() {});
      if (response["status"] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        print('signUp fail');
      }
    }
  }

  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'].toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit note"),
      ),
      body: Container(
        child: Form(
          key: formstate,
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              CustomTextFormSign(
                  mycontroller: title,
                  text: "title",
                  valid: (val) {
                    return validInput(val, 1, 40);
                  }),
              // CustomTextFormSign(mycontroller: id, text: "id", valid: (val) {}),
              CustomTextFormSign(
                  mycontroller: content,
                  text: "content",
                  valid: (val) {
                    return validInput(val, 10, 255);
                    // return validInput();
                  }),
              Container(
                height: 20,
              ),
              MaterialButton(
                onPressed: () async {
                  showModalBottomSheet(
                      context: context,
                      builder: (contxet) => Container(
                            height: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Please Choose Image",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    XFile? xfile = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    Navigator.of(context).pop();
                                    myfile = File(xfile!.path);
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      "From Gallery",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    XFile? xfile = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    Navigator.of(context).pop();
                                    myfile = File(xfile!.path);
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      "From Camera",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ));
                },
                child: const Text("Choose image"),
                textColor: Colors.white,
                color: myfile == null ? Colors.blue : Colors.green,
              ),
              MaterialButton(
                onPressed: () async {
                  await editnotes();
                },
                child: const Text("Save"),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
