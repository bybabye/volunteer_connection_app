import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
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
                        onTap: () async {},
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
}
