import 'package:flutter/material.dart';
import 'package:volunteer_connection/common/custom_circle_avatar.dart';
import 'package:volunteer_connection/themes/app_colors.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final String avatar =
      "https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/60882175_1292921530883531_6196144495243821056_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=5f2048&_nc_ohc=L-LpPGq31vwAX_tWcRC&_nc_ht=scontent.fdad3-5.fna&oh=00_AfC8A_DUJRVAcysUQOG4rvp4roIO_RIoHlM1H-XKBhWErw&oe=6633D3F1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Menu",
          style: AppStyles.h1,
        ),
      ),
      body: Column(
        children: [
          _customItemMenuWithAvatar(),
          _customItemMenuWithIcon(Icons.post_add, () => {}, "Bài viết"),
          _customItemMenuWithIcon(Icons.account_circle_outlined, () => {},
              "Chỉnh sửa thông tin cá nhân"),
          const Spacer(),
          _customButtonLogout(),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget _customItemMenuWithAvatar() {
    return Container(
      height: 72,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000), // Màu đen với độ trong suốt 25%
            offset: Offset(4, 4), // Độ lệch theo trục x và y
            blurRadius: 20, // Độ mờ
          ),
        ],
      ),
      child: Row(
        children: [
          CustomCircleAvatar(size: 30, avatar: avatar),
          const SizedBox(
            width: 5,
          ),
          const Text(
            "Huy Bùi",
            style: AppStyles.h3,
          )
        ],
      ),
    );
  }

  Widget _customItemMenuWithIcon(IconData icon, Function() func, String title) {
    return Container(
      height: 52,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000), // Màu đen với độ trong suốt 25%
            offset: Offset(2, 2), // Độ lệch theo trục x và y
            blurRadius: 10, // Độ mờ
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Icon(
            icon,
            color: Appcolors.backgruondFirstColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: AppStyles.h3,
          )
        ],
      ),
    );
  }

  Widget _customButtonLogout() {
    return Container(
      height: 46,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFE5E5E5),
      ),
      child: const Center(
        child: Text(
          "Đăng xuất",
          style: AppStyles.h3,
        ),
      ),
    );
  }
}
