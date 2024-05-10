import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_connection/features/auth/presentation/pages/register.dart';
import 'package:volunteer_connection/features/auth/presentation/providers/auth_provider.dart';

import 'package:volunteer_connection/features/post/presentation/providers/post_provider.dart';
import 'package:volunteer_connection/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PostProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RegisterPage(),
      ),
    );
  }
}
