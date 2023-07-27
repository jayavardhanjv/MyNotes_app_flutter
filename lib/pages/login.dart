import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/routs.dart';
import 'package:flutter_application_2/services/auth/auth_exception.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_event.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_state.dart';
import 'package:flutter_application_2/utitlities/dialogs/error_dialog.dart';
import 'package:flutter_application_2/utitlities/dialogs/loading_dialog.dart';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        // TODO: implement listener
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoudAuthException) {
            await showErrorDialog(context, 'user not found');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication Error');
          }
        }
      },
      child: Scaffold(
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
                  context.read<AuthBloc>().add(
                        AuthEventLogin(
                          email,
                          password,
                        ),
                      );
                },
                child: const Text("press me for login")),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventShouldRegister());
                },
                child: const Text("if you are not registered click here")),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventForgotPassword(),
                      );
                },
                child: const Text("I forgot my password"))
          ],
        ),
      ),
    );
    // default:
    //   return const CircularProgressIndicator();
  }
}
