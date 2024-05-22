import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_connection/core/routers/navigation_service.dart';
import 'package:volunteer_connection/core/routers/routes.dart';
import 'package:volunteer_connection/features/auth/presentation/pages/login_page.dart';
import 'package:volunteer_connection/features/auth/presentation/pages/register.dart';
import 'package:volunteer_connection/features/auth/presentation/providers/auth_provider.dart';
import 'package:volunteer_connection/features/chat/presetation/providers/chat_provider.dart';
import 'package:volunteer_connection/features/setting/presentation/pages/profile_page.dart';
import 'package:volunteer_connection/pages/homepage.dart';
import 'package:volunteer_connection/pages/test_image.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NavigationService().setupLocator();
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
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        navigatorKey: locator<NavigationService>().navigatorKey,
        initialRoute: Routes.login,
        routes: {
          "test": (_) => const TestImage(),
          Routes.login: (_) => const LoginPage(),
          Routes.register: (_) => const RegisterPage(),
          Routes.home: (_) => const HomePage(),
          Routes.profile: (_) => const ProfilePage()
        },
      ),
    );
  }
}
