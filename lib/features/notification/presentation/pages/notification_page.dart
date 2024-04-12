import 'package:flutter/material.dart';
import 'package:volunteer_connection/common/custom_item_notification.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late double height;
  late double width;
  final String avatar =
      "https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/60882175_1292921530883531_6196144495243821056_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=5f2048&_nc_ohc=L-LpPGq31vwAX_tWcRC&_nc_ht=scontent.fdad3-5.fna&oh=00_AfC8A_DUJRVAcysUQOG4rvp4roIO_RIoHlM1H-XKBhWErw&oe=6633D3F1";
  final String title = "Khánh hồ muốn quan tâm đến bài viết của bạn.";
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông báo",
          style: AppStyles.h1,
        ),
      ),
      body: Column(
        children: [
          CustomItemNotification(
            height: 72,
            width: width,
            avatar: avatar,
            time: "3 ngày trước",
            action: () => {},
            title: title,
            pid: "",
            isCheck: true,
          ),
          CustomItemNotification(
            height: 72,
            width: width,
            avatar: avatar,
            time: "3 ngày trước",
            action: () => {},
            title: title,
            pid: "",
            isCheck: false,
          )
        ],
      ),
    );
  }
}
