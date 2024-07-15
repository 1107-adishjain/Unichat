import 'package:flashchat/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LogAndReg extends StatefulWidget {
  LogAndReg(
      {super.key,
      required this.onpress,
      required this.label,
      required this.colors});
  late VoidCallback onpress;
  late String label;
  late Color colors;
  @override
  State<LogAndReg> createState() => _LogAndRegState();
}

class _LogAndRegState extends State<LogAndReg> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: widget.colors,
        borderRadius:kborderradiusoflogandreg,
        child: MaterialButton(
          onPressed: widget.onpress,
          minWidth: 200.0,
          height: 50.0,
          child: Text(
            widget.label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
