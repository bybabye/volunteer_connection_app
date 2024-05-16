import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_connection/features/auth/presentation/providers/auth_provider.dart';
import 'package:volunteer_connection/features/chat/presetation/widgets/custom_chat_type.dart';
import 'package:volunteer_connection/features/chat/presetation/widgets/custom_text_field_search.dart';
import 'package:volunteer_connection/themes/app_assets.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late AuthProvider _auth;
  final TextEditingController _searchValue = TextEditingController();

  @override
  void initState() {
    super.initState();
    _auth = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            image: _auth.user.avatar != ""
                ? DecorationImage(
                    image: NetworkImage(_auth
                        .user.avatar), // Thay đổi đường dẫn tới ảnh của bạn
                    fit: BoxFit.cover,
                  )
                : const DecorationImage(
                    image: AssetImage(
                        AppAssets.user), // Thay đổi đường dẫn tới ảnh của bạn
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        title: const Text(
          "Message",
          style: AppStyles.h2,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: CustomTextFieldSearch(controller: _searchValue),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomChatType(),
        ],
      ),
    );
  }
}
