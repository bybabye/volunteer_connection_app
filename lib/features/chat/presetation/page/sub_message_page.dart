import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:volunteer_connection/features/chat/domain/entity/chat.dart';
import 'package:volunteer_connection/features/chat/presetation/widgets/custom_chat.dart';
import 'package:volunteer_connection/themes/app_assets.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class SubMessagePage extends StatefulWidget {
  const SubMessagePage({super.key, required this.chat});
  final Chat chat;
  @override
  State<SubMessagePage> createState() => _SubMessagePageState();
}

class _SubMessagePageState extends State<SubMessagePage>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("setting"),
        elevation: 1,
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
              text: "Quản trị viên",
            ),
            Tab(
              text: "Phê duyệt",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          ListView.builder(
              itemCount: widget.chat.administrator.length,
              itemBuilder: (_, index) {
                return CustomChat(
                    nameGruop: widget.chat.administrator[index].name,
                    lassMess: "",
                    avatar: widget.chat.administrator[index].avatar);
              }),
          ListView.builder(
              itemCount: widget.chat.pending.length,
              itemBuilder: (_, index) {
                return customApprove(
                    name: widget.chat.pending[index].name,
                    email: widget.chat.pending[index].email,
                    avatar: widget.chat.pending[index].avatar);
              }),
        ],
      ),
    );
  }

  Widget customApprove(
      {required String avatar, required String email, required String name}) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: const ActionPane(motion: ScrollMotion(), children: [
        SlidableAction(
          // An action can be bigger than the others.
          flex: 2,
          onPressed: () {},
          backgroundColor: Color(0xFF7BC043),
          foregroundColor: Colors.white,
          icon: Icons.archive,
          label: 'Archive',
        ),
        SlidableAction(
          onPressed: () {},
          backgroundColor: Color(0xFF0392CF),
          foregroundColor: Colors.white,
          icon: Icons.save,
          label: 'Save',
        ),
      ]),
      child: Padding(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: AppStyles.h3,
                  ),
                  if (email != "") Text(email)
                ],
              ),
            ],
          )),
    );
  }
}
