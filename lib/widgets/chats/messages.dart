// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messengerchat/widgets/chats/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .doc(futureSnapshot.data!.uid())
                .collection('messages')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                reverse: true,
                itemCount: chatSnapshot.data!.docs.length,
                itemBuilder: (ctx, index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MessageBubble(
                    message: chatSnapshot.data!.docs[index]['text'],
                    userName: chatSnapshot.data!.docs[index]['username'],
                    isMe: chatSnapshot.data!.docs[index]['userId'] ==
                            futureSnapshot.data!.uid()
                        ? true
                        : false,
                    key: ValueKey(chatSnapshot.data!.docs[index].id),
                  ),
                ),
              );
            },
          );
        });
  }
}
