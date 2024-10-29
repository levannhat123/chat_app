import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class ChatTitle extends StatelessWidget {
  const ChatTitle({
    super.key,
    required this.imgUrl,
    required this.lastChat,
    required this.name,
    required this.lastTime,
  });

  final String imgUrl;
  final String lastChat;
  final String name;
  final String lastTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
              Container(
                width: 70,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: imgUrl.startsWith('http')
                      ? Image.network(
                          imgUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(Assets.img.avatar.path),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          color: AppColor.black, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      lastChat,
                      style: const TextStyle(color: AppColor.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            ],
          ),
          Text(lastTime),
        ],
      ),
    );
  }
}
