import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? errorText;
  final Function(String)? onChange;
  final Icon? prefixIcon;

  const CustomTextField({
    Key? key,
    this.controller,
    this.errorText,
    this.hintText,
    this.keyboardType,
    this.onChange,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        controller: controller,
        decoration: InputDecoration(
          disabledBorder: InputBorder.none,
          filled: true,
          fillColor: Colors.grey.shade300,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 18.0,
          ),
          errorText: errorText,
        ),
        onChanged: onChange,
      ),
    );
  }
}
