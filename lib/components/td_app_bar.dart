import 'dart:math' as math;
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class TdAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TdAppBar({
    super.key,
    this.leftPressed,
    this.rightPressed,
    required this.title,
    this.avatar,
    this.color = AppColor.bgColor,
    required this.tabController,
  });

  final VoidCallback? leftPressed;
  final VoidCallback? rightPressed;
  final String title;
  final String? avatar;
  final Color color;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.bgColor,
      centerTitle: true,
      leading: GestureDetector(
        onTap: leftPressed,
        child: Transform.rotate(
          angle: 45 * math.pi / 180,
          child: Container(
            margin: const EdgeInsets.all(8.6),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: AppColor.shadow,
                  offset: Offset(3.0, 3.0),
                  blurRadius: 4.6,
                  // hello
                ),
              ],
            ),
            child: Transform.rotate(
                angle: -45 * math.pi / 180,
                child:
                    const Icon(Icons.menu, size: 22.0, color: AppColor.brown)),
          ),
        ),
      ),
      title: Text(title),
      actions: [
        GestureDetector(
          onTap: rightPressed,
          child: const Icon(Icons.edit),
        ),
      ],
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(60),
      //   // child: TabBar(
      //   //     controller: tabController,
      //   //     labelStyle: Theme.of(context).textTheme.bodyLarge,
      //   //     unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      //   //     indicatorColor: AppColor.grey,
      //   //     indicatorWeight: 4,
      //   //     tabs: const [
      //   //       Text('Chats'),
      //   //       // Text('Groups'),
      //   //       // Text('Calls'),
      //   //     ]),
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(86.0);
}
