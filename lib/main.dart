import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone1/resources/auth_methods.dart';
import 'package:zoom_clone1/screens/home_screen.dart';
import 'package:zoom_clone1/screens/login_screen.dart';
import 'package:zoom_clone1/screens/video_call.dart';
import 'package:zoom_clone1/utils/colors.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom Clone',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/Home': (context) => const Home(),
        '/VideoCall': (context) => const VideoCall(),
      },
      home: StreamBuilder(
        stream: AuthMethos().authChanges,
        builder: (context, snabshot) {
          if (snabshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snabshot.hasData) {
            return const Home();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
