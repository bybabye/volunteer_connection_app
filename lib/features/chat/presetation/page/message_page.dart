import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_connection/core/routers/navigation_service.dart';

import 'package:volunteer_connection/features/auth/presentation/providers/auth_provider.dart';
import 'package:volunteer_connection/features/chat/domain/entity/chat.dart';
import 'package:volunteer_connection/features/chat/domain/entity/message.dart';
import 'package:volunteer_connection/features/chat/presetation/page/sub_message_page.dart';
import 'package:volunteer_connection/features/chat/presetation/providers/chat_provider.dart';
import 'package:volunteer_connection/features/chat/presetation/providers/socket_provider.dart';
import 'package:volunteer_connection/features/chat/presetation/widgets/custom_message_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:volunteer_connection/themes/app_assets.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class MessagePage extends StatefulWidget {
  const MessagePage(
      {super.key,
      required this.avatar,
      required this.name,
      required this.chat});
  final String avatar;
  final String name;
  final Chat chat;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late double height;
  late double width;
  final TextEditingController _controller = TextEditingController();
  late AuthProvider _auth;
  late ChatProvider _chat;
  late SocketIOProvider _socketIO;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  final NavigationService navigationService =
      GetIt.instance.get<NavigationService>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _socketIO.socket.emit('join-room', {
        'chatId': widget.chat.id,
      });
      _loadMessages();
      _socketIO.setScrollController(_scrollController);
    });
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await _chat.getMessForId(id: widget.chat.id);
      // Cập nhật trạng thái và dữ liệu sau khi tải xong
      setState(() {
        _socketIO.messages = messages;
        _isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } catch (e) {
      print("Error loading messages: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthProvider>(context);
    _chat = Provider.of<ChatProvider>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _socketIO = Provider.of<SocketIOProvider>(context);
    _socketIO.uid = _auth.user.id;
    // kiem tra xem id co trong admin
    bool isCheck = isMember(_auth.user.id);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            widget.chat.type == 'private'
                ? CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.avatar),
                    backgroundColor: Colors.greenAccent[100],
                  )
                : CircleAvatar(
                    radius: 20,
                    backgroundImage: const AssetImage(AppAssets.user),
                    backgroundColor: Colors.greenAccent[100],
                  ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.chat.type == 'private' ? widget.name : "nhóm thiện nguyện",
              style: AppStyles.h2,
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        actions: [
          if (isCheck)
            IconButton(
                onPressed: () {
                  navigationService
                      .navigateToPage(SubMessagePage(chat: widget.chat));
                },
                icon: const Icon(Icons.menu))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.8,
                width: width,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: _socketIO.messages.length,
                        itemBuilder: (_, index) {
                          Message message = _socketIO.messages[index];
                          return CustomMessageText(
                            isUser: message.sender.id == _auth.user.id,
                            avatar: message.sender.avatar,
                            time:
                                timeago.format(message.sentTime, locale: 'vi'),
                            text: message.content,
                            type: message.type,
                          );
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
                          if (_controller.text.isNotEmpty) {
                            Message mess = Message(
                                id: "",
                                type: "text",
                                sender: _auth.user,
                                content: _controller.text,
                                sentTime: DateTime.now(),
                                chatId: widget.chat.id);

                            await _chat.createMessage(mess: mess);
                            _socketIO.sendMessage(widget.chat.id, {
                              "content": _controller.text,
                              "type": "text",
                              "senderId": {
                                "_id": _auth.user.id,
                                "name": _auth.user.name,
                                "avatar": _auth.user.avatar,
                              },
                              "chatId": widget.chat.id,
                              "sentTime": "${DateTime.now()}",
                            });
                            setState(() {
                              _controller.text = "";
                            });
                          }
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

  bool isMember(String id) {
    return widget.chat.administrator.any((user) => user.id == id);
  }
}
