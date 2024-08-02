import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User? user;

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String messagentered;
  final messagetextcontroller = TextEditingController();

  @override
  void initState() {
    getCurrentuser();
    super.initState();
  }

  void getCurrentuser() async {
    try {
      final data = FirebaseAuth.instance.currentUser;
      if (data != null) {
        setState(() {
          user = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset:true,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushNamed(context, LoginScreen.id);
              }
            },
          ),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Messagestream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messagetextcontroller,
                      onChanged: (value) {
                        setState(() {
                          messagentered = value;
                        });
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      messagetextcontroller.clear();
                      _firestore.collection("Message").add({
                        "text": messagentered,
                        "sender": user!.email,
                        "timestamp": FieldValue.serverTimestamp(),
                      });
                    },
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Messagestream extends StatelessWidget {
  const Messagestream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("Message")
          .orderBy("timestamp", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data!.docs;
        List<Messagebuble> messageshown = [];
        for (var mess in messages) {
          final messagetext = mess["text"];
          final messagesender = mess["sender"];
          final currentuser = user!.email;
          final text = Messagebuble(
            text: messagetext,
            sender: messagesender,
            itsme: currentuser == messagesender,
          );
          messageshown.add(text);
        }
        return Expanded(
          child: ListView(
            reverse: false,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageshown,
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class Messagebuble extends StatelessWidget {
  Messagebuble(
      {super.key,
      required this.text,
      required this.sender,
      required this.itsme});
  late String text;
  late String sender;
  bool itsme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            itsme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender.length > 10
                ? sender.substring(0, sender.length - 10)
                : sender,
            style: const TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: BorderRadius.only(
                topLeft: itsme
                    ? const Radius.circular(24.0)
                    : const Radius.circular(0),
                topRight: (!itsme)
                    ? const Radius.circular(24.0)
                    : const Radius.circular(0),
                bottomLeft: const Radius.circular(24.0),
                bottomRight: const Radius.circular(24.0)),
            elevation: 5.0,
            color: itsme ? (Colors.lightBlueAccent) : (Colors.white),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16.0,
                    color: itsme ? Colors.white : (Colors.black)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
