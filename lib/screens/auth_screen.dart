// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messengerchat/screens/chat_screen.dart';
import 'package:messengerchat/widgets/authformWidget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  _submitAuthForm(
    String? email,
    String? username,
    String? password,
    bool? isLogin,
    BuildContext? context,
  ) async {
    UserCredential result;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin!) {
        result = await _auth.signInWithEmailAndPassword(
            email: email!, password: password!);
        Navigator.of(context!)
            .push(MaterialPageRoute(builder: (context) => ChatScreen()));
      } else {
        result = await _auth.createUserWithEmailAndPassword(
            email: email!, password: password!);
      }

      await FirebaseFirestore.instance
          .collection('user')
          .doc(result.user!.uid())
          .set({
        'username': username,
        'email': email,
      });
    } on PlatformException catch (err) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print(err.toString());
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AuthForm(
        submitFn: _submitAuthForm,
        isLoading: isLoading,
      ),
    );
  }
}
