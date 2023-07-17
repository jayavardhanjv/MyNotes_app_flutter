import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/routs.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/services/auth/auth_exception.dart';
import 'package:flutter_application_2/services/auth/auth_service.dart';
import 'package:flutter_application_2/utitlities/dialogs/error_dialog.dart';
import 'dart:developer';

import 'package:flutter_application_2/utitlities/showerrordialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "enter the email"),
          ),
          TextFormField(
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(hintText: "enter the password"),
            controller: _password,
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                try {
                  await AuthService.firebase().login(
                    email: email,
                    password: password,
                  );
                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified ?? false) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        notesViewRoute, (route) => false);
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        verifyemailRoute, (route) => false);
                  }
                } on UserNotFoudAuthException {
                  await showErrorDialog(context, 'User Not Found.');
                  log("User not found");
                } on WrongPasswordAuthException {
                  await showErrorDialog(context, 'Wrong password.');
                  log("Wrong credentials");
                } on GenericAuthException {
                  log("somthing else happend");
                  await showErrorDialog(context, "Authentication Error");
                }
              },
              child: const Text("press me for login")),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerroute, (route) => false);
              },
              child: const Text("if you are not registered click here")),
        ],
      ),
    );
    // default:
    //   return const CircularProgressIndicator();
  }
}
