import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/routs.dart';
import 'package:flutter_application_2/pages/notes/crete_update_note_view.dart';
import 'package:flutter_application_2/pages/notes/notes_view.dart';
import 'package:flutter_application_2/pages/login.dart';
import 'package:flutter_application_2/pages/register_user.dart';
import 'package:flutter_application_2/pages/verify.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_event.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_state.dart';
import 'package:flutter_application_2/services/auth/firebase_auth_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const Homepage(),
      ),
      routes: {
        ceateOrUpdateNoteRoute: (Context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(builder: ((context, state) {
      if (state is AuthStateLoggedIn) {
        return const NotesView();
      } else if (state is AuthStateNeedsVerification) {
        return const VerifyEmail();
      } else if (state is AuthStateLoggedOut) {
        return const Login();
      } else if (state is AuthStateRegistering) {
        return const Register();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    }));
  }
}
