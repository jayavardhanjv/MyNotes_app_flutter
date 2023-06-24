import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/routs.dart';
import 'package:flutter_application_2/enums/menu_action.dart';
import 'package:flutter_application_2/services/auth/auth_service.dart';

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
                    AuthService.firebase().logout();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
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
