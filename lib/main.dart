import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/pages/login.dart';
import 'package:flutter_application_2/pages/register_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_2/pages/verify.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
      routes: {
        '/login/': (context) => const Login(),
        '/register/': (context) => const Register(),
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // final user = FirebaseAuth.instance.currentUser;
            // if (user != null) {
            //   if (user.emailVerified == true) {
            //     print("email is verified");
            //   } else {
            //     // return const VerifyEmail();
            //     print("email is not verified");
            //     return const VerifyEmail();
            //   }
            // } else {
            //   return const Login();
            // }
            return const Login();
          default:
            return const CircularProgressIndicator();
        }
      }),
    );
  }
}
