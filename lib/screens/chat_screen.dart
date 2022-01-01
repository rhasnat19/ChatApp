import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, i) => Container(
          padding: const EdgeInsets.all(8),
          child: const Text("This Works"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats')
              .doc('LyTbfJkZLthVbjAetV4B')
              .collection('message')
              .snapshots()
              .listen((event) {
            if (kDebugMode) {
              print(event);
            }
          });
        },
      ),
    );
  }
}
