import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool obscureText;
  final double height;
  final int? maxLines;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.hint,
    this.textInputAction,
    this.validator,
    this.obscureText = false,
    this.height = 51,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: TextFormField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                  ),
                  validator: validator,
                  textInputAction: textInputAction,
                  obscureText: obscureText,
                  maxLines: maxLines ?? 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
