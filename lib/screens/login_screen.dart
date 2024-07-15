// import 'package:firebase_core/firebase_core.dart';
import 'package:flashchat/components/log_and_reg_button.dart';
import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat_screen.dart';
// import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String loginemail;
  late String logpsswrd;
  bool showspinner = false;
  late User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  loginemail = value;
                },
                decoration: ktextfeilddecoration.copyWith(
                    hintText: "Enter your E-mail"),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  logpsswrd = value;
                },
                decoration: ktextfeilddecoration.copyWith(
                    hintText: "Enter your Password"),
              ),
              const SizedBox(
                height: 24.0,
              ),
              LogAndReg(
                  onpress: () async {
                    setState(() {
                      showspinner = true;
                    });
                    try {
                      final loginn = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: loginemail, password: logpsswrd);

                      if (loginn.user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      } else {}
                      setState(() {
                        showspinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  label: "Log In",
                  colors: Colors.lightBlueAccent)
            ],
          ),
        ),
      ),
    );
  }
}
