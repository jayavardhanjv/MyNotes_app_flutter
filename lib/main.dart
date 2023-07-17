import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/routs.dart';
import 'package:flutter_application_2/pages/notes/crete_update_note_view.dart';
import 'package:flutter_application_2/pages/notes/notes_view.dart';
import 'package:flutter_application_2/pages/login.dart';
import 'package:flutter_application_2/pages/register_user.dart';
import 'package:flutter_application_2/pages/verify.dart';
import 'package:flutter_application_2/services/auth/auth_service.dart';
import 'package:path/path.dart';
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
        loginRoute: (context) => const Login(),
        registerroute: (context) => const Register(),
        notesViewRoute: (context) => const NotesView(),
        verifyemailRoute: (context) => const VerifyEmail(),
        ceateOrUpdateNoteRoute: (Context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmail();
              }
            } else {
              return const Login();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
