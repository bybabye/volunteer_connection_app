import 'package:flutter/material.dart';
import 'package:volunteer_connection/common/custom_circle_avatar.dart';
import 'package:volunteer_connection/common/custom_post.dart';
import 'package:volunteer_connection/themes/app_assets.dart';
import 'package:volunteer_connection/themes/app_colors.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class NewFeeds extends StatefulWidget {
  const NewFeeds({super.key});

  @override
  State<NewFeeds> createState() => _NewFeedsState();
}

class _NewFeedsState extends State<NewFeeds> {
  final String avatar =
      "https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/60882175_1292921530883531_6196144495243821056_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=5f2048&_nc_ohc=F2q6gDZMNPwQ7kNvgEvp4Oo&_nc_ht=scontent.fdad3-5.fna&oh=00_AfBsiwlb-Hxzmnp1jUDUjMhghj-TXJLIYjiTtnoIY9GVUw&oe=6662A131";

  final text =
      "Công tác tình nguyện viên được thực hiện bởi các cộng tác viên...";
  late double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Huy Bùi",
            style: AppStyles.h3,
          ),
          actions: [
            SizedBox(
              height: 40,
              width: 40,
              child: Image.asset(
                AppAssets.logo,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CustomCircleAvatar(size: 20, avatar: avatar),
          ),
          centerTitle: true,
        ),
        backgroundColor: Appcolors.backgruondSecondColor,
        body: ListView(
          children: [
            CustomPost(
              avatar: avatar,
              userName: "Huy Bùi",
              time: "49 phút",
              text: text,
              address: "32 Pasteur, Phường Hải Châu, Quận Hải Châu, Đà Nẵng",
              organization: "Tổ Chức Từ Thiện Đà Nẵng",
              images: const [
                "https://danviet.mediacdn.vn/2020/8/10/img8361-15970534817591653547950.jpg"
              ],
              width: width,
            ),
            CustomPost(
              avatar: avatar,
              userName: "Huy Bùi",
              time: "49 phút",
              text: text,
              address: "32 Pasteur, Phường Hải Châu, Quận Hải Châu, Đà Nẵng",
              organization: "Tổ Chức Từ Thiện Đà Nẵng",
              images: const [
                "https://danviet.mediacdn.vn/2020/8/10/img8361-15970534817591653547950.jpg"
              ],
              width: width,
            ),
          ],
        ));
  }
}
