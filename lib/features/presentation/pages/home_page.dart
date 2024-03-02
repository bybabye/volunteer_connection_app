import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_connection/features/presentation/providers/post/post_provider.dart';

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
      return const Text("Failed");
    } else if (_postProvider.status == PostStatus.success) {
      return const Text("co data");
    } else {
      return const Text("Warning");
    }
  }
}
