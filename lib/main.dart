
import 'package:chat_app/core/utils/routes_manager.dart';
import 'package:chat_app/presentation/auth/login/login_Screen.dart';
import 'package:chat_app/presentation/auth/register/register_screen.dart';
import 'package:chat_app/presentation/ui/Chat/chat_screen.dart';
 import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
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
      routes: {
        RoutesManager.register:(context) => RegisterScreen(),
        RoutesManager.login:(context) => LoginScreen(),
        RoutesManager.home:(context) => ChatPage(),
      },
      initialRoute:    RoutesManager.login,

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


