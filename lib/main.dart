// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashchat/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/screens/welcome_screen.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flashchat/screens/chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const  WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}


   // for web
      // apiKey: "AIzaSyDFC-SkBTnpxsfoTDwTCR4nTWexd_m7QMg",
      // authDomain: "flashchat-a671f.firebaseapp.com",
      // projectId: "flashchat-a671f",
      // storageBucket: "flashchat-a671f.appspot.com",
      // messagingSenderId: "148289801259",
      // appId: "1:148289801259:web:fbdca7ef670ca71952ee6e",
      // measurementId: "G-BJHZEXNPEE"


       // for andriod
  // apiKey: "AIzaSyCY5RmE8XuI9S3-vMzRGWwxjTioQXLahcs",
  // projectId: "flashchat-android-b1202",
  // storageBucket: "flashchat-android-b1202.appspot.com",
  // messagingSenderId: "430740862595",
  // appId: "1:430740862595:android:06299b0396e900c6bdcdb6",