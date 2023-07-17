import 'package:flutter/cupertino.dart';
import 'package:flutter_application_2/utitlities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Log Out',
      content: 'Are you sure you want to log out?',
      optionsBuilder: () => {
            'cancel': false,
            'Log Out': true,
          }).then(
    (value) => value ?? false,
  );
}
