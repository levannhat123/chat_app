import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class ChatTitle extends StatelessWidget {
  const ChatTitle(
      {super.key,
      required this.imgUrl,
      required this.lastChat,
      required this.name,
      required this.lastTime});
  final String imgUrl;
  final String lastChat;
  final String name;
  final String lastTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      // color: AppColor.bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 12.0).copyWith(
          top: MediaQuery.of(context).padding.top + 12.0, bottom: 12.0),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(imgUrl),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: AppColor.black, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    lastChat,
                    style: TextStyle(color: AppColor.grey),
                  )
                ],
              ),
            ],
          ),
          Text(lastTime)
        ],
      ),
    );
  }
}
