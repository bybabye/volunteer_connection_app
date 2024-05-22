import 'package:flutter/material.dart';
import 'package:volunteer_connection/themes/app_assets.dart';

class CustomChat extends StatelessWidget {
  const CustomChat(
      {super.key,
      required this.nameGruop,
      required this.lassMess,
      required this.avatar});

  final String nameGruop;
  final String lassMess;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                image: avatar != ""
                    ? DecorationImage(
                        image: NetworkImage(
                            avatar), // Thay đổi đường dẫn tới ảnh của bạn
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: AssetImage(AppAssets
                            .user), // Thay đổi đường dẫn tới ảnh của bạn
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(nameGruop), const Text("Tin nhan : aaaa")],
            )
          ],
        ));
  }
}
