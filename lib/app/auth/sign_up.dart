// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/crud.dart';
import '../../components/custom_text_form.dart';
import '../../components/valid.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with Crud {
  bool isloading = false;
  // Future? signUp() async {
  //   if (formstate.currentState!.validate()) {
  //     isloading = true;
  //     setState(() {});

  //     var response = await postRequest(linkSignUp, {
  //       "username": username.text,
  //       "email": email.text,
  //       "password": password.text,
  //     });
  //     isloading = false;
  //     setState(() {});
  //     if (response["status"] == "success") {
  //       // Navigator.of(context)
  //       //  .pushNamedAndRemoveUntil("success", (route) => false);
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => Success()),
  //         result: (rout) {
  //           return false;
  //         },
  //       );
  //     } else {
  //       print('signUp fail');
  //       // Navigator.pushReplacement(
  //       //   context,
  //       //   MaterialPageRoute(builder: (context) => Success()),
  //       //   result: (rout) {
  //       //     return false;
  //       //   },
  //       // );
  //     }
  //   }
  // }

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
    return Scaffold(
      body: Container(
        child: isloading == false
            ? ListView(children: [
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: formstate,
                  child: isloading == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/logo.png",
                                width: 200,
                                height: 200,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextFormSign(
                                text: 'username',
                                mycontroller: username,
                                valid: (val) {
                                  return validInput(val!, 3, 20);
                                },
                              ),
                              CustomTextFormSign(
                                text: 'email',
                                mycontroller: email,
                                valid: (val) {
                                  return validInput(val!, 5, 40);
                                },
                              ),
                              CustomTextFormSign(
                                mycontroller: password,
                                text: 'password',
                                valid: (val) {
                                  return validInput(val!, 7, 16);
                                },
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  await cubit.signUp(context,email: email,username: username,password: password,formstate: formstate);
                                },
                                color: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 70, vertical: 10),
                                child: const Text('SignUp'),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed("login");
                                  },
                                  child: Container(
                                    height: 30,
                                    child: const Text("Login"),
                                  )),
                            ],
                          ),
                        ),
                ),
              ])
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  });
}
}