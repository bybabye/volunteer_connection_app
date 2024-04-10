/// Author : Bùi lê Huy
/// Date : 26/03/2024
/// Description : Viết widget cho phần thông báo
/// Update :
///

import 'package:flutter/material.dart';
import 'package:volunteer_connection/common/custom_circle_avatar.dart';
import 'package:volunteer_connection/themes/app_colors.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class CustomItemNotification extends StatelessWidget {
  const CustomItemNotification({
    super.key,
    required this.height,
    required this.width,
    required this.avatar,
    required this.time,
    required this.action,
    required this.title,
    required this.pid,
    required this.isCheck,
  });
  final double height;
  final double width;
  final String avatar;
  final String title;
  final String pid;
  final String time;
  final Function action;
  final bool isCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isCheck ? Colors.white : Appcolors.checkNotificationColor,
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            CustomCircleAvatar(
              size: 25,
              avatar: avatar,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.h4,
                    ),
                    Text(
                      time,
                      style: AppStyles.h5.copyWith(
                          color: isCheck ? Colors.grey : Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const Icon(Icons.more_horiz_outlined)
          ],
        ),
      ),
    );
  }
}
