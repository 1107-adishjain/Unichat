import 'package:flashchat/constants.dart';
import 'package:flashchat/components/log_and_reg_button.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "Welcome_screen";
  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: controller.value * 100,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                AnimatedTextKit(
                  pause: const Duration(seconds: 1),
                  onTap: () {},
                  totalRepeatCount: 2,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Flash Chat",
                      textStyle: kflashchatsyle,
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            LogAndReg(
              onpress: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              label: "Log In",
              colors: Colors.lightBlueAccent,
            ),
            LogAndReg(
              onpress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              label: "Register",
              colors: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}




    // we need an animation variable and curvedanimation constructor through which we can have different kind of curve!
    //parents means kispe wo animation apply hoga i.e animation controller;
    // animation = CurvedAnimation(
    //     parent: controller,
    //     curve: Curves
    //         .decelerate); //if u are using animation then there should be no upper bound;

// yeh uss time me jab bada krna hai jab chota krna hai
    // animation.addStatusListener((status) {
    //   //yeh status dekh ke btayega!! ki end tak phoch gaye ya nahi!!
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });