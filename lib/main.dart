import 'package:chattapp/Login/login_screen.dart';
import 'package:chattapp/chat/chat_screen.dart';
import 'package:chattapp/home/home_screen.dart';
import 'package:chattapp/provider/user_provider.dart';
import 'package:chattapp/register/register_screen.dart';
import 'package:chattapp/ui/add_room/add_room_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: userProvider.firebaseUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      routes: {
        Register_Screen.routeName: (context) => Register_Screen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddRoom.routeName: (context) => AddRoom(),
        ChatScreen.routeName: (context) => ChatScreen(),
      },
    );
  }
}
