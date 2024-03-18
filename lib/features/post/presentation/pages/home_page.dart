import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_connection/features/post/domain/entities/post.dart';
import 'package:volunteer_connection/features/post/presentation/providers/post_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PostProvider _postProvider;
  late double height;
  late double width;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postProvider.getPosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _postProvider = Provider.of<PostProvider>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: posts(),
        ),
      ),
    );
  }

  Widget posts() {
    if (_postProvider.status == PostStatus.loading) {
      return const CircularProgressIndicator();
    } else if (_postProvider.status == PostStatus.failed) {
      return const Text("Lỗi hệ thống");
    } else if (_postProvider.status == PostStatus.success) {
      return ListView.builder(
          itemCount: _postProvider.post.length,
          itemBuilder: (_, i) {
            return Text("${_postProvider.post[i].content}");
          },);
    } else {
      return const Text("Warning");
    }
  }

  Widget createPost() {
    return TextButton(
        onPressed: () async {
          Post p = Post(
              content: "hihi haha",
              id: "",
              images: [
                "https://scontent.fdad3-1.fna.fbcdn.net/v/t39.30808-6/307152152_2290453134463694_437378802726402069_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=5f2048&_nc_ohc=cyj3s8RzG6kAX8y580A&_nc_ht=scontent.fdad3-1.fna&oh=00_AfDUfqOa6ZtoOK0AdV0PpbEVR3MepY7JcFNS7meDWNOtGA&oe=65F7876C"
              ],
              isDeleted: false);
          await _postProvider.createPost(p: p);
        },
        child: const Text("alo"));
  }
}
