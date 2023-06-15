// ignore_for_file: avoid_print

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:course44444/app/auth/success.dart';
import 'package:course44444/app/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/crud.dart';
import '../../constatnt/linkapi.dart';
import '../../main.dart';

class AppCubit extends Cubit<AppStates> with Crud {
  AppCubit() : super(AppInitialState());

  static AppCubit get(
    context,
  ) =>
      BlocProvider.of(context);
  bool isloading = false;
  addNotes(context,
      {required TextEditingController title,
      required TextEditingController content,
      required String id,
      required GlobalKey<FormState> formstate,
      File? myfile}) async {
    if (myfile == null) {
      emit(AddFileError("Please add an image for the note"));
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: const Text("الرجاء اضافة الصورة الخاصة بالملاحظة"))
        ..show();
    }
    if (formstate.currentState!.validate()) {
      isloading = true;
      emit(LoadingTrue());

      var response = await postRequestWithFile(
          linkAddNotes,
          {
            "title": title.text,
            "content": content.text,
            "id": sharedPref.getString("id"),
          },
          myfile);
      isloading = false;
      emit(LoadingFalse());
      if (response["status"] == "success") {
        emit(AddNotesSuccess());
        return Navigator.of(context).pushReplacementNamed("home");
      } else {
        emit(AddNotesError("Failed to add note"));
      }
    }
  }

  getNotes() async {
    var response =
        await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
    return response;
  }

  login(
    context, {
    required TextEditingController email,
    required TextEditingController password,
    required GlobalKey<FormState> formState,
  }) async {
    if (formState.currentState!.validate()) {
      isloading = true;
      emit(LoadingTrue());
      var response = await postRequest(linkLogin, {
        "email": email.text,
        "password": password.text,
      });
      isloading = false;
      emit(LoadingFalse());
      // ignore: duplicate_ignore
      if (response["status"] == "success") {
        emit(SuccessLogin());
        sharedPref.setString("id", response['data']['id'].toString());
        sharedPref.setString("username", response['data']['username']);
        sharedPref.setString("email", response['data']['email']);
        sharedPref.setString("password", response['data']['password']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        // ignore: avoid_single_cascade_in_expression_statements
        AwesomeDialog(
            context: context,
            title: "تنبيه",
            body: const Text(
                "البريد الالكتروني او كلمة المرور خطأ او الحساب غير موجود"))
          ..show();
      }
    }
  }

  Future? signUp(
    context, {
    required TextEditingController email,
    required TextEditingController username,
    required TextEditingController password,
    required GlobalKey<FormState> formstate,
  }) async {
    if (formstate.currentState!.validate()) {
      isloading = true;
      emit(LoadingTrue());

      var response = await postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });
      isloading = false;
      emit(LoadingFalse());
      if (response["status"] == "success") {
        emit(SuccessSignUp());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Success()),
          result: (rout) {
            return false;
          },
        );
      } else {
        print('signUp fail');
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => Success()),
        //   result: (rout) {
        //     return false;
        //   },
        // );
      }
    }
  }
// addnotes(context,
//  TextEditingController title,
// TextEditingController content

// ) async {
//     if (myfile == null) {
//       return AwesomeDialog(
//           context: context,
//           title: "هام",
//           body: const Text("الرجاء اضافة الصورة الخاصة بالملاحظة"))
//         ..show();
//     }

//     if (formstate.currentState!.validate()) {
//       isloading = true;
//       setState(() {});

//       var response = await postRequestWithFile(linkAddNotes, {
//             "title": title.text,
//             "content": content.text,
//             "id": sharedPref.getString("id")
//           }, myfile!);
//       isloading = false;
//       setState(() {});
//       if (response["status"] == "success") {
//         Navigator.of(context).pushReplacementNamed("home");
//       } else {
//         print('signUp fail');
//       }
//     }
//   }
}
