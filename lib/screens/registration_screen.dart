import 'package:flashchat/components/log_and_reg_button.dart';
import 'package:flashchat/constants.dart';
// import 'package:flashchat/screens/chat_screen.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registartion_screen";
  const RegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // final _auth = FirebaseAuth
  //     .instance; //yeh auth object create krta hai for authentication
  late String email;
  late String password;
  bool showspinner = false;
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
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
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
                  password = value;
                },
                decoration: ktextfeilddecoration.copyWith(
                    hintText: "Enter your Passowrd"),
              ),
              const SizedBox(
                height: 24.0,
              ),
              LogAndReg(
                  onpress: () async {
                    setState(() {
                      showspinner = true;
                    });
                    final cred = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);
                    if (cred.user != null) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, LoginScreen.id);
                    }

                    setState(() {
                      showspinner = false;
                    });
                  },
                  label: "Register",
                  colors: Colors.blueAccent),
                  
            ],
          ),
        ),
      ),
    );
  }
}
