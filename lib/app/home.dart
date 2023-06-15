// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/crad_note.dart';
import '../components/crud.dart';
import '../constatnt/linkapi.dart';
import '../main.dart';
import '../model/note_model.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'notes/edit_note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  // late final  notes;
  // getNotes() async {
  //   var response =
  //       await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
  //   return response;
  // }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.of(context).pushReplacementNamed("AddNotes");
          //getid();

        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future: cubit.getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'failed') {
                      return const Center(
                        child: Text('لا يوجد ملاحظات'),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return CardNote(
                            ondelet: () async {
                              var response = await postRequest(
                                  linkDeleteNotes, {
                                "id": snapshot.data['data'][i]['notes_id']
                                    .toString(),
                                    "imagename": snapshot.data['data'][i]['notes_image']
                                    .toString()
                              });
                              if (response["status"] == "success") {
                                Navigator.of(context)
                                    .pushReplacementNamed("home");
                              }
                            },
                            noteModel:
                                NoteModel.fromJson(snapshot.data['data'][i]),
                            ontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditNotes(
                                      notes: snapshot.data['data'][i])));
                            },
                          );
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text("Loading ..."),
                    );
                  }
                  return const Center(
                    child: Text("Loading ..."),
                  );
                })
            // ignore: prefer_const_constructors
          ],
        ),
      ),
    );
  });
}
}