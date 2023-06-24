import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/routs.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/services/auth/auth_exception.dart';
import 'package:flutter_application_2/services/auth/auth_service.dart';
import 'package:flutter_application_2/utitlities/showerrordialog.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
        title: const Text('Register'),
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
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  AuthService.firebase().sendEmailVerisfication();
                  Navigator.of(context).pushNamed(verifyemailRoute);
                } on WeakPasswordAuthException {
                  await showErrorData(context, "Weak Password");
                  print("Weak Password");
                } on EmailAlreadyInUseAuthException {
                  await showErrorData(context, "email alrady in use");
                  print("email alrady in use");
                } on InvalidEmailAuthException {
                  await showErrorData(context, "invalid email");
                  print("invalid email");
                } on GenericAuthException {
                  await showErrorData(context, "Failed to register");
                }
              },
              child: const Text("press me")),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text("If you are alrady login? click here"))
        ],
      ),
    );
  }
}
