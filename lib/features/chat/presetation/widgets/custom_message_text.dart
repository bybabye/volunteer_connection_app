import 'package:flutter/material.dart';
import 'package:volunteer_connection/themes/app_assets.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class CustomMessageText extends StatelessWidget {
  const CustomMessageText(
      {super.key,
      required this.isUser,
      required this.avatar,
      required this.time,
      required this.text,
      required this.type});
  final bool isUser;
  final String text;
  final String time;
  final String avatar;
  final String type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isUser)
              avatar != ""
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                      radius: 20,
                    )
                  : const CircleAvatar(
                      backgroundImage: AssetImage(AppAssets.user),
                      radius: 20,
                    ),
            Flexible(
              child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isUser ? Colors.black : Colors.grey),
                  child: Column(
                    crossAxisAlignment: isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      customText(type, text),
                      Text(time,
                          style: AppStyles.h4.copyWith(
                              color: isUser ? Colors.grey : Colors.black))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget customText(String type, String content) {
    if (type == 'image') {
      return SizedBox(
        height: 250,
        child: Image.network(
          content,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Text(
        content,
        style:
            AppStyles.h2.copyWith(color: isUser ? Colors.white : Colors.black),
      );
    }
  }
}
