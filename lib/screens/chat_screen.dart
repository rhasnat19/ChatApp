// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:messengerchat/widgets/chats/messages.dart';
import 'package:messengerchat/widgets/chats/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Chat"),
        actions: [
          DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                      child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Log out"),
                    ],
                  )),
                  value: 'logout',
                ),
              ],
              onChanged: (val) {
                if (val == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
      //  StreamBuilder<QuerySnapshot>(
      //     stream: FirebaseFirestore.instance
      //         .collection('chats')
      //         .doc('LyTbfJkZLthVbjAetV4B')
      //         .collection('message')
      //         .snapshots(),
      //     builder: (context, streamSnapshot) {
      //       if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       } else {
      //         return ListView.builder(
      //           itemCount: streamSnapshot.data!.docs.length,
      //           itemBuilder: (context, i) => Container(
      //             padding: const EdgeInsets.all(8),
      //             child: Text(streamSnapshot.data!.docs[i]['text']),
      //           ),
      //         );
      //       }
      //     }),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     FirebaseFirestore.instance
      //         .collection('chats')
      //         .doc('LyTbfJkZLthVbjAetV4B')
      //         .collection('message')
      //         .add(
      //       {
      //         'text': 'hasnat here',
      //       },
      //     );
      //   },
      // ),
    );
  }
}
