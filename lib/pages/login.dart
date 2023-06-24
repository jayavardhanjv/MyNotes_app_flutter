import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer';

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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextFormField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(hintText: "enter the email"),
                  ),
                  TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration:
                        const InputDecoration(hintText: "enter the password"),
                    controller: _password,
                  ),
                  TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;

                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password);

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/dashboard/', (route) => false);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "user-not-found") {
                            log("User not found");
                          } else if (e.code == "wrong-password") {
                            log("Wrong password");
                          } else {
                            log("somthing else happend");
                            log(e.code);
                          }
                        }
                      },
                      child: const Text("press me for login")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/register/', (route) => false);
                      },
                      child:
                          const Text("if you are not registered click here")),
                ],
              );
            default:
              return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
