import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_connection/core/entites/user.dart';
import 'package:volunteer_connection/features/auth/presentation/providers/auth_provider.dart';
import 'package:volunteer_connection/features/chat/domain/entity/message.dart';
import 'package:volunteer_connection/features/chat/presetation/providers/chat_provider.dart';
import 'package:volunteer_connection/features/chat/presetation/widgets/custom_message_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:volunteer_connection/themes/app_styles.dart';

class MessagePage extends StatefulWidget {
  const MessagePage(
      {super.key,
      required this.avatar,
      required this.name,
      required this.chatId});
  final String avatar;
  final String name;
  final String chatId;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late double height;
  late double width;
  final TextEditingController _controller = TextEditingController();
  late AuthProvider _auth;
  late ChatProvider _chat;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _auth = Provider.of<AuthProvider>(context, listen: false);

    _chat = Provider.of<ChatProvider>(context, listen: false);
  }

  Future<void> _loadMessages() async {}

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthProvider>(context);
    _chat = Provider.of<ChatProvider>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.avatar),
              backgroundColor: Colors.greenAccent[100],
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.name,
              style: AppStyles.h2,
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.8,
                width: width,
                child: FutureBuilder<List<Message>>(
                  future: _chat.getMessForId(
                      id: widget.chatId), // yourId là id mà bạn muốn truyền vào
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Message>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Hiển thị loading khi Future đang trong quá trình thực thi
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Hiển thị lỗi nếu có lỗi xảy ra trong quá trình thực thi Future
                      return Center(
                          child: Text('Error: ${snapshot.error.toString()}'));
                    } else {
                      // Hiển thị dữ liệu khi Future thực thi thành công
                      final List<Message> messages = snapshot.data!;
                      print(messages);
                      return ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (_, index) {
                            return CustomMessageText(
                              isUser:
                                  messages[index].sender.id == _auth.user.id,
                              avatar: messages[index].sender.avatar,
                              time: timeago.format(messages[index].sentTime,
                                  locale: 'vi'),
                              text: messages[index].content,
                              type: messages[index].type,
                            );
                          });
                    }
                  },
                ),
              ),
              Container(
                height: height * 0.1,
                width: width,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(18),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xFFF2F2F2),
                        ),
                        child: TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration.collapsed(
                              hintText: "Message"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(Icons.camera),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          Message mess = Message(
                              id: "",
                              type: "text",
                              sender: _auth.user,
                              content: _controller.text,
                              sentTime: DateTime.now(),
                              chatId: widget.chatId);
                          print(mess.type);
                          await _chat.createMessage(mess: mess);
                        },
                        child: const Icon(
                          Icons.send,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
