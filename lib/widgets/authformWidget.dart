// ignore_for_file: prefer_const_constructors, unused_local_variable, dead_code

import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String? email,
    String? username,
    String? password,
    bool? isLogin,
    BuildContext? context,
  ) submitFn;
  bool isLoading;
  AuthForm({
    Key? key,
    required this.submitFn,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var isLogin = false;

  @override
  Widget build(BuildContext context) {
    String _userEmail = '';
    String _userPassword = '';
    String _userName = '';

    void _trySubmit() {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      if (isValid) {
        _formKey.currentState!.save();
        widget.submitFn(
          _userEmail,
          _userName,
          _userPassword,
          isLogin,
          context,
        );
      }
    }

    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'sahi email daalo bhai.';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _userEmail = val!;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: Text(
                          "Email Address",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    if (!isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (val) {
                          if (val!.isEmpty || val.length < 4) {
                            return "Please enter atleast 4 numbers";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          _userName = val!;
                        },
                        decoration: InputDecoration(
                          label: Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (val) {
                        if (val!.isEmpty || val.length < 7) {
                          return "Password length must be greater than 7 chrs";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _userPassword = val!;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    widget.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            child: Text(isLogin ? "Login" : "Sign up"),
                            onPressed: _trySubmit,
                          ),
                    if (!widget.isLoading)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          isLogin
                              ? "Create a new account?"
                              : "Already have an account.",
                        ),
                      )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
