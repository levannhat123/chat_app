import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment:
            isComming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width / 1.4),
            decoration: BoxDecoration(
                color: AppColor.bgColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: imgUrl == ''
                ? Text(message)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Image.asset(imgUrl!), Text(message)],
                  ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment:
                isComming ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              isComming
                  ? Text(
                      time,
                      style: TextStyle(color: AppColor.grey),
                    )
                  : Row(
                      children: [
                        Text(
                          time,
                          style: TextStyle(color: AppColor.grey),
                        ),
                        Icon(
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
