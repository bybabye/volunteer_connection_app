import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_connection/core/entites/user.dart';
import 'package:volunteer_connection/core/routers/navigation_service.dart';
import 'package:volunteer_connection/features/auth/presentation/providers/auth_provider.dart';
import 'package:volunteer_connection/features/chat/domain/entity/chat.dart';
import 'package:volunteer_connection/features/chat/presetation/page/message_page.dart';
import 'package:volunteer_connection/features/chat/presetation/providers/chat_provider.dart';
import 'package:volunteer_connection/features/chat/presetation/widgets/custom_chat.dart';
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
  late ChatProvider _chat;
  final TextEditingController _searchValue = TextEditingController();
  final NavigationService navigationService =
      GetIt.instance.get<NavigationService>();

  @override
  void initState() {
    super.initState();
    _auth = Provider.of<AuthProvider>(context, listen: false);

    _chat = Provider.of<ChatProvider>(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthProvider>(context);
    _chat = Provider.of<ChatProvider>(context);

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
          // CustomChatType(),
          FutureBuilder<List<Chat>>(
            future: _chat.getChatForId(
                id: _auth.user.id), // yourId là id mà bạn muốn truyền vào
            builder:
                (BuildContext context, AsyncSnapshot<List<Chat>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Hiển thị loading khi Future đang trong quá trình thực thi
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Hiển thị lỗi nếu có lỗi xảy ra trong quá trình thực thi Future
                return Center(
                    child: Text('Error: ${snapshot.error.toString()}'));
              } else {
                // Hiển thị dữ liệu khi Future thực thi thành công
                final List<Chat> chats = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (_, index) {
                      User? user = findOtherMemberId(
                          _auth.user.id, chats[index].members);
                      return chats[index].type == 'private'
                          ? InkWell(
                              onTap: () {
                                navigationService.navigateToPage(
                                  MessagePage(
                                    avatar: user.avatar,
                                    name: user.name,
                                    chatId: chats[index].id,
                                  ),
                                );
                              },
                              child: CustomChat(
                                nameGruop: user!.name,
                                lassMess: "",
                                avatar: user.avatar,
                              ),
                            )
                          : CustomChat(
                              nameGruop: "Nhóm thiện nguyện",
                              lassMess: "",
                              avatar: "",
                            );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  User? findOtherMemberId(String id, List<User> members) {
    for (User member in members) {
      if (member.id != id) {
        return member;
      }
    }
    return null;
  }
}
