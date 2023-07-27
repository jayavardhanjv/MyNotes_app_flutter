// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_event.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_state.dart';
import 'package:flutter_application_2/utitlities/dialogs/error_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utitlities/dialogs/password_reeset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(context,
                'we could not process your request. Please make sure that you are a register user, or if not , register a user now by going back one step.');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                  'If you forgot your password, simple enter your email and we will send you your password'),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'your email adress...',
                ),
              ),
              TextButton(
                onPressed: () {
                  final email = _controller.text;
                  context.read<AuthBloc>().add(
                        AuthEventForgotPassword(email: email),
                      );
                },
                child: const Text('Send me password Reset link'),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventLogout(),
                      );
                },
                child: const Text('Back to login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
