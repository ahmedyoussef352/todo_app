import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Center(
            child: Text('تم انشاء الحساب بنجاح الان يمكنك تسجيل الدخول',style: TextStyle(
              fontSize: 20,
            ),),
          ),
          MaterialButton(onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
          },
          textColor: Colors.white,
          color: Colors.blue,
          child: const Text("تسجيل الدخول"),)
        ],
      )
    );
  }
}