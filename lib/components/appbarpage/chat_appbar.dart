import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class ChatAppbarPage extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppbarPage({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.img,
    this.rightPressed,
  });
  final VoidCallback? rightPressed;
  final Widget icon;
  final String title;
  final String? subtitle;
  final String? img;

  @override
  Size get preferredSize => const Size.fromHeight(86.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
          top: MediaQuery.of(context).padding.top + 6.0, bottom: 12.0),
      decoration: const BoxDecoration(
        color: AppColor.bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: icon,
              ),
              const SizedBox(width: 16.0),
              if (img != null &&
                  img!.isNotEmpty) // Kiểm tra nếu img không null và không rỗng
                Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: img != null && img!.isNotEmpty
                        ? Image.network(
                            img!,
                            width: 70,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(Assets.img.avatar.path),
                  ),
                ),
              const SizedBox(width: 18.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  if (subtitle != null &&
                      subtitle!.isNotEmpty) // Kiểm tra subtitle
                    Text(subtitle!,
                        style: const TextStyle(
                            fontSize: 14.0, color: Colors.grey)),
                ],
              ),
              // SizedBox(
              //   width: 150,
              // ),
            ],
          ),
          GestureDetector(
            onTap: rightPressed,
            child: const Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }
}
