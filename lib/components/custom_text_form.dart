import 'package:flutter/material.dart';

class CustomTextFormSign extends StatelessWidget {
  final String text;
  final TextEditingController mycontroller;
  final String? Function(String?)? valid;

   const CustomTextFormSign({
    Key? key,
    required this.mycontroller,
    required this.text,
    required this.valid
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
            hintText: text,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
