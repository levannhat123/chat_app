import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class ChatSearchBox extends StatelessWidget {
  const ChatSearchBox({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            offset: Offset(0.0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: AppColor.black),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: AppColor.grey),
          prefixIcon: Icon(Icons.search),
          prefixIconConstraints: BoxConstraints(minWidth: 36.0),
        ),
      ),
    );
  }
}
