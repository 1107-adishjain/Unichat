// import 'package:firebase_core/firebase_core.dart';
import 'package:flashchat/components/log_and_reg_button.dart';
import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
// import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String loginemail = "";
  String logpsswrd = "";
  bool showspinner = false;

  void showAlertDialog(BuildContext context, String title, String message) {
    Alert(
      context: context,
      title: title,
      desc: message,
    ).show();
  }

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
                    final loginn =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: loginemail,
                      password: logpsswrd,
                    );
                    
                    if (loginn.user != null) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    else  if (loginemail.isEmpty || logpsswrd.isEmpty) {
                      // ignore: use_build_context_synchronously
                      showAlertDialog(context, "Error",
                          "Please enter both email and password.");
                      return;
                    }
                  }
                  on FirebaseAuthException catch (e) {
                    String errorMessage;

                    switch (e.code) {
                      case 'invalid-email':
                        errorMessage = "The email address is not valid.";
                        break;
                      case 'user-disabled':
                        errorMessage = "This user has been disabled.";
                        break;
                      case 'user-not-found':
                        errorMessage = "No user found for this email.";
                        break;
                      case 'wrong-password':
                        errorMessage = "Wrong password entered.";
                        break;
                      default:
                        errorMessage = "An unknown error occurred.";
                    }

                    showAlertDialog(context, "Error", errorMessage);
                  } catch (e) {
                    showAlertDialog(context, "Error", e.toString());
                  }

                  setState(() {
                    showspinner = false;
                  });
                },
                label: "Log In",
                colors: Colors.lightBlueAccent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an Account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showspinner = true;
                      });
                      Navigator.pushNamed(context, RegistrationScreen.id);
                      setState(() {
                        showspinner = false;
                      });
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
