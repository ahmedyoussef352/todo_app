// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace

import 'package:course44444/components/crud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/custom_text_form.dart';
import '../../components/valid.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with Crud{
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;
  // login() async {
  //   if (formState.currentState!.validate()) {
  //     isloading = true;
  //     setState(() {});
  //     var response = await postRequest(linkLogin, {
  //       "email": email.text,
  //       "password": password.text,
  //     }
  //     );
  //     isloading = false;
  //     setState(() {});
  //     // ignore: duplicate_ignore
  //     if (response["status"]=="success") {
  //       sharedPref.setString("id", response['data']['id'].toString());
  //       sharedPref.setString("username", response['data']['username']);
  //       sharedPref.setString("email", response['data']['email']);
  //       sharedPref.setString("password", response['data']['password']);
  //       Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
  //     } else {
  //       // ignore: avoid_single_cascade_in_expression_statements
  //       AwesomeDialog(
  //           context: context,
  //           title: "تنبيه",
  //           body: const Text(
  //               "البريد الالكتروني او كلمة المرور خطأ او الحساب غير موجود"))
  //         ..show();
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
      body: Container(
        padding: const EdgeInsets.all(10),
        child: 
        isloading == false
            ? 
            ListView(children: [
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: formState,
                  child: Container(
                    // ignore: prefer_const_constructors
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          text: 'email',
                          mycontroller: email,
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                        ),
                        CustomTextFormSign(
                          mycontroller: password,
                          text: 'password',
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                        ),
                        MaterialButton(
                          onPressed: () async {
                            await cubit.login(context,email: email,password:password,formState: formState);
                          },
                          color: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
                          child: const Text('Login'),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("signup");
                          },
                          child: Container(
                            height: 30,
                            child: const Text("Sign Up"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ])
            : const Center(
               child: CircularProgressIndicator(color:Colors.red),
             ),
      ),
    );
  });
}}
