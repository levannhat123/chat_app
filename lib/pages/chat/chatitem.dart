import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  const ChatItem(
      {super.key,
      required this.message,
      required this.isComming,
      required this.time,
      this.imgUrl,
      required this.status});
  final String message;
  final bool isComming;
  final String time;
  final String? imgUrl;
  final String status;

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: widget.isComming
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width / 1.4),
            decoration: const BoxDecoration(
                color: AppColor.bgColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: widget.imgUrl == ''
                ? Text(widget.message)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(widget.imgUrl!),
                      Text(widget.message)
                    ],
                  ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: widget.isComming
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              widget.isComming
                  ? Text(
                      widget.time,
                      style: const TextStyle(color: AppColor.grey),
                    )
                  : Row(
                      children: [
                        Text(
                          widget.time,
                          style: const TextStyle(color: AppColor.grey),
                        ),
                        const Icon(
                          Icons.check,
                          color: AppColor.grey,
                        )
                      ],
                    )
            ],
          )
        ],
      ),
    );
  }
}
