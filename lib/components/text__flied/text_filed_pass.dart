import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class TextFieldPass extends StatefulWidget {
  const TextFieldPass(
      {super.key,
      this.controller,
      this.onChanged,
      this.focusNode,
      this.keyboardType,
      this.hintText,
      this.onFieldSubmitted,
      this.textInputAction,
      this.validator,
      this.prefixIcon});

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? hintText;
  final Function(String)? onFieldSubmitted;
  final Icon? prefixIcon;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  @override
  State<TextFieldPass> createState() => _TextFieldPassState();
}

class _TextFieldPassState extends State<TextFieldPass> {
  bool showpass = false;
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder(Color color) => OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 1.2),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        );

    return Stack(
      children: [
        Container(
          height: 48.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: AppColor.shadow,
                offset: Offset(0.0, 3.0),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: !showpass,
          keyboardType: widget.keyboardType,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.6),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: outlineInputBorder(AppColor.red),
            focusedBorder: outlineInputBorder(AppColor.blue),
            enabledBorder: outlineInputBorder(AppColor.grey),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: AppColor.grey),
            labelText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            // obscureText: !showpass,
            suffixIcon: GestureDetector(
              onTap: () => setState(() {
                showpass = !showpass;
              }),
              child: showpass
                  ? const Icon(Icons.remove_red_eye_rounded)
                  : const Icon(Icons.remove_red_eye_outlined),
            ),
            errorStyle: const TextStyle(color: AppColor.red),
          ),
        ),
      ],
    );
  }
}
