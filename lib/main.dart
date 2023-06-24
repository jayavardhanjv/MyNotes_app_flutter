import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/pages/login.dart';
import 'package:flutter_application_2/pages/register_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_2/pages/verify.dart';
// import 'dart:developer';

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
        '/dashboard/': (context) => const Dashboard(),
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
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const Dashboard();
              } else {
                // return const VerifyEmail();
                print("email is not verified");
                return const VerifyEmail();
              }
            } else {
              return const Login();
            }
          default:
            return const CircularProgressIndicator();
        }
      }),
    );
  }
}

enum Menuaction { logout }

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          PopupMenuButton<Menuaction>(
            onSelected: (value) async {
              // devtools.log(value.toString());
              switch (value) {
                case Menuaction.logout:
                  final shouldLayout = await showLogOutDialog(context);
                  if (shouldLayout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (route) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<Menuaction>(
                    value: Menuaction.logout, child: Text("Logout")),
              ];
            },
          )
        ],
      ),
      body: const Text("Hello World"),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("signout"),
        content: const Text("Are you sure what want to  logout"),
        actions: [
          TextButton(
              onPressed: (() {
                Navigator.of(context).pop(false);
              }),
              child: const Text("Cancel")),
          TextButton(
              onPressed: (() {
                Navigator.of(context).pop(true);
              }),
              child: const Text("Log out")),
        ],
      );
    },
  ).then((value) => value ?? false);
}
