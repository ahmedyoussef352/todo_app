// ignore_for_file: use_build_context_synchronously, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print, unused_import

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:course44444/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/crud.dart';
import '../../components/custom_text_form.dart';
import '../../components/valid.dart';
import '../../constatnt/linkapi.dart';
import '../../main.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  File? myfile;
  late NoteModel noteModel;
  bool isloading = false;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  // TextEditingController id = TextEditingController();
  // final _crud = Crud();
  // addnotes() async {
  //   if (myfile == null) {
  //     return AwesomeDialog(
  //         context: context,
  //         title: "هام",
  //         body: const Text("الرجاء اضافة الصورة الخاصة بالملاحظة"))
  //       ..show();
  //   }
    
  //   if (formstate.currentState!.validate()) {
  //     isloading = true;
  //     setState(() {});

  //     var response = await postRequestWithFile(linkAddNotes, {
  //           "title": title.text,
  //           "content": content.text,
  //           "id": sharedPref.getString("id")
  //         }, myfile!);
  //     isloading = false;
  //     setState(() {});
  //     if (response["status"] == "success") {
  //       Navigator.of(context).pushReplacementNamed("home");
  //     } else {
  //       print('signUp fail');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add note"),
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
                  await cubit.addNotes(context,content: content,title: title,id: sharedPref.get("id").toString(),formstate: formstate,myfile: myfile);
                },
                child: const Text("add note"),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  });
}
}