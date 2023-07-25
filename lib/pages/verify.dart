import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/routs.dart';
import 'package:flutter_application_2/services/auth/auth_service.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Column(
        children: [
          const Text(
              "we have sent you a email verification please verify your email address"),
          const Text(
              "if you havent got the email adress pess the button below"),
          TextButton(
            onPressed: () async {
              context
                  .read<AuthBloc>()
                  .add(const AuthEvenSendEmailVerification());
            },
            child: const Text("Send Email Verification"),
          ),
          TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(
                      const AuthEventLogout(),
                    );
              },
              child: const Text("Restart"))
        ],
      ),
    );
  }
}
